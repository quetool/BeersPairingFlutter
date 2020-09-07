import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ThemeBloc extends Object {
  final _themeState = BehaviorSubject<ThemeData>();
  Stream<ThemeData> get streamThemeState => _themeState.stream;
  Function(ThemeData) get _sinkThemeSate => _themeState.sink.add;

  void switchTheme(ThemeData theme) {
    _sinkThemeSate(theme);
  }

  void dispose() {
    _themeState.close();
  }
}
