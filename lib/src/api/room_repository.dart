import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomRepository {
  final eventCollection = Firestore.instance.collection('events');
  final roomCollection = Firestore.instance.collection('rooms');

  Future<void> addEvent(newEvent) async {
    eventCollection.document().setData(newEvent);
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
    print(result);
    return result;
  }
}