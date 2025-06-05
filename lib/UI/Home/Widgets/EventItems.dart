import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Core/resources/AssetsManger.dart';
import 'package:evently/Core/resources/ColorManger.dart';
import 'package:evently/Models/Event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../Providers/DetailsProvider.dart';
import '../../DetailsScreen/Screens/DetailsScreen.dart';

class EventItems extends StatefulWidget {
  final Event event;

   EventItems(this.event, {super.key});

  @override
  State<EventItems> createState() => _EventItemsState();
}

class _EventItemsState extends State<EventItems> {
  bool love = false;

  @override
  Widget build(BuildContext context) {
    DetailsProvider detailsProvider= Provider.of<DetailsProvider>(context);

    return InkWell(
      onTap: (){
        detailsProvider.getEventLocation(widget.event.latitude!, widget.event.longitude!);
        Navigator.pushNamed(context, DetailsScreen.routeName,arguments: widget.event);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          image: DecorationImage(
            image: AssetImage(checkEventImage()),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.onTertiary,
                ),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Column(
                  children: [
                    Text(
                      DateFormat.d().format(widget.event.date!.toDate()),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Text(
                      DateFormat.MMM().format(widget.event.date!.toDate()),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.onTertiary,
              ),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.event.title!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {

                        setState(() {
                          love = !love;
                        });
                    },
                    child: SvgPicture.asset(
                      love ? AssetsManger.selectHeart : AssetsManger.heart,
                      colorFilter: ColorFilter.mode(
                        ColorManger.blue,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
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
}
