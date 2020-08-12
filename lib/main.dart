import 'package:flutter/material.dart';
import 'api/punkapi.dart';
import 'models/beer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  final apiClient = ApiClient();
  Beer randomBeer;

  @override
  void initState() {
    super.initState();
    getRandomBeer();
  }

  void getRandomBeer() {
    setState(() {
      this.randomBeer = null;
    });
    apiClient.getMeRandomBeer().then(
          (response) => apiClient.responseHandler(response, (error, beers) {
            setState(() {
              this.randomBeer = beers.first;
            });
          }),
        );
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
              getRandomBeer();
            },
          ),
        ],
      ),
      body: RandomBeerWidget(randomBeer: this.randomBeer),
    );
  }
}

class RandomBeerWidget extends StatelessWidget {
  const RandomBeerWidget({
    Key key,
    @required this.randomBeer,
  }) : super(key: key);

  final Beer randomBeer;

  @override
  Widget build(BuildContext context) {
    return (this.randomBeer != null)
        ? SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 1.0,
                    child: (this.randomBeer.imageUrl != null)
                        ? Image.network(this.randomBeer.imageUrl)
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
                              this.randomBeer.name,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                        AbvWidget(percentage: this.randomBeer.abv),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                    child: Text(
                      this.randomBeer.description,
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  Text(
                    this.randomBeer.tagline,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
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
