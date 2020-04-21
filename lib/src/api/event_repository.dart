import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventRepository {
  final eventCollection = Firestore.instance.collection('events');

  Future<void> addEvent(newEvent) async {
    eventCollection.document().setData(newEvent);
  }

  Future<void> deleteEvent(eventId) async {
    eventCollection.document(eventId).delete();
  }

  Future<void> editEvent(eventId, editedEvent) async {
    eventCollection.document(eventId).updateData(editedEvent);
  }

  Future<List<Map>> getTodaysEvent() async {
    return [];
  }
}