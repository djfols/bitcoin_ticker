import 'dart:convert';

import 'package:http/http.dart' as http;
import 'constants.dart';
import 'coin_data.dart';

class PriceBrain {
  String coin;
  String currency;

  Map<String, double> prices = {};

Future<Map<String, double>> getCoinPrices({String currency}) async {

    for(coin in cryptoList) {
      http.Response response = await http.get((Uri.parse('https://rest.coinapi.io/v1/exchangerate/$coin/$currency?apiKey=$apiKey')));
      prices[coin] = jsonDecode(response.body)['rate'];
    }

    return prices;
  }
}