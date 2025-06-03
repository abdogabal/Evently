import 'dart:ffi';

import 'package:evently/Core/resources/AssetsManger.dart';
import 'package:evently/Core/resources/ColorManger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventItems extends StatefulWidget {
  EventItems({super.key});

  @override
  State<EventItems> createState() => _EventItemsState();
}

class _EventItemsState extends State<EventItems> {
  bool love = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        image: DecorationImage(
          image: AssetImage(AssetsManger.sport),
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
                    '7',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Text(
                    'Nov',
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
                    'This is a Birthday Party',
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
    );
  }
}
