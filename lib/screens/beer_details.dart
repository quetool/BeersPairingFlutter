import 'package:beers_pairing/components/custom_widgets.dart';
import 'package:beers_pairing/models/beer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BeerDetailsScreen extends StatefulWidget {
  const BeerDetailsScreen({
    this.beer,
  });

  final Beer beer;

  @override
  _BeerDetailsScreenState createState() => _BeerDetailsScreenState();
}

class _BeerDetailsScreenState extends State<BeerDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.beer.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Hero(
                    tag: widget.beer.id,
                    child: CachedNetworkImage(
                      imageUrl: widget.beer.imageUrl ??
                          'https://via.placeholder.com/350?text=No+Image',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
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
                                widget.beer.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                          AbvWidget(percentage: widget.beer.abv),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                      child: Text(
                        widget.beer.description,
                        style: const TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    Text(
                      widget.beer.tagline,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
