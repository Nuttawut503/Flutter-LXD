import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomRepository {
  final eventCollection = Firestore.instance.collection('events');
  final roomCollection = Firestore.instance.collection('rooms');

  Future<void> addEvent({
    String reserverId, String title, String detail, List tags, String roomId, 
    DateTime selectedDate, DateTime startTime, DateTime endTime,
  }) async {
    eventCollection.document().setData({
      'title': title.toString(),
      'detail': detail.toString(),
      'tags': tags.toList(),
      'room_id': roomId.toString(),
      'schedule': {
        'start_time': DateTime(selectedDate.year, selectedDate.month, selectedDate.day, startTime.hour, startTime.minute, 0, 0, 0),
        'end_time': DateTime(selectedDate.year, selectedDate.month, selectedDate.day, endTime.hour, endTime.minute, 0, 0, 0)
      },
      'reserver_id': reserverId.toString()
    });
  }

  Future<void> deleteEvent(eventId) async {
    eventCollection.document(eventId).delete();
  }

  Future<void> editEvent(eventId, editedEvent) async {
    eventCollection.document(eventId).updateData(editedEvent);
  }

  Future<List<Map>> getAllRoomList() async {
    List<Map> result = [];
    final roomSnapshot = await roomCollection.orderBy('id').getDocuments();
    roomSnapshot.documents.forEach((doc) {
      result.add(doc.data);
    });
    return result;
  }

  Future<bool> isTimeOverlapped({int roomId, DateTime selectedDate, DateTime startTime, DateTime endTime}) async {
    final DateTime sTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, startTime.hour, startTime.minute, 0, 0, 0);
    final DateTime eTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, endTime.hour, endTime.minute, 0, 0, 0);
    // print(DateTime.fromMillisecondsSinceEpoch(element.data['schedule']['start_time'].seconds * 1000));
    final List allEvents = (await eventCollection
                          .where('room_id', isEqualTo: roomId.toString())
                          .orderBy('schedule.start_time')
                          .getDocuments()).documents;
    int l = 0, r = allEvents.length - 1;
    int mEvent;
    while (l <= r) {
      int m = ((l + r) ~/ 2);
      DateTime mEventDate = DateTime.fromMillisecondsSinceEpoch(allEvents[m].data['schedule']['start_time'].seconds * 1000);
      if (selectedDate.year == mEventDate.year && selectedDate.month == mEventDate.month && selectedDate.day == mEventDate.day) {
        mEvent = m;
        break;
      } else if (selectedDate.isBefore(mEventDate)) {
        r = m - 1;
      } else {
        l = m + 1;
      }
    }
    if (mEvent == null) return false;
    l = mEvent;
    r = mEvent + 1;
    while (l >= 0) {
      DateTime eventSTime = DateTime.fromMillisecondsSinceEpoch(allEvents[l].data['schedule']['start_time'].seconds * 1000);
      if (eventSTime.year != sTime.year || eventSTime.month != sTime.month || eventSTime.day != sTime.day) break;
      DateTime eventETime = DateTime.fromMillisecondsSinceEpoch(allEvents[l].data['schedule']['end_time'].seconds * 1000);
      if (overlapped(sTime, eTime, eventSTime, eventETime)) return true;
      --l;
    }
    while (r < allEvents.length) {
      DateTime eventSTime = DateTime.fromMillisecondsSinceEpoch(allEvents[r].data['schedule']['start_time'].seconds * 1000);
      if (eventSTime.year != sTime.year || eventSTime.month != sTime.month || eventSTime.day != sTime.day) break;
      DateTime eventETime = DateTime.fromMillisecondsSinceEpoch(allEvents[r].data['schedule']['end_time'].seconds * 1000);
      if (overlapped(sTime, eTime, eventSTime, eventETime)) return true;
      ++r;
    }
    return false;
  }

  bool overlapped(DateTime s1, DateTime e1, DateTime s2, DateTime e2) {
    if (s1.isBefore(e2) && !s1.isBefore(s2)) return true;
    if (e1.isAfter(s2) && !e1.isAfter(e2)) return true;
    if (!s1.isAfter(s2) && !e1.isBefore(e2)) return true;
    return false;
  }
}
