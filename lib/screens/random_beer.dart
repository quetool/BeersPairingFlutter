import 'package:beers_pairing/bloc/beers_bloc.dart';
import 'package:beers_pairing/bloc/provider.dart';
import 'package:beers_pairing/components/custom_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RandomBeerBody extends StatefulWidget {
  RandomBeerBody({
    Key key,
    this.orientation,
  });
  final Orientation orientation;

  @override
  _RandomBeerBodyState createState() => _RandomBeerBodyState();
}

class _RandomBeerBodyState extends State<RandomBeerBody> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Provider.beersBlocOf(context).currentBeersState().currentRandomBeer == null) {
      Provider.beersBlocOf(context).getRandomBeer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BeersSate>(
      stream: Provider.beersBlocOf(context).streamBeersSate,
      builder: (BuildContext context, AsyncSnapshot<BeersSate> snapshot) {
        if (!snapshot.hasData || snapshot.data.loadingRandomBeer) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: CachedNetworkImage(
                      imageUrl:
                          snapshot.data.currentRandomBeer.imageUrl ?? "https://via.placeholder.com/350?text=No+Image",
                      fit: BoxFit.contain,
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
                                  snapshot.data.currentRandomBeer.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                            AbvWidget(percentage: snapshot.data.currentRandomBeer.abv),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                        child: Text(
                          snapshot.data.currentRandomBeer.description,
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      Text(
                        snapshot.data.currentRandomBeer.tagline,
                        style: TextStyle(
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
        );
      },
    );
  }
}
