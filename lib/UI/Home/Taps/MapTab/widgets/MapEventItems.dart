import 'package:evently/Models/Event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

import '../../../../../Core/resources/AssetsManger.dart';
import '../../../../../Core/resources/ColorManger.dart';
import '../../../../../Providers/MapsProvider.dart';

class MapEventItems extends StatefulWidget {
  Event event;

  MapEventItems(this.event);

  @override
  State<MapEventItems> createState() => _MapEventItemsState();
}

class _MapEventItemsState extends State<MapEventItems> {
  Placemark? placeMark;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEventLocation();
  }

  @override
  Widget build(BuildContext context) {
    MapsProvider mapsProvider = Provider.of<MapsProvider>(context);
    return InkWell(
      onTap: () {
        mapsProvider.changeCameraPosition(
          widget.event.latitude!,
          widget.event.longitude!,
          widget.event.title!
        );
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).colorScheme.primary),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 8,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(checkEventImage()),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.3,
                  ),
                  child: Text(
                    widget.event.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      AssetsManger.map,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.onSecondary,
                        BlendMode.srcIn,
                      ),
                    ),
                    placeMark == null
                        ? Center(
                          child: CircularProgressIndicator(
                            color: ColorManger.white,
                            constraints: BoxConstraints(
                              maxHeight: 15,
                              maxWidth: 15,
                              minHeight: 15,
                              minWidth: 15,
                            ),
                          ),
                        )
                        : Text(
                          '${placeMark?.name} , ${placeMark?.country}',
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          textAlign: TextAlign.start,
                        ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String checkEventImage() {
    if (widget.event.type == 'sport') {
      return AssetsManger.sport;
    } else if (widget.event.type == 'book') {
      return AssetsManger.bookClub;
    } else {
      return AssetsManger.birthday;
    }
  }

  getEventLocation() async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(
      widget.event.latitude ?? 0,
      widget.event.longitude ?? 0,
    );
    placeMark = placeMarks.first;
    setState(() {});
  }
}
