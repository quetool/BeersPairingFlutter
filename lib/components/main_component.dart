import 'dart:math';

import 'package:beers_pairing/bloc/beers_bloc.dart';
import 'package:beers_pairing/bloc/provider.dart';
import 'package:beers_pairing/screens/paired_beers.dart';
import 'package:beers_pairing/screens/random_beer.dart';
import 'package:beers_pairing/themes/themes.dart';
import 'package:flutter/material.dart';

class MainComponent extends StatefulWidget {
  @override
  _MainComponentState createState() => _MainComponentState();
}

class _MainComponentState extends State<MainComponent> with SingleTickerProviderStateMixin {
  // asdasdsasda
  ScrollController _appBarController;
  TabController _tabController;

  List<Widget> _tabs = [
    Tab(
      child: Text("Random Beer"),
    ),
    Tab(
      child: Text("Paired Beers"),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _appBarController = ScrollController();
    _tabController = TabController(vsync: this, length: 2, initialIndex: 0);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging && _tabController.index == 1) {
        _appBarController.animateTo(MediaQuery.of(context).size.width,
            duration: Duration(milliseconds: 200), curve: Curves.linear);
      }
      if (_tabController.indexIsChanging && _tabController.index == 0) {
        _appBarController.animateTo(0.0, duration: Duration(milliseconds: 200), curve: Curves.linear);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          controller: _appBarController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            DefaultAppBar(
              title: "Beers Pairing",
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    Provider.beersBlocOf(context).getRandomBeer();
                  },
                ),
              ],
            ),
            AppBarPairedBeersBody(),
          ],
        ),
        preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight),
      ),
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          // print(orientation);
          return Column(
            children: <Widget>[
              TabBar(
                controller: _tabController,
                tabs: this._tabs,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    RandomBeerBody(
                      orientation: orientation,
                    ),
                    PairedBeersBody(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class AppBarPairedBeersBody extends StatefulWidget {
  const AppBarPairedBeersBody({
    Key key,
  }) : super(key: key);

  @override
  _AppBarPairedBeersBodyState createState() => _AppBarPairedBeersBodyState();
}

class _AppBarPairedBeersBodyState extends State<AppBarPairedBeersBody> {
  var _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
      width: MediaQuery.of(context).size.width,
      child: AppBar(
        title: SizedBox(
          height: 36.0,
          child: TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: "What are you eating?",
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
                  child: Icon(Icons.filter_list),
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
    this.title = "",
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
              icon: (snapshot.data.brightness == Brightness.dark) ? Icon(Icons.wb_sunny) : Icon(Icons.brightness_3),
              onPressed: () {
                var appTheme =
                    (snapshot.data.brightness == Brightness.light) ? AppThemes.darkTheme : AppThemes.lightTheme;
                Provider.themeBlocOf(context).switchTheme(appTheme);
              },
            );
          },
        ),
        title: Text(this.title),
        actions: this.actions,
      ),
    );
  }
}
