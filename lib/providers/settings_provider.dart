import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  bool _useMockData = true;
  Locale _locale = const Locale('uk', 'UA');

  bool get useMockData => _useMockData;
  Locale get locale => _locale;

  void setUseMockData(bool value) {
    _useMockData = value;
    notifyListeners();
  }

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}
