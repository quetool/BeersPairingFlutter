import 'package:animations/animations.dart';
import 'package:beers_pairing/bloc/beers_bloc.dart';
import 'package:beers_pairing/bloc/provider.dart';
import 'package:beers_pairing/models/beer.dart';
import 'package:beers_pairing/screens/beer_details.dart';
import 'package:beers_pairing/screens/random_beer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PairedBeersBody extends StatefulWidget {
  @override
  _PairedBeersBodyState createState() => _PairedBeersBodyState();
}

class _PairedBeersBodyState extends State<PairedBeersBody> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BeersSate>(
      stream: Provider.beersBlocOf(context).streamBeersSate,
      builder: (BuildContext context, AsyncSnapshot<BeersSate> snapshot) {
        if (!snapshot.hasData || snapshot.data.loadingPairingList) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container(
          child: ListView.builder(
            padding: const EdgeInsets.all(12.0),
            itemBuilder: (BuildContext context, int index) {
              // return Padding(
              //   padding: const EdgeInsets.only(bottom: 12.0),
              //   child: OpenContainer(
              //     // transitionDuration: Duration(seconds: 5),
              //     tappable: true,
              //     // openColor: Colors.white,
              //     openElevation: 0.0,
              //     openBuilder: (BuildContext context, void Function({Object returnValue}) action) => BeerDetailsScreen(
              //       beer: snapshot.data.currentPairingList[index],
              //     ),
              //     // closedColor: Colors.white,
              //     closedElevation: 3.0,
              //     closedBuilder: (BuildContext context, void Function() action) => PairedBeerCell(
              //       beer: snapshot.data.currentPairingList[index],
              //     ),
              //   ),
              // );
              return PairedBeerCell(beer: snapshot.data.currentPairingList[index]);
            },
            itemCount: snapshot.data.currentPairingList.length,
          ),
        );
      },
    );
  }
}

class PairedBeerCell extends StatelessWidget {
  const PairedBeerCell({
    Key key,
    @required this.beer,
  }) : super(key: key);

  final Beer beer;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    CachedNetworkImage(
                      imageUrl: beer.imageUrl ?? "https://via.placeholder.com/350?text=No+Image",
                      fit: BoxFit.contain,
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
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        beer.description,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
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
    );
  }
}
