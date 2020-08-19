import 'package:beers_pairing/api/punkapi.dart';
import 'package:beers_pairing/models/beer.dart';
import 'package:beers_pairing/models/error.dart';
import 'package:rxdart/rxdart.dart';

class BeersSate {
  bool loadingRandomBeer = false;
  bool loadingPairingList = false;
  Beer currentRandomBeer;
  List<Beer> currentPairingList = List();
  ApiError error;
}

class BeersBloc extends Object {
  final apiClient = ApiClient();

  final _beersState = BehaviorSubject<BeersSate>();
  Stream<BeersSate> get streamBeersSate => _beersState.stream;
  Function(BeersSate) get sinkBeersSate => _beersState.sink.add;

  BeersSate currentBeersState() {
    BeersSate currentState = _beersState.stream.value;
    if (currentState == null) currentState = BeersSate();
    return currentState;
  }

  void getRandomBeer() {
    var currentState = currentBeersState();
    currentState.loadingRandomBeer = true;
    currentState.error = null;
    sinkBeersSate(currentState);

    apiClient.getMeRandomBeer().then(
          (response) => apiClient.responseHandler(response, (error, beers) {
            currentState.currentRandomBeer = beers.first;
            currentState.error = error;
            currentState.loadingRandomBeer = false;
            sinkBeersSate(currentState);
          }),
        );
  }

  void getBeerDetails(int beerId) {
    apiClient.getBeerDetails(beerId).then(
          (response) => apiClient.responseHandler(response, (error, beers) {
            //
          }),
        );
  }

  void getAllBeers(String byFood, int fromPage, int perPage) {
    apiClient.getAllBeers(byFood, fromPage, perPage).then(
          (response) => apiClient.responseHandler(response, (error, beers) {
            //
          }),
        );
  }

  void dispose() {
    _beersState.close();
  }
}
