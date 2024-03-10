import 'package:flutter_currency_converter/models/currenciesModel.dart';
import 'package:flutter_currency_converter/models/latestRateModel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

String? apiKey = dotenv.env['API_KEY'];

Future<Map> getCurrencies() async {
  var response = await http.get(Uri.parse(
      "https://openexchangerates.org/api/currencies.json?app_id=$apiKey"));

  final allCurrencies = currenciesFromJson(response.body);
  return allCurrencies;
}

Future<LatestRates> getRates() async {
  var response = await http.get(Uri.parse(
      "https://openexchangerates.org/api/latest.json?app_id=$apiKey"));

  final latestRates = latestRatesFromJson(response.body);
  return latestRates;
}

// The base currency is USD this function all to convert from and To any currency
String convertany(Map exchangeRates, String amount, String currencybase,
    String currencyfinal) {
  String output = (double.parse(amount) /
          exchangeRates[currencybase] *
          exchangeRates[currencyfinal])
      .toStringAsFixed(2)
      .toString();

  return output;
}
