import 'package:flutter/material.dart';

class MaterialColorsExtends extends MaterialColor {
  MaterialColorsExtends(int primary, Map<int, Color> swatch) : super(primary, swatch);

  static const MaterialColor white = MaterialColor(
    _whitePrimaryValue,
    <int, Color>{
      50: Colors.white,
      100: Colors.white,
      200: Colors.white,
      300: Colors.white,
      400: Colors.white,
      500: Color(_whitePrimaryValue),
      600: Colors.white,
      700: Colors.white,
      800: Colors.white,
      900: Colors.white,
    },
  );
  static const int _whitePrimaryValue = 0xFFFFFFFF;
}

mixin AppThemes implements ThemeData {
  static var whiteTheme = ThemeData(
    brightness: Brightness.dark,
    tabBarTheme: TabBarTheme(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: Colors.white,
          width: 2.0,
        ),
      ),
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey,
    ),
  );

  static var blueTheme = ThemeData(
    brightness: Brightness.light,
    tabBarTheme: TabBarTheme(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: Colors.blue,
          width: 2.0,
        ),
      ),
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
    ),
  );

  static InputBorder setBorder({Color color = Colors.blue}) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: color,
      ),
    );
  }
}
