import 'package:beers_pairing/Themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ThemeState {
  ThemeData theme = AppThemes.blueTheme;
  IconData icon = Icons.wb_sunny;
}

class ThemeBloc extends Object {
  final _themeState = BehaviorSubject<ThemeState>();
  Stream<ThemeState> get streamThemeState => _themeState.stream;
  Function(ThemeState) get sinkThemeSate => _themeState.sink.add;

  ThemeState _currentTheme() {
    ThemeState currentState = _themeState.stream.value;
    if (currentState == null) return ThemeState();
    return currentState;
  }

  void switchTheme() {
    ThemeState themeState = _currentTheme();
    if (themeState.icon == Icons.brightness_3) {
      themeState.icon = Icons.wb_sunny;
      themeState.theme = AppThemes.blueTheme;
    } else {
      themeState.icon = Icons.brightness_3;
      themeState.theme = AppThemes.whiteTheme;
    }
    sinkThemeSate(themeState);
  }

  void dispose() {
    _themeState.close();
  }
}
