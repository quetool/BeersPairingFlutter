import 'package:flutter/material.dart';

class MaterialColorsExtension extends MaterialColor {
  MaterialColorsExtension(int primary, Map<int, Color> swatch) : super(primary, swatch);

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

class AppThemes {
  static var darkTheme = ThemeData.dark().copyWith(
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
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white.withOpacity(0.5),
      contentPadding: const EdgeInsets.only(left: 12.0, right: 12.0),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 3.0,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
    ),
  );

  static var lightTheme = ThemeData.light().copyWith(
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
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white.withOpacity(0.5),
      contentPadding: const EdgeInsets.only(left: 12.0, right: 12.0),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 3.0,
      color: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
    ),
  );
}
