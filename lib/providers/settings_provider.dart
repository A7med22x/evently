import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  ThemeMode themeMode = .light;
  String languageCode = 'en';

  bool get isDark => themeMode == .dark;

  bool get isEnglish => languageCode == 'en';

  Future<void> loadThemeAndLanguage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isDarkTheme = preferences.getBool('isDarkTheme') ?? false;
    themeMode = isDarkTheme ? .dark : .light;
    bool isEnglishLanguage = preferences.getBool('isEnglishLanguage') ?? false;
    languageCode = isEnglishLanguage ? 'en' : 'ar';
    notifyListeners();
  }

  void changeTheme(ThemeMode theme) async {
    themeMode = theme;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('isDarkTheme', isDark);
    notifyListeners();
  }

  void changelanguage(String language) async {
    if (languageCode == language) return;
    languageCode = language;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('isEnglishLanguage', isEnglish);
    notifyListeners();
  }
}
