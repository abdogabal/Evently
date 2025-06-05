import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Models/Event.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Core/resources/StringsManger.dart';

class DetailsProvider extends ChangeNotifier{

  Placemark? placeMark;
  Event? event;

  Set<Marker> markers = {};
  getEventLocation(double latitude,double longitude) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(
      latitude ?? 0,
      longitude ?? 0,
    );
    placeMark = placeMarks.first;
    notifyListeners();
  }
  getEvent(Event eventData){
    event=eventData;
  }

}