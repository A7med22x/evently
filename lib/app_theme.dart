import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryLight = Color(0xff0E3A99);
  static const Color primaryDark = Color(0xff457AED);
  static const Color backgroundLight = Color(0xffF4F7FF);
  static const Color backgroundDark = Color(0xff000F30);
  static const Color white = Color(0xffFFFFFF);
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
  );

  static ThemeData darkTheme = ThemeData();
}
