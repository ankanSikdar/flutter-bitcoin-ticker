import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  final apiKey = '?apikey=C27C770CB08D4B9D8333A22B3993F47A';
  final coinApi = 'https://rest.coinapi.io/v1/exchangerate/';

  Future<Map> getRate(String first, String second) async {
    http.Response response = await http.get('$coinApi$first/$second$apiKey');
    if (response.statusCode == 200) {
      Map data = convert.jsonDecode(response.body);
      return data;
    }
  }
}
