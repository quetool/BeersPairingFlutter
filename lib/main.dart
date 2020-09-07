import 'package:beers_pairing/Themes/themes.dart';
import 'package:beers_pairing/bloc/provider.dart';
import 'package:beers_pairing/bloc/theme_bloc.dart';
import 'package:beers_pairing/components/main_component.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: RootApp(),
    );
  }
}

class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  ThemeData appTheme = AppThemes.blueTheme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Provider.themeBlocOf(context).streamThemeState.listen((ThemeState data) {
      if (!mounted) return;
      if (data == null) return;
      setState(() {
        this.appTheme = data.theme;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      home: MainComponent(),
    );
  }
}
