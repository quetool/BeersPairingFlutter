import 'dart:math';

import 'package:beers_pairing/bloc/beers_bloc.dart';
import 'package:beers_pairing/bloc/provider.dart';
import 'package:beers_pairing/localization/app_localization.dart';
import 'package:beers_pairing/themes/themes.dart';
import 'package:flutter/material.dart';

class AppBarPairedBeersBody extends StatefulWidget {
  const AppBarPairedBeersBody({
    Key key,
  }) : super(key: key);

  @override
  _AppBarPairedBeersBodyState createState() => _AppBarPairedBeersBodyState();
}

class _AppBarPairedBeersBodyState extends State<AppBarPairedBeersBody> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: AppBar(
        title: SizedBox(
          height: 36.0,
          child: TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: BeersPairingLocalizations.of(context)
                  .translate(TranslationsKeys.eatingQuestion),
            ),
            onSubmitted: (text) {
              Provider.beersBlocOf(context).getAllBeers(text, 1, 20);
            },
          ),
        ),
        actions: <Widget>[
          StreamBuilder<BeersSate>(
            stream: Provider.beersBlocOf(context).streamBeersSate,
            initialData: BeersSate(),
            builder: (BuildContext context, AsyncSnapshot<BeersSate> snapshot) {
              return IconButton(
                icon: Transform.rotate(
                  angle: snapshot.data.ascendingSort ? pi : 0.0,
                  child: const Icon(Icons.filter_list),
                ),
                onPressed: () {
                  Provider.beersBlocOf(context).sortBeers();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar({
    Key key,
    this.title = '',
    this.actions,
  }) : super(key: key);

  final String title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: AppBar(
        leading: StreamBuilder<ThemeData>(
          stream: Provider.themeBlocOf(context).streamThemeState,
          builder: (BuildContext context, AsyncSnapshot<ThemeData> snapshot) {
            if (!snapshot.hasData) {
              return Container(
                width: 0.0,
                height: 0.0,
              );
            }
            return IconButton(
              icon: (snapshot.data.brightness == Brightness.dark)
                  ? const Icon(Icons.wb_sunny)
                  : const Icon(Icons.brightness_3),
              onPressed: () {
                var appTheme = (snapshot.data.brightness == Brightness.light)
                    ? AppThemes.darkTheme
                    : AppThemes.lightTheme;
                Provider.themeBlocOf(context).switchTheme(appTheme);
              },
            );
          },
        ),
        title: Text(title),
        actions: actions,
      ),
    );
  }
}
