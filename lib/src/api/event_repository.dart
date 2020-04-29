import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventRepository {
  final _eventCollection = Firestore.instance.collection('events');

  Future<void> addEvent({
    String reserverId, String title, String detail, List tags, String roomId, 
    DateTime selectedDate, DateTime startTime, DateTime endTime,
  }) async {
    _eventCollection.document().setData({
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
    _eventCollection.document(eventId).delete();
  }

  Future<void> editEvent(eventId, editedEvent) async {
    _eventCollection.document(eventId).updateData(editedEvent);
  }

  Future<bool> hasEventTimeOverlapped({int roomId, DateTime selectedDate, DateTime startTime, DateTime endTime}) async {
    final List allEvents = (await _eventCollection
                          .where('room_id', isEqualTo: roomId.toString())
                          .orderBy('schedule.start_time')
                          .getDocuments()).documents;
    int l = 0, r = allEvents.length - 1, mEvent;
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
      if (eventSTime.year != startTime.year || eventSTime.month != startTime.month || eventSTime.day != startTime.day) break;
      DateTime eventETime = DateTime.fromMillisecondsSinceEpoch(allEvents[l].data['schedule']['end_time'].seconds * 1000);
      if (_overlapped(startTime, endTime, eventSTime, eventETime)) return true;
      --l;
    }
    while (r < allEvents.length) {
      DateTime eventSTime = DateTime.fromMillisecondsSinceEpoch(allEvents[r].data['schedule']['start_time'].seconds * 1000);
      if (eventSTime.year != startTime.year || eventSTime.month != startTime.month || eventSTime.day != startTime.day) break;
      DateTime eventETime = DateTime.fromMillisecondsSinceEpoch(allEvents[r].data['schedule']['end_time'].seconds * 1000);
      if (_overlapped(startTime, endTime, eventSTime, eventETime)) return true;
      ++r;
    }
    return false;
  }

  bool _overlapped(DateTime s1, DateTime e1, DateTime s2, DateTime e2) {
    return s1.isBefore(e2) && s2.isBefore(e1);
  }
}
