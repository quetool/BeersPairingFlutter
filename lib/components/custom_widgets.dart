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
    this.pairedWords,
  }) : super(key: key);

  final Beer beer;
  final Function(Beer) onTap;
  final List<String> pairedWords;

  @override
  Widget build(BuildContext context) {
    var matches = beer.foodPairing
        .where((food) => pairedWords
            .where(
                (element) => food.toLowerCase().contains(element.toLowerCase()))
            .isNotEmpty)
        .toList();
    return Card(
      child: InkWell(
        onTap: () => onTap(beer),
        child: Container(
          padding: const EdgeInsets.only(bottom: 8.0, top: 8.0, right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                width: (MediaQuery.of(context).size.width / 3.5),
                height: (MediaQuery.of(context).size.width / 3.5),
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          beer.description,
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Good with: ',
                              style: TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: matches
                                    .map(
                                      (food) => Text(
                                        '$food',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        beer.tagline,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
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

class Tagsline extends StatelessWidget {
  const Tagsline({
    Key key,
    @required this.tagline,
  }) : super(key: key);

  final List<String> tagline;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Chip(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              label: Text(
                tagline[index],
              ),
            ),
          );
        },
        itemCount: tagline.length,
      ),
    );
  }
}
