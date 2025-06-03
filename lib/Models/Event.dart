import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String? id;
  String? title;
  String? description;
  String? type;
  String? userId;
  Timestamp? date;
  double? latitude;
  double? longitude;
  List<String>? favoriteUsers;

  Event({
    this.id,
    this.title,
    this.description,
    this.type,
    this.date,
    this.longitude,
    this.latitude,
    this.userId,
    this.favoriteUsers,
  });

  Event.fromFireStore(Map<String, dynamic>? data) {
    id = data?['id'];
    title = data?['title'];
    userId = data?['userId'];
    description = data?['description'];
    type = data?['type'];
    date = data?['date'];
    latitude = data?['latitude'];
    longitude = data?['longitude'];
    favoriteUsers = data?['favoriteUsers'] == null ? null : List<String>.from(data!['favoriteUsers']);
  }

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "type": type,
      "date": date,
      "longitude": longitude,
      "latitude": latitude,
      "userId": userId,
      "favoriteUsers": favoriteUsers,
    };
  }
}
