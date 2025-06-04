import 'package:evently/Core/resources/AssetsManger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDetails extends StatelessWidget {
  bool calendar;
  String main;
  String sup;
  String icon;

  CustomDetails({
    this.calendar = true,
    required this.main,
    this.sup = '',
    this.icon = AssetsManger.calender,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: List.empty(),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  height: 46,
                  width: 46,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  padding: EdgeInsets.all(12),
                  child:
                      calendar
                          ? SvgPicture.asset(
                            icon,
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).colorScheme.onTertiary,
                              BlendMode.srcIn,
                            ),
                          )
                          : Icon(
                            Icons.gps_fixed,
                            color: Theme.of(context).colorScheme.onTertiary,
                          ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        main,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Visibility(
                        visible: sup!='',
                        child: Text(
                         sup,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ],
                  )
                ),
              ],
            ),
          ),
          Visibility(
            visible: !calendar,
            child: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
