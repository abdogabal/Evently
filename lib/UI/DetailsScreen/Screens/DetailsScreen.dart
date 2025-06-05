import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Core/DialogUtils.dart';
import 'package:evently/Core/resources/AssetsManger.dart';
import 'package:evently/Core/resources/StringsManger.dart';
import 'package:evently/Models/Event.dart';
import 'package:evently/UI/CreateEvent/Screen/CreateEventScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../Core/Reusable_Component/CustomDetials.dart';
import '../../../Providers/DetailsProvider.dart';
import '../../../Providers/UserProvider.dart';
import '../../EditEvent/Screen/EditEventScreen.dart';

class DetailsScreen extends StatefulWidget {
  static const String routeName = 'details';

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Event event;

  Future<void> deleteEvent() async {
    try {
      await FirebaseFirestore.instance
          .collection('Event')
          .doc(event.id)
          .delete();

      Navigator.pop(context);
      DialogUtils.showSnackBar(StringsManger.addEventSuccess);
    } catch (e) {
      DialogUtils.showMassageDialog(
        context: context,
        massage: e.toString(),
        posTitle: 'Error',
        posClick: () {
          Navigator.pop(context);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider provider = Provider.of<UserProvider>(context);
    DetailsProvider detailsProvider = Provider.of<DetailsProvider>(context);
    event = ModalRoute.of(context)!.settings.arguments as Event;
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
        titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
        foregroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          Visibility(
            visible: event.userId == provider.myUser?.id,
            child: IconButton(
              onPressed: () {
                detailsProvider.getEventLocation(event.latitude!, event.longitude!);
                detailsProvider.getEvent(event);
                Navigator.pushNamed(context, EditEventScreen.routeName,arguments: event);

              },
              icon: SvgPicture.asset(AssetsManger.edit),
            ),
          ),
          Visibility(
            visible: event.userId == provider.myUser?.id,
            child: IconButton(
              onPressed: () async {
                await deleteEvent();
              },
              icon: SvgPicture.asset(AssetsManger.delete),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(checkEventImage(), fit: BoxFit.cover),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  event.title ?? '',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 24,
                  ),
                ),
              ),
              CustomDetails(
                main: DateFormat('dd MMMM yyyy').format(event.date!.toDate()),
                sup: DateFormat('hh:mm a').format(event.date!.toDate()),
                calendar: true,
              ),
              CustomDetails(
                main:
                    '${detailsProvider.placeMark?.name} , ${detailsProvider.placeMark?.country}',
                calendar: false,
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.34,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: GoogleMap(
                  scrollGesturesEnabled: false,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: false,
                  rotateGesturesEnabled: false,

                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      event.latitude ?? 0.0,
                      event.longitude ?? 0.0,
                    ),
                    zoom: 14.0,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId(StringsManger.eventLocations),
                      position: LatLng(
                        event.latitude ?? 0.0,
                        event.longitude ?? 0.0,
                      ),
                      infoWindow: InfoWindow(title: event.title ?? 'Event'),
                    ),
                  },
                ),
              ),
              Text(
                StringsManger.desc.tr(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                event.description ?? '',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String checkEventImage() {
    if (event.type == 'sport') {
      return AssetsManger.sport;
    } else if (event.type == 'book') {
      return AssetsManger.bookClub;
    } else {
      return AssetsManger.birthday;
    }
  }
}
