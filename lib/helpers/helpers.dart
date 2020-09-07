import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  SharedPreferences _prefs;
  static final Helper _singleton = Helper._internal().._init();

  factory Helper() {
    return _singleton;
  }

  Helper._internal();

  _init() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  Future<String> getCurrentTheme() async {
    if (_prefs == null) {
      await _init();
    }
    String theme = _prefs.getString("theme");
    return theme ?? Brightness.light.toString();
  }

  Future<void> saveCurrentTeheme(String currentTheme) async {
    print("save theme $currentTheme");
    await _prefs.setString("theme", currentTheme);
  }
}
