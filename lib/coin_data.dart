import 'dart:convert';
import 'package:http/http.dart' as http;

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

const coinAPIURL =
    'https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD,JPY,EUR';
const apiKey = 'YOUR-API-KEY-HERE';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestURL = '$coinAPIURL$crypto&tsyms=$selectedCurrency';
      http.Response response = await http.get(requestURL);
      if (response.statusCode == 200) {
        var decodeData = jsonDecode(response.body);
        double price = decodeData[selectedCurrency];
        cryptoPrices[crypto] = price.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
//      print(requestURL);
    }
    return cryptoPrices;
  }
}
