import 'package:beers_pairing/bloc/beers_bloc.dart';
import 'package:beers_pairing/bloc/provider.dart';
import 'package:beers_pairing/components/custom_widgets.dart';
import 'package:beers_pairing/screens/beer_details.dart';
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container(
          child: ListView.builder(
            padding: const EdgeInsets.all(12.0),
            itemBuilder: (BuildContext context, int index) {
              return PairedBeerCell(
                beer: snapshot.data.currentPairingList[index],
                onTap: (beer) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (BuildContext context) {
                          return BeerDetailsScreen(
                            beer: beer,
                          );
                        }),
                  );
                },
              );
            },
            itemCount: snapshot.data.currentPairingList.length,
          ),
        );
      },
    );
  }
}
