import 'package:bitcoin_ticker/services/currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'services/networking.dart';
import 'components/reusable_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';
  String selectedCriptoCurrency = 'BTC';
  String bTCRate = 'no value';
  String eTHRate = 'no value';
  String lTCRate = 'no value';
  bool isWaiting = false;

  @override
  void initState() {
    super.initState();
    getCurrencyData();
  }

  void getCurrencyData() async {
    isWaiting = true;

    var bTCData =
        await CurrencyModel().getCurrencyData('BTC', selectedCurrency);
    if (bTCData != null) bTCRate = bTCData['rate'].toInt().toString();
    var eTHData =
        await CurrencyModel().getCurrencyData('ETH', selectedCurrency);
    if (eTHData != null) eTHRate = eTHData['rate'].toInt().toString();
    var lTCData =
        await CurrencyModel().getCurrencyData('LTC', selectedCurrency);
    if (lTCData != null) lTCRate = lTCData['rate'].toInt().toString();
  }

  List<DropdownMenuItem> getDropdownItems() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var dropdownItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(dropdownItem);
    }
    return dropdownItems;
  }

  DropdownButton getAndroidDropdown() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: getDropdownItems(),
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getCurrencyData();
        });
      },
    );
  }

  CupertinoPicker getIOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      var pickerItem = Text(currency, style: TextStyle(color: Colors.white));
      pickerItems.add(pickerItem);
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (int index) {
        setState(() {
          selectedCurrency = pickerItems[index].data;
          print(pickerItems[index].data);
          getCurrencyData();
        });
      },
      children: pickerItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              children: [
                ReusableCard('BTC', selectedCurrency, bTCRate, isWaiting),
                ReusableCard('ETH', selectedCurrency, eTHRate, isWaiting),
                ReusableCard('LTC', selectedCurrency, lTCRate, isWaiting),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Theme.of(context).platform == TargetPlatform.iOS
                ? getIOSPicker()
                : getAndroidDropdown(),
          ),
        ],
      ),
    );
  }
}
