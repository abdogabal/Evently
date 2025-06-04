import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class DetailsProvider extends ChangeNotifier{

  Placemark? placeMark;
  getEventLocation(double latitude,double longitude) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(
      latitude ?? 0,
      longitude ?? 0,
    );
    placeMark = placeMarks.first;
    notifyListeners();
  }
}