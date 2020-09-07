import 'package:beers_pairing/Themes/themes.dart';
import 'package:beers_pairing/bloc/provider.dart';
import 'package:beers_pairing/components/main_component.dart';
import 'package:beers_pairing/helpers/helpers.dart';
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
  ThemeData _appTheme = AppThemes.lightTheme;

  @override
  void initState() {
    super.initState();
    _setHelperAndListenerTheme();
  }

  Future<void> _setHelperAndListenerTheme() async {
    await Helper().getCurrentTheme().then((theme) {
      this._appTheme = (theme == Brightness.light.toString()) ? AppThemes.lightTheme : AppThemes.darkTheme;
      Provider.themeBlocOf(context).switchTheme(this._appTheme);
    });

    Provider.themeBlocOf(context).streamThemeState.listen((ThemeData data) {
      if (!mounted) return;
      if (data == null) return;
      setState(() {
        this._appTheme = data;
        Helper().saveCurrentTeheme(this._appTheme.brightness.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _appTheme,
      home: MainComponent(),
    );
  }
}
