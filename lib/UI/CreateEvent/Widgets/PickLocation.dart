import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Core/resources/StringsManger.dart';
import 'package:evently/Providers/MapPickerProvider.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../Providers/DetailsProvider.dart';

class PickLocation extends StatefulWidget {
  static const String routeName = 'pickLocation';

  const PickLocation({super.key});

  @override
  State<PickLocation> createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  @override
  Widget build(BuildContext context) {
    MapPickerProvider mapPickerProvider = Provider.of<MapPickerProvider>(
      context,
    );
    DetailsProvider detailsProvider = Provider.of<DetailsProvider>(
      context,

    );
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onTap: (argument) async{
                mapPickerProvider.changeLocation(argument);
                setState(() {
                });
                List<Placemark> placeMarks = await placemarkFromCoordinates(
                  mapPickerProvider.eventLocation?.latitude ?? 0,
                  mapPickerProvider.eventLocation?.longitude ?? 0,
                );
                mapPickerProvider.savePlaceMark(placeMarks[0]);
                Navigator.pop(context);
              },
              initialCameraPosition: mapPickerProvider.cameraPosition,
              onMapCreated: (controller) {
                mapPickerProvider.googleMapController = controller;

              },
              mapType: MapType.normal,
              markers: mapPickerProvider.markers,
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            color: Theme.of(context).colorScheme.primary,
            padding: EdgeInsets.all(16),
            child: Text(
              StringsManger.tapLocation.tr(),
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ],
      ),
    );
  }
}
