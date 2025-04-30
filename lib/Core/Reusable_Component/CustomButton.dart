import 'package:evently/Core/resources/ColorManger.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String title;
  void Function() onClick;

  CustomButton({required this.title, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      onPressed:onClick,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 13),
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
        )

      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
