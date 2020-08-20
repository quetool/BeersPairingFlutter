import 'package:beers_pairing/bloc/provider.dart';
import 'package:beers_pairing/screens/paired_beers.dart';
import 'package:beers_pairing/screens/random_beer.dart';
import 'package:flutter/material.dart';

class MainComponent extends StatefulWidget {
  @override
  _MainComponentState createState() => _MainComponentState();
}

class _MainComponentState extends State<MainComponent>
    with SingleTickerProviderStateMixin {
  //
  ScrollController _appBarController;
  TabController _tabController;

  List<Widget> _tabs = [
    Tab(
      child: Text(
        "Random Beer",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
    Tab(
      child: Text(
        "Paired Beers",
        style: TextStyle(
          color: Colors.black,
        ),
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
        _appBarController.animateTo(0.0,
            duration: Duration(milliseconds: 200), curve: Curves.linear);
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
            Container(
              width: MediaQuery.of(context).size.width,
              child: AppBar(
                title: Text("Beers Pairing"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      Provider.beersBlocOf(context).getRandomBeer();
                    },
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.blue,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: kToolbarHeight,
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: 8.0,
                    ),
                    child: Center(
                      child: TextField(
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          prefixIconConstraints: BoxConstraints.tightFor(),
                          hintText: "What are you eating?",
                          // contentPadding: const EdgeInsets.all(0.0),
                          fillColor: Colors.white,
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
