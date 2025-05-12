import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Core/PrefsManager.dart';
import 'package:evently/Core/Reusable_Component/CustomButton.dart';
import 'package:evently/Core/Reusable_Component/CustomSwitch.dart';
import 'package:evently/Core/resources/AppStyle.dart';
import 'package:evently/Core/resources/AssetsManger.dart';
import 'package:evently/Core/resources/StringsManger.dart';
import 'package:evently/Providers/ThemeProvider.dart';
import 'package:evently/UI/Login/Screens/Login_Screen.dart';
import 'package:evently/UI/Onboarding/Screens/Onboarding_Screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    ThemeProviders provider = Provider.of<ThemeProviders>(context);
    PrefsManager.getTheme() ? selectedTheme = 1 : selectedTheme = 0;
    context.locale.toString() == 'ar'
        ? selectedLanguage = 1
        : selectedLanguage = 0;
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
              StringsManger.startTitle.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 28),
            Text(
              StringsManger.startDescription.tr(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringsManger.language.tr(),
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
                      if (selectedLanguage == 1) {
                        context.setLocale(Locale('ar'));
                      } else {
                        context.setLocale(Locale('en'));
                      }
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
                  StringsManger.theme.tr(),
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
                      if (selectedTheme == 1) {
                        PrefsManager.setTheme(true);
                        provider.changeTheme(ThemeMode.dark);
                      } else {
                        PrefsManager.setTheme(false);
                        provider.changeTheme(ThemeMode.light);
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 28),
            CustomButton(
              title: StringsManger.begin.tr(),
              onClick: () {
                Navigator.pushNamed(context, OnboardingScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
