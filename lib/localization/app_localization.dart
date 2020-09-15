import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SupportedLanguages {
  static String english = 'en';
  static String spanish = 'es';
}

class TranslationsKeys {
  static String appTitle = 'app_title';
  static String randomBeerTabTitle = 'random_beer_tab_title';
  static String pairedBeersTabTitle = 'paired_beers_tab_title';
  static String eatingQuestion = 'eating_question';
  static String serializationError = 'serialization_error';
}

class BeersPairingLocalizations {
  BeersPairingLocalizations(this.appLocale);

  final Locale appLocale;

  static BeersPairingLocalizations of(BuildContext context) {
    return Localizations.of<BeersPairingLocalizations>(
        context, BeersPairingLocalizations);
  }

  static const LocalizationsDelegate<BeersPairingLocalizations> delegate =
      _BeersPairingLocalizationsDelegate();

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    var jsonString = await rootBundle
        .loadString('assets/language/${appLocale.languageCode}.json');
    var jsonMap = json.decode(jsonString) as Map<String, dynamic>;
    _localizedStrings = jsonMap.map((String key, dynamic value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  String translate(String key) {
    return _localizedStrings[key];
  }
}

class _BeersPairingLocalizationsDelegate
    extends LocalizationsDelegate<BeersPairingLocalizations> {
  const _BeersPairingLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return [
      SupportedLanguages.english,
      SupportedLanguages.spanish,
    ].contains(locale.languageCode);
  }

  @override
  Future<BeersPairingLocalizations> load(Locale locale) async {
    var localizations = BeersPairingLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_BeersPairingLocalizationsDelegate old) => false;
}
