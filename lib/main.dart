import 'package:beers_pairing/bloc/provider.dart';
import 'package:beers_pairing/screens/random_beer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MainContainer(),
      ),
    );
  }
}

class MainContainer extends StatefulWidget {
  @override
  _MainContainerState createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
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
        body: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            // print(orientation);
            return Column(
              children: <Widget>[
                (orientation == Orientation.portrait)
                    ? TabBar(
                        tabs: [
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
                        ],
                      )
                    : Container(width: 0.0, height: 0.0),
                Expanded(
                  child: TabBarView(
                    children: [
                      RandomBeerBody(
                        orientation: orientation,
                      ),
                      Container(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
