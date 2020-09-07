import 'package:beers_pairing/models/beer.dart';
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
        color: Colors.white,
      ),
    );
  }
}
