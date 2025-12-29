import 'package:flutter/material.dart';
import 'package:w_allfit/core/shared_preferences/shared_preference.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  Locale _local = Locale('en', 'EN');

  ThemeMode get themeMode => _themeMode;

  SettingsProvider() {
    _loadSettings();
  }

  void _loadSettings() async {
    final language = await getLocale();
    _local = Locale(language);
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    notifyListeners();
  }

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  Locale get local => _local;

  void updateLanguage(String languageCode) async {
    _local = Locale(languageCode);
    await setLocale(languageCode);
    notifyListeners();
  }
}
