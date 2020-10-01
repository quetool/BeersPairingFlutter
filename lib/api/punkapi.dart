import 'dart:convert';

import 'package:beers_pairing/localization/app_localization.dart';
import 'package:beers_pairing/models/beer.dart';
import 'package:beers_pairing/models/error.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  factory ApiClient() {
    return _singleton;
  }
  ApiClient._internal();

  String _rootApi;
  String _allBeers;
  String _randomBeer;
  http.Client client;

  static final ApiClient _singleton = ApiClient._internal().._init();

  void _init() {
    _rootApi = 'https://api.punkapi.com/v2';
    _allBeers = '/beers';
    _randomBeer = '/random';
    client = http.Client();
  }

  Future<http.Response> getMeRandomBeer() {
    print(_rootApi + _allBeers + _randomBeer);
    return client.get(_rootApi + _allBeers + _randomBeer);
  }

  // Future<http.Response> getBeerDetails(int beerId) {
  //   print('$_rootApi$_allBeers$beerId');
  //   return client.get('$_rootApi$_allBeers$beerId');
  // }

  Future<http.Response> getAllBeers(String byFood, int fromPage, int perPage) {
    var parameters = '?page=$fromPage&per_page=$perPage';
    if (byFood != '') {
      var food = byFood.trim().replaceAll(' ', '_');
      parameters += '&food=$food';
    }
    print(_rootApi + _allBeers + parameters);
    return client.get(_rootApi + _allBeers + parameters);
  }

  Future<http.Response> retryRequestAfterFail(String request) {
    return client.get(request);
  }

  void responseHandler(http.Response response,
      Function(ApiError error, List<Beer> beers) completion) {
    if (response.statusCode == 200) {
      try {
        var jsonArray = json.decode(response.body) as List;
        var sortedList = jsonArray
            .map((dynamic e) => Beer.fromJson(e as Map<String, dynamic>))
            .toList()
              ..sort((a, b) => a.abv.compareTo(b.abv));
        completion(null, sortedList);
      } catch (e) {
        print(e);
        var error = ApiError()
          ..message = TranslationsKeys.serializationError
          ..statusCode = response.statusCode
          ..error = e.toString();
        completion(error, null);
      }
    } else {
      var error =
          ApiError.fromJson(json.decode(response.body) as Map<String, dynamic>)
            ..message = TranslationsKeys.requestError;
      completion(error, null);
    }
  }
}
