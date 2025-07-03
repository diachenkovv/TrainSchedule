import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  String get themeModeString {
    switch (_themeMode) {
      case ThemeMode.light:
        return 'Світла';
      case ThemeMode.dark:
        return 'Темна';
      case ThemeMode.system:
        return 'Системна';
    }
  }
}
