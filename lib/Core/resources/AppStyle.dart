import 'package:flutter/material.dart';

import 'ColorManger.dart';

class AppStyle {
  static ThemeMode themeMode=ThemeMode.light;
  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
    ),
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: Colors.purple,
      primary: ColorManger.blue,
      secondary: ColorManger.black,
      tertiary: ColorManger.red,
      onPrimary: Colors.white,
    ),
    textTheme: TextTheme(
      labelMedium: TextStyle(
        fontWeight: FontWeight.w500,
        color: ColorManger.white,
        fontSize: 20,
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w700,
        color: ColorManger.blue,
        fontSize: 20,
      ),
      bodySmall: TextStyle(
        fontWeight: FontWeight.w500,
        color: ColorManger.black,
        fontSize: 16,
      ),
    ),

    useMaterial3: true,
    scaffoldBackgroundColor: ColorManger.lightBackground,
  );
  static ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
    ),
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: Colors.purple,
      primary: ColorManger.blue,
      secondary: ColorManger.white,
      tertiary: ColorManger.red,
      onPrimary: Colors.black,
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: ColorManger.darkBackground,
    textTheme: TextTheme(
      labelMedium: TextStyle(
        fontWeight: FontWeight.w500,
        color: ColorManger.white,
        fontSize: 20,
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w700,
        color: ColorManger.blue,
        fontSize: 20,
      ),
      bodySmall: TextStyle(
        fontWeight: FontWeight.w500,
        color: ColorManger.white,
        fontSize: 16,
      ),
    ),
  );
}
