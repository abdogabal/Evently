import 'package:flutter/material.dart';

import 'ColorManger.dart';

class AppStyle {
  static ThemeMode themeMode = ThemeMode.light;
  static ThemeData lightTheme = ThemeData(
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorManger.blue,
      shape: StadiumBorder(
        side:BorderSide(
          color: ColorManger.white,
          width: 4
        )
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorManger.blue,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorManger.white,
      unselectedItemColor: ColorManger.white,
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w700,
        color: ColorManger.white,
        fontSize: 12,
      ),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w700,
        color: ColorManger.white,
        fontSize: 12,
      ),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: ColorManger.black,
      ),
    ),

    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: Colors.purple,
      primary: ColorManger.blue,
      secondary: ColorManger.black,
      tertiary: ColorManger.red,
      onPrimary: Colors.white,
      onPrimaryContainer: ColorManger.grey,
      onSecondary: Colors.black,
      onTertiary: ColorManger.white,
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
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: ColorManger.grey,
      ),
    ),

    useMaterial3: true,
    scaffoldBackgroundColor: ColorManger.lightBackground,
  );
  static ThemeData darkTheme = ThemeData(
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorManger.darkBackground,
      shape: StadiumBorder(
          side:BorderSide(
              color: ColorManger.white,
              width: 4
          )
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorManger.darkBackground,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorManger.white,
      unselectedItemColor: ColorManger.white,
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w700,
        color: ColorManger.white,
        fontSize: 12,
      ),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w700,
        color: ColorManger.white,
        fontSize: 12,
      ),
    ),
    appBarTheme: AppBarTheme(
      shadowColor: Colors.transparent,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: ColorManger.black,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: Colors.purple,
      primary: ColorManger.blue,
      secondary: ColorManger.white,
      tertiary: ColorManger.red,
      onPrimary: Colors.black,
      onPrimaryContainer: ColorManger.white,
      onSecondary: ColorManger.white,
      onTertiary: ColorManger.darkBackground,
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
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: ColorManger.grey,
      ),
    ),
  );
}
