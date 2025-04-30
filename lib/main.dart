import 'package:evently/Core/resources/AppStyle.dart';
import 'package:evently/Core/resources/ColorManger.dart';
import 'package:evently/UI/splash/screen/splash_screen.dart';
import 'package:flutter/material.dart';

import 'UI/Start/Screen/Start_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppStyle.lightTheme,
      themeMode: AppStyle.themeMode,
      darkTheme: AppStyle.darkTheme,
      debugShowCheckedModeBanner: false,
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        StartScreen.routeName: (_) => StartScreen(),
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}
