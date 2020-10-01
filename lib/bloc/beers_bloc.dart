import 'package:beers_pairing/api/punkapi.dart';
import 'package:beers_pairing/models/beer.dart';
import 'package:beers_pairing/models/error.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class BeersSate {
  bool loadingRandomBeer = false;
  bool loadingPairingList = false;
  Beer currentRandomBeer;
  List<Beer> currentPairingList = [];
  List<String> pairedWords = [];
  bool ascendingSort = false;
  ApiError error;
}

class BeersBloc extends Object {
  final _apiClient = ApiClient();

  final _beersState = BehaviorSubject<BeersSate>();
  Stream<BeersSate> get streamBeersSate => _beersState.stream;
  Function(BeersSate) get sinkBeersSate => _beersState.sink.add;

  BeersSate currentBeersState() {
    var currentState = _beersState.stream.value;
    currentState ??= BeersSate();
    return currentState;
  }

  void getRandomBeer() {
    var currentState = currentBeersState()
      ..loadingRandomBeer = true
      ..error = null;
    sinkBeersSate(currentState);

    _apiClient.getMeRandomBeer().then(
          (response) => _apiClient.responseHandler(response, (error, beers) {
            currentState
              ..currentRandomBeer = (error == null) ? beers.first : null
              ..error = error
              ..loadingRandomBeer = false;
            sinkBeersSate(currentState);
          }),
        );
  }

  // void getBeerDetails(int beerId) {
  //   _apiClient.getBeerDetails(beerId).then(
  //         (response) => _apiClient.responseHandler(response, (error, beers) {
  //           //
  //         }),
  //       );
  // }

  void getAllBeers(String byFood, int fromPage, int perPage) {
    var currentState = currentBeersState()
      ..loadingPairingList = true
      ..pairedWords = []
      ..error = null;
    sinkBeersSate(currentState);

    _apiClient.getAllBeers(byFood, fromPage, perPage).then(
          (response) => _apiClient.responseHandler(response, (error, beers) {
            currentState
              ..currentPairingList = (error == null) ? beers : []
              ..error = error
              ..pairedWords = byFood.split(' ')
              ..loadingPairingList = false;
            sinkBeersSate(currentState);
          }),
        );
  }

  void sortBeers() {
    var currentState = currentBeersState();
    currentState.ascendingSort = !currentState.ascendingSort;
    if (currentState.ascendingSort) {
      currentState.currentPairingList
          .sort((a, b) => a.abv.abs().compareTo(b.abv.abs()));
    } else {
      currentState.currentPairingList
          .sort((b, a) => a.abv.abs().compareTo(b.abv.abs()));
    }
    sinkBeersSate(currentState);
  }

  void dispose() {
    _beersState.close();
  }
}
