import 'package:beers_pairing/api/punkapi.dart';
import 'package:beers_pairing/models/beer.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('#succes ', () {
    test('random beer', () async {
      final apiClient = ApiClient()
        ..client = MockClient((http.Request request) async {
          var randomBeerBody =
              await rootBundle.loadString('test/utils/beer.json');
          return http.Response(
            randomBeerBody,
            200,
            headers: {
              'content-type': 'application/json; charset=utf-8',
            },
          );
        });

      final randomBeer = await apiClient.getMeRandomBeer();
      apiClient.responseHandler(randomBeer, (error, beers) {
        expect(beers.length, 1);
        expect(beers, isA<List<Beer>>());
      });
    });

    test('all beers from page 1', () async {
      final apiClient = ApiClient()
        ..client = MockClient((http.Request request) async {
          var randomBeerBody =
              await rootBundle.loadString('test/utils/beer.json');
          return http.Response(
            randomBeerBody,
            200,
            headers: {
              'content-type': 'application/json; charset=utf-8',
            },
          );
        });

      final response = await apiClient.getAllBeers('cheese', 1, 20);
      apiClient.responseHandler(response, (error, beers) {
        expect(beers, isA<List<Beer>>());
      });
    });

    test('all beers from page 1 with failure data', () async {
      final apiClient = ApiClient()
        ..client = MockClient((http.Request request) async {
          // var randomBeerBody =
          //     await rootBundle.loadString('test/utils/beer.json');
          return http.Response(
            '[{"id": 74,"name": "Eurotrash"]',
            200,
            headers: {
              'content-type': 'application/json; charset=utf-8',
            },
          );
        });

      final response = await apiClient.getAllBeers('cheese', 1, 20);
      apiClient.responseHandler(response, (error, beers) {
        expect(error, isNotNull);
      });
    });
  });

  group('#failure', () {
    test('all beers from page 0', () async {
      final apiClient = ApiClient()
        ..client = MockClient((http.Request request) async {
          var errorBody = await rootBundle.loadString('test/utils/error.json');
          return http.Response(
            errorBody,
            400,
            headers: {
              'content-type': 'application/json; charset=utf-8',
            },
          );
        });

      final response = await apiClient.getAllBeers('', 0, 20);
      apiClient.responseHandler(response, (error, beers) {
        expect(error, isNotNull);
      });
    });
  });
}
