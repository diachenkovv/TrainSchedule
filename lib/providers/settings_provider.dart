import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  bool _useMockData = true;

  bool get useMockData => _useMockData;

  void setUseMockData(bool value) {
    _useMockData = value;
    notifyListeners();
  }
}
