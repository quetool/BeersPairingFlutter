import 'dart:math';

import 'package:beers_pairing/bloc/beers_bloc.dart';
import 'package:beers_pairing/bloc/provider.dart';
import 'package:beers_pairing/bloc/theme_bloc.dart';
import 'package:beers_pairing/screens/paired_beers.dart';
import 'package:beers_pairing/screens/random_beer.dart';
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
      child: Text(
        "Random Beer",
        // style: TextStyle(
        //   color: Colors.black,
        // ),
      ),
    ),
    Tab(
      child: Text(
        "Paired Beers",
        // style: TextStyle(
        //   color: Colors.black,
        // ),
      ),
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
        title: TextField(
          controller: _textController,
          // cursorColor: Colors.white,
          decoration: InputDecoration(
            // prefixIcon: Padding(
            //   padding: const EdgeInsets.only(right: 8.0),
            //   child: Icon(
            //     Icons.search,
            //     // color: Colors.white,
            //   ),
            // ),
            prefixIconConstraints: BoxConstraints.tightFor(),
            // suffixIcon: Padding(
            //   padding: const EdgeInsets.only(left: 8.0),
            //   child: IconButton(
            //     padding: EdgeInsets.zero,
            //     visualDensity: VisualDensity.compact,
            //     icon: Icon(
            //       Icons.close,
            //       size: 18.0,
            //       // color: Colors.white,
            //     ),
            //     onPressed: () {
            //       setState(() {
            //         _textController.text = "";
            //       });
            //       FocusScope.of(context).unfocus();
            //     },
            //   ),
            // ),
            suffixIconConstraints: BoxConstraints.tightFor(),
            hintText: "What are you eating?",
          ),
          onSubmitted: (text) {
            Provider.beersBlocOf(context).getAllBeers(text, 1, 20);
          },
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

  // InputBorder setBorder() {
  //   return UnderlineInputBorder(
  //     borderSide: BorderSide(
  //       color: Colors.white,
  //     ),
  //   );
  // }
}

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar({
    Key key,
    this.title = "",
    this.actions,
    // this.color,
  }) : super(key: key);

  final String title;
  final List<Widget> actions;
  // final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: AppBar(
        leading: StreamBuilder<ThemeState>(
          stream: Provider.themeBlocOf(context).streamThemeState,
          initialData: ThemeState(),
          builder: (BuildContext context, AsyncSnapshot<ThemeState> snapshot) {
            return IconButton(
              icon: Icon(snapshot.data.icon), // Icon(Icons.wb_sunny)
              onPressed: () {
                Provider.themeBlocOf(context).switchTheme();
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
