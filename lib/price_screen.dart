import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'price_brain.dart';
import 'dart:io' show Platform;
import 'coin_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String btc= '💰';
  String eth = '💰';
  String ltc = '💰';
  PriceBrain price = PriceBrain();

  @override
  void initState() {
    selectedCurrency = 'USD';
    getPrices();
    super.initState();
  }

  void getPrices() async {

    var coinPrices = await price.getCoinPrices(currency: selectedCurrency);
    updateUI(coinPrices);
  }

  void updateUI(priceData) {
    setState(() {
      String btcPrice = priceData['BTC'].toStringAsFixed(2);
      String ethPrice = priceData['ETH'].toStringAsFixed(2);
      String ltcPrice = priceData['LTC'].toStringAsFixed(2);

      btc = btcPrice;
      eth = ethPrice;
      ltc = ltcPrice;
    });
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(child: Text(currency), value: currency);

      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;

        });
        getPrices();
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      var newItem = Text(currency);
      pickerItems.add(newItem);
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {},
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
          CoinCard(coin: 'BTC', currency: selectedCurrency, price: btc),
          CoinCard(coin: 'ETH', currency: selectedCurrency, price: eth),
          CoinCard(coin: 'LTC', currency: selectedCurrency, price: ltc),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
