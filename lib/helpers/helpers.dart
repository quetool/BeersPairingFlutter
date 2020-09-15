import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  factory Helper() {
    return _singleton;
  }
  Helper._internal();

  SharedPreferences _prefs;
  static final Helper _singleton = Helper._internal().._init();

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<String> getCurrentTheme() async {
    if (_prefs == null) {
      await _init();
    }
    var theme = _prefs.getString('theme');
    return theme ?? Brightness.light.toString();
  }

  Future<void> saveCurrentTeheme(String currentTheme) async {
    print('save theme $currentTheme');
    await _prefs.setString('theme', currentTheme);
  }
}
