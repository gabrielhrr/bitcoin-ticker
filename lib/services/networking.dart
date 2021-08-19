import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bitcoin_ticker/utilities/keys.dart';

const String urlPrefix = 'https://rest.coinapi.io/v1/exchangerate';

class NetworkHelper {
  Uri url;

  NetworkHelper(this.url);

  Future getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}
