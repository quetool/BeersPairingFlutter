import 'dart:convert';
import 'package:beers_pairing/models/beer.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('map beer', () async {
    var stringBeer = await rootBundle.loadString('test/utils/beer.json');
    var jsonObject = json.decode(stringBeer) as List;
    var beerList = jsonObject
        .map((dynamic beer) => Beer.fromJson(beer as Map<String, dynamic>))
        .toList();
    var map = beerList.first.toJson();
    expect(map, isA<Map<String, dynamic>>());
  });
}
