import 'package:beers_pairing/Themes/themes.dart';
import 'package:beers_pairing/bloc/provider.dart';
import 'package:beers_pairing/components/main_component.dart';
import 'package:beers_pairing/helpers/helpers.dart';
import 'package:beers_pairing/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      _appTheme = (theme == Brightness.light.toString())
          ? AppThemes.lightTheme
          : AppThemes.darkTheme;
      Provider.themeBlocOf(context).switchTheme(_appTheme);
    });

    Provider.themeBlocOf(context).streamThemeState.listen((ThemeData data) {
      if (!mounted) return;
      if (data == null) return;
      setState(() {
        _appTheme = data;
        Helper().saveCurrentTeheme(_appTheme.brightness.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        BeersPairingLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale(SupportedLanguages.english, ''),
        Locale(SupportedLanguages.spanish, ''),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        print('${locale.languageCode} - ${locale.countryCode}');
        var appLocale = supportedLocales.firstWhere(
            (supported) =>
                supported.languageCode.toLowerCase() ==
                locale.languageCode.toLowerCase(),
            orElse: () => null);
        return appLocale ?? supportedLocales.first;
      },
      theme: _appTheme,
      home: MainComponent(),
    );
  }
}
