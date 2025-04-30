import 'package:evently/Core/Reusable_Component/CustomButton.dart';
import 'package:evently/Core/Reusable_Component/CustomSwitch.dart';
import 'package:evently/Core/resources/AppStyle.dart';
import 'package:evently/Core/resources/AssetsManger.dart';
import 'package:evently/Core/resources/ColorManger.dart';
import 'package:evently/Core/resources/StringsManger.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  static const routeName = 'Start';

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int selectedLanguage = 0;

  int selectedTheme = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AssetsManger.logoBar, height: 50, width: 150),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.asset(
                Theme.of(context).colorScheme.brightness == Brightness.dark
                    ? AssetsManger.startDark
                    : AssetsManger.startLight,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 28),
            Text(
              StringsManger.startTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 28),
            Text(
              StringsManger.startDescription,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringsManger.language,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                CustomSwitch(
                  item1: AssetsManger.us,
                  item2: AssetsManger.eg,
                  selected: selectedLanguage,
                  onChange: (value) {
                    setState(() {
                      selectedLanguage = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringsManger.theme,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),

                CustomSwitch(
                  item1: AssetsManger.sun,
                  item2: AssetsManger.moon,
                  isColored: true,
                  selected: selectedTheme,
                  onChange: (value) {
                    setState(() {
                      selectedTheme = value;
                      selectedLanguage == 1
                          ? AppStyle.themeMode = ThemeMode.dark
                          : AppStyle.themeMode = ThemeMode.light;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 28),
            CustomButton(title: StringsManger.begin, onClick: () {}),
          ],
        ),
      ),
    );
  }
}
