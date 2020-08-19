import 'package:beers_pairing/bloc/beers_bloc.dart';
import 'package:beers_pairing/bloc/provider.dart';
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
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    Provider.beersBlocOf(context).getRandomBeer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              Provider.beersBlocOf(context).getRandomBeer();
            },
          ),
        ],
      ),
      body: RandomBeerWidget(),
    );
  }
}

class RandomBeerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BeersSate>(
      stream: Provider.beersBlocOf(context).streamBeersSate,
      initialData: BeersSate(),
      builder: (BuildContext context, AsyncSnapshot<BeersSate> snapshot) {
        if (snapshot.data.loadingRandomBeer ||
            snapshot.data.currentRandomBeer == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1.0,
                  child: (snapshot.data.currentRandomBeer.imageUrl != null)
                      ? Image.network(snapshot.data.currentRandomBeer.imageUrl)
                      : Container(
                          color: Colors.grey.withOpacity(0.2),
                        ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            snapshot.data.currentRandomBeer.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      AbvWidget(
                          percentage: snapshot.data.currentRandomBeer.abv),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                  child: Text(
                    snapshot.data.currentRandomBeer.description,
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Text(
                  snapshot.data.currentRandomBeer.tagline,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AbvWidget extends StatelessWidget {
  const AbvWidget({
    Key key,
    @required this.percentage,
  }) : super(key: key);

  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.only(left: 8.0, top: 4.0, right: 8.0, bottom: 4.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: Text(
        "$percentage%",
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.0,
        ),
      ),
    );
  }
}
