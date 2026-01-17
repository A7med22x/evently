import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryLight = Color(0xff0E3A99);
  static const Color primaryDark = Color(0xff457AED);
  static const Color backgroundLight = Color(0xffF4F7FF);
  static const Color backgroundDark = Color(0xff000F30);
  static const Color white = Color(0xffFFFFFF);
  static const Color offWhite = Color(0xffF0F0F0);
  static const Color black = Color(0xff1C1C1C);
  static const Color grey = Color(0xff686868);

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: backgroundLight,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: white,
      selectedItemColor: primaryLight,
      unselectedItemColor: grey,
      type: .fixed,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryLight,
      foregroundColor: white,
      shape: CircleBorder(),
    ),
    inputDecorationTheme: InputDecorationThemeData(
      filled: true,
      fillColor: white,
      hintStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: grey,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: offWhite),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: offWhite),
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: black,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: black,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: grey,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData();
}
