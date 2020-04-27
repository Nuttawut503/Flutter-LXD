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
    final bool isStuck1 = ((await roomCollection
                          .where('room_id', isEqualTo: roomId.toString())
                          .where('schedule.startTime', isGreaterThan: sTime)
                          .where('schedule.startTime', isLessThan: eTime)
                          .getDocuments()).documents.length != 0);
    final bool isStuck2 = ((await roomCollection
                          .where('room_id', isEqualTo: roomId.toString())
                          .where('schedule.endTime', isGreaterThan: sTime)
                          .where('schedule.endTime', isLessThan: eTime)
                          .getDocuments()).documents.length != 0);
    return (isStuck1 && isStuck2);
  }
}