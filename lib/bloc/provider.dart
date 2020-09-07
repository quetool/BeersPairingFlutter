import 'package:beers_pairing/bloc/beers_bloc.dart';
import 'package:beers_pairing/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  final beersBloc = BeersBloc();
  final themeBloc = ThemeBloc();

  Provider({Key key, Widget child}) : super(key: key, child: child);

  static BeersBloc beersBlocOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().beersBloc;
  }

  static ThemeBloc themeBlocOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().themeBloc;
  }

  @override
  bool updateShouldNotify(_) => true;
}
