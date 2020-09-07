import 'package:beers_pairing/models/beer.dart';
import 'package:beers_pairing/screens/random_beer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BeerDetailsScreen extends StatefulWidget {
  final Beer beer;
  const BeerDetailsScreen({
    Key key,
    @required this.beer,
  });
  @override
  _BeerDetailsScreenState createState() => _BeerDetailsScreenState();
}

class _BeerDetailsScreenState extends State<BeerDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.beer.name),
        elevation: 0.0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Hero(
                        tag: this.widget.beer.id,
                        child: CachedNetworkImage(
                          imageUrl: this.widget.beer.imageUrl ?? "https://via.placeholder.com/350?text=No+Image",
                          fit: BoxFit.contain,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          AbvWidget(percentage: this.widget.beer.abv),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
