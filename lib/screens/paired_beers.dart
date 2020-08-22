import 'package:beers_pairing/bloc/beers_bloc.dart';
import 'package:beers_pairing/bloc/provider.dart';
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
                return Container(
                  constraints: BoxConstraints(
                    minHeight: 80.0,
                  ),
                  // color: Colors.red,
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        height: MediaQuery.of(context).size.width / 4,
                        margin: const EdgeInsets.only(right: 12.0),
                        child: CachedNetworkImage(
                          imageUrl: snapshot
                                  .data.currentPairingList[index].imageUrl ??
                              "https://via.placeholder.com/350?text=No+Image",
                          fit: BoxFit.contain,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                snapshot.data.currentPairingList[index].name,
                                // maxLines: 2,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                snapshot
                                    .data.currentPairingList[index].description,
                                // maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: snapshot.data.currentPairingList.length,
            ),
          );
        });
  }
}
