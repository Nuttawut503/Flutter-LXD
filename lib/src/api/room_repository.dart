import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:LXD/src/api/event_repository.dart';

class RoomRepository {
  final roomCollection = Firestore.instance.collection('rooms');
  final _eventRepository = EventRepository();

  Future<List<Map>> getAllRoomList() async {
    List<Map> result = [];
    final roomSnapshot = await roomCollection.orderBy('id').getDocuments();
    roomSnapshot.documents.forEach((doc) {
      result.add(doc.data);
    });
    return result;
  }

  Future<String> getRoomNameById(roomId) async {
    return (await roomCollection.where('id', isEqualTo: roomId).getDocuments()).documents[0].data['name'];
  }

  Future<bool> isRoomTimeOverlapped({int roomId, DateTime selectedDate, DateTime startTime, DateTime endTime}) async {
    final DateTime sTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, startTime.hour, startTime.minute, 0, 0, 0);
    final DateTime eTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, endTime.hour, endTime.minute, 0, 0, 0);

    return (await _eventRepository.hasEventTimeOverlapped(
      roomId: roomId,
      selectedDate: selectedDate,
      startTime: sTime,
      endTime: eTime
    ));
  }
}
