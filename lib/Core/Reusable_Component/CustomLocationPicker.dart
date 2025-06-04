import 'package:evently/Core/resources/ColorManger.dart';
import 'package:flutter/material.dart';

class CustomLocationPicker extends StatelessWidget {
  void Function() onClick;
  String locations;


  CustomLocationPicker({required this.onClick, required this.locations});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,

      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(8),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
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
                  child: Icon(
                    Icons.gps_fixed,
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    locations,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
