import 'dart:async';
import 'dart:typed_data';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSwitch extends StatelessWidget {
  String item1;
  String item2;
  bool isColored;
  int selected;
  FutureOr<void> Function(int) onChange;

  CustomSwitch({
    required this.selected,
    required this.item1,
    required this.item2,
    this.isColored = false,
    required this.onChange
  });
  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<int>.rolling(
        current: selected,
        onChanged:onChange,
        values: [0, 1],
        iconList: [
          SvgPicture.asset(
            item1,
            height: 35,
            width: 35,
            colorFilter:
            isColored
                ? ColorFilter.mode(
              selected == 0
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.primary,
              BlendMode.srcIn,
            )
                : null,
          ),
          SvgPicture.asset(
            item2,
            height: 35,
            width: 35,
            colorFilter:
            isColored
                ? ColorFilter.mode(
              selected == 1
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.primary,
              BlendMode.srcIn,
            )
                : null,
          ),
        ],
        iconOpacity: 1,
        inactiveOpacity: 1,
        style: ToggleStyle(
          borderColor: Theme.of(context).colorScheme.primary,
          indicatorColor: Theme.of(context).colorScheme.primary,
        ),
      );;
  }
}
