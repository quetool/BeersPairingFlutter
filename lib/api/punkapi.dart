import 'dart:convert';

import 'package:beers_pairing/models/beer.dart';
import 'package:beers_pairing/models/error.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  var rootApi = "https://api.punkapi.com/v2";
  var allBeers = "/beers";
  var randomBeer = "/random";

  Future<http.Response> getMeRandomBeer() {
    return http.get(rootApi + allBeers + randomBeer);
  }

  Future<http.Response> getBeerDetails(int beerId) {
    return http.get(rootApi + allBeers + "/$beerId");
  }

  Future<http.Response> getAllBeers(String byFood, int fromPage, int perPage) {
    var parameters = "?page=$fromPage&per_page=$perPage";
    if (byFood != "") {
      var food = byFood.trim().replaceAll(" ", "_");
      parameters += "&food=$food";
    }
    return http.get(rootApi + allBeers + parameters);
  }

  Future<http.Response> retryRequestAfterFail(String request) {
    return http.get(request);
  }

  void responseHandler(
      http.Response response, Function(ApiError error, List<Beer>) completion) {
    if (response.statusCode == 200) {
      try {
        List<dynamic> jsonArray = json.decode(response.body);
        List<Beer> sortedList = jsonArray.map((e) => Beer.fromJson(e)).toList()
          ..sort((a, b) => a.abv.compareTo(b.abv));
        completion(null, sortedList);
      } catch (e) {
        var error = ApiError()
          ..message = "Couldn't serialize response"
          ..statusCode = response.statusCode
          ..error = e.toString();
        completion(error, null);
      }
    } else {
      completion(ApiError.fromJson(json.decode(response.body)), null);
    }
  }
}
