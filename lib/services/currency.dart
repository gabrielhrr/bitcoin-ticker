import 'package:bitcoin_ticker/services/networking.dart';
import 'package:bitcoin_ticker/utilities/keys.dart';
import 'package:flutter/material.dart';

class CurrencyModel {
  Future<dynamic> getCurrencyData(
      String criptoCurrency, String currency) async {
    NetworkHelper networkHelper = NetworkHelper(
      Uri.https(
        'rest.coinapi.io',
        '/v1/exchangerate/$criptoCurrency/$currency',
        {"apikey": apikey},
      ),
    );
    var currencyData = await networkHelper.getData();
    return currencyData;
  }
}
