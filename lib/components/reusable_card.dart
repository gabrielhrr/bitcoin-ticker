import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final String criptocurrency;
  final String currency;
  final String rate;
  final bool isWaiting;

  ReusableCard(this.criptocurrency, this.currency, this.rate, this.isWaiting);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $criptocurrency = ${isWaiting ? '?' : rate} $currency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
