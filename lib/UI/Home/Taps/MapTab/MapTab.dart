import 'package:evently/Core/resources/ColorManger.dart';
import 'package:evently/Providers/MapsProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapTab extends StatelessWidget {
  const MapTab({super.key});

  @override
  Widget build(BuildContext context) {
    MapsProvider provider = Provider.of<MapsProvider>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManger.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Icon(
          Icons.gps_fixed,
          color: Theme.of(context).colorScheme.onTertiary,
        ),
        onPressed: () {
          provider.getLocation();
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: provider.cameraPosition,
              onMapCreated: (controller) {
                provider.googleMapController = controller;
              },
              mapType: MapType.normal,
              markers: provider.markers,
            ),
          ),
        ],
      ),
    );
  }
}
