import 'package:beers_pairing/models/beer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: Text(
        '$percentage%',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12.0,
        ),
      ),
    );
  }
}

class PairedBeerCell extends StatelessWidget {
  const PairedBeerCell({
    Key key,
    @required this.beer,
    @required this.onTap,
  }) : super(key: key);

  final Beer beer;
  final Function(Beer) onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => onTap(beer),
        child: Container(
          height: (MediaQuery.of(context).size.width / 3),
          padding: const EdgeInsets.only(bottom: 8.0, top: 8.0, right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Hero(
                        tag: beer.id,
                        child: CachedNetworkImage(
                          imageUrl: beer.imageUrl ??
                              'https://via.placeholder.com/350?text=No+Image',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          AbvWidget(percentage: beer.abv),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          beer.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          beer.description,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
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
