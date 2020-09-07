import 'package:beers_pairing/api/punkapi.dart';
import 'package:beers_pairing/models/beer.dart';
import 'package:beers_pairing/models/error.dart';
import 'package:rxdart/rxdart.dart';

class BeersSate {
  bool loadingRandomBeer = false;
  bool loadingPairingList = false;
  Beer currentRandomBeer;
  List<Beer> currentPairingList = List();
  bool ascendingSort = false;
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
    var currentState = currentBeersState();
    currentState.loadingPairingList = true;
    currentState.error = null;
    sinkBeersSate(currentState);

    apiClient.getAllBeers(byFood, fromPage, perPage).then(
          (response) => apiClient.responseHandler(response, (error, beers) {
            print(beers);
            currentState.currentPairingList = beers;
            currentState.error = error;
            currentState.loadingPairingList = false;
            sinkBeersSate(currentState);
          }),
        );
  }

  void sortBeers() {
    var currentState = currentBeersState();
    currentState.ascendingSort = !currentState.ascendingSort;
    if (currentState.ascendingSort) {
      currentState.currentPairingList.sort((a, b) => a.abv.abs().compareTo(b.abv.abs()));
    } else {
      currentState.currentPairingList.sort((b, a) => a.abv.abs().compareTo(b.abv.abs()));
    }
    sinkBeersSate(currentState);
  }

  void dispose() {
    _beersState.close();
  }
}
