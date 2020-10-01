import 'package:beers_pairing/bloc/beers_bloc.dart';
import 'package:beers_pairing/bloc/provider.dart';
import 'package:beers_pairing/components/custom_widgets.dart';
import 'package:beers_pairing/localization/app_localization.dart';
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
        if (!snapshot.hasData) {
          return Container();
        }
        if (snapshot.data.loadingPairingList) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data.currentPairingList.isEmpty) {
          if (snapshot.data.error != null) {
            return Center(
              child: Text(
                BeersPairingLocalizations.of(context)
                    .translate(snapshot.data.error.message),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            );
          }
          return Container();
        }
        return Container(
          child: ListView.builder(
            padding: const EdgeInsets.all(12.0),
            itemBuilder: (BuildContext context, int index) {
              return PairedBeerCell(
                beer: snapshot.data.currentPairingList[index],
                pairedWords: snapshot.data.pairedWords,
                onTap: (beer) {
                  Navigator.of(context).push(
                    MaterialPageRoute<BeerDetailsScreen>(
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
