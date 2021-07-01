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
  String btc = '💰';
  String eth = '💰';
  String ltc = '💰';
  String bnb = '💰';
  String xrp = '💰';
  String ada = '💰';
  String sol = '💰';
  String dot = '💰';
  String uni = '💰';
  String doge = '💰';
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
      String bnbPrice = priceData['BNB'].toStringAsFixed(2);
      String xrpPrice = priceData['XRP'].toStringAsFixed(2);
      String adaPrice = priceData['ADA'].toStringAsFixed(2);
      String solPrice = priceData['SOL'].toStringAsFixed(2);
      String uniPrice = priceData['UNI'].toStringAsFixed(2);
      String dogePrice = priceData['DOGE'].toStringAsFixed(2);
      String dotPrice = priceData['DOT'].toStringAsFixed(2);

      btc = btcPrice;
      eth = ethPrice;
      ltc = ltcPrice;
      bnb = bnbPrice;
      xrp = xrpPrice;
      ada = adaPrice;
      sol = solPrice;
      uni = uniPrice;
      doge = dogePrice;
      dot = dotPrice;
    });
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
          child: Text(
            currency,
            style: TextStyle(fontSize: 20.0),
          ),
          value: currency);

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
      var newItem = Text(
        currency,
        style: TextStyle(fontSize: 20.0),
      );
      pickerItems.add(newItem);
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
        });
        getPrices();
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
        children: [
          Expanded(
            child: ListView(
              children: [
                CoinCard(coin: 'BTC', currency: selectedCurrency, price: btc),
                CoinCard(coin: 'ETH', currency: selectedCurrency, price: eth),
                CoinCard(coin: 'BNB', currency: selectedCurrency, price: bnb),
                CoinCard(coin: 'ADA', currency: selectedCurrency, price: ada),
                CoinCard(coin: 'DOGE', currency: selectedCurrency, price: doge),
                CoinCard(coin: 'XRP', currency: selectedCurrency, price: xrp),
                CoinCard(coin: 'DOT', currency: selectedCurrency, price: dot),
                CoinCard(coin: 'UNI', currency: selectedCurrency, price: uni),
                CoinCard(coin: 'SOL', currency: selectedCurrency, price: sol),
                CoinCard(coin: 'LTC', currency: selectedCurrency, price: ltc),
              ],
            ),
          ),
          Container(
            height: 70.0,
            alignment: Alignment.center,
            color: Color(0xFF96b497),
            child: Center(
              child: Platform.isIOS ? iOSPicker() : androidDropdown(),
            ),
          ),
        ],
      ),
    );
  }
}
