import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Models/Event.dart';
import 'package:evently/Models/User.dart';

class FirestoreHandler {
  static CollectionReference<User> getUserCollection() {
    var collection = FirebaseFirestore.instance
        .collection("User")
        .withConverter(
          fromFirestore: (snapshot, options) {
            Map<String, dynamic>? data = snapshot.data();
            return User.fromFireStore(data);
          },
          toFirestore: (user, options) {
            return user.toFireStore();
          },
        );
    return collection;
  }

  static Future<void> addUser(User user) {
    var collection = getUserCollection();
    var document = collection.doc(user.id);
    return document.set(user);
  }

  static Future<User?> getUser(String userID) async {
    var collection = getUserCollection();
    var document = collection.doc(userID);
    var snapshot = await document.get();
    return snapshot.data();
  }

  static CollectionReference<Event> getEventCollection() {
    var collection = FirebaseFirestore.instance
        .collection("Event")
        .withConverter(
          fromFirestore: (snapshot, options) {
            Map<String, dynamic>? data = snapshot.data();
            return Event.fromFireStore(data);
          },
          toFirestore: (event, options) {
            return event.toFireStore();
          },
        );
    return collection;
  }

  static Future<void> addEvent(Event event) {
    var collection = getEventCollection();
    var document = collection.doc();
    event.id = document.id;
    return document.set(event);
  }

  static Future<List<Event>> getAllEvents() async {
    var collection = getEventCollection();
    var snapshot = await collection.get();
    var document = snapshot.docs;
    var eventList = document.map((doc) => doc.data()).toList();
    return eventList;
  }

  static Stream<List<Event>> getAllEventsStream() async* {
    var collection = getEventCollection();
    var stream = collection.snapshots();
    var eventStream = stream.map((snapshot) {
      var document = snapshot.docs;
      var eventList = document.map((doc) => doc.data()).toList();
      return eventList;
    });
    yield* eventStream;
  }

  static Stream<List<Event>> getEventsStream(String type) async* {
    var collection = getEventCollection().where("type", isEqualTo: type);
    var stream = collection.snapshots();
    var eventStream = stream.map((snapshot) {
      var document = snapshot.docs;
      var eventList = document.map((doc) => doc.data()).toList();
      return eventList;
    });
    yield* eventStream;
  }

  static Future<List<Event>> getEvents(String type) async {
    var collection = getEventCollection().where("type", isEqualTo: type);
    var snapshot = await collection.get();
    var document = snapshot.docs;
    var eventList = document.map((doc) => doc.data()).toList();
    return eventList;
  }
}
