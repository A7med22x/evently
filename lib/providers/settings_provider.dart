import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  ThemeMode themeMode = .light;

  bool get isDark => themeMode == .dark;

  Future<void> loadTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isDarkTheme = preferences.getBool('isDarkTheme') ?? false;
    themeMode = isDarkTheme ? .dark : .light;
    notifyListeners();
  }

  void changeTheme(ThemeMode theme) async {
    themeMode = theme;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('isDarkTheme', isDark);
    notifyListeners();
  }
}
