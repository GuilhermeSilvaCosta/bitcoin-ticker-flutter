import 'package:bitcoin_ticker/clients/coin_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  static CoinApi coinApi = CoinApi();

  String selectedCurrency = 'USD';
  String ratingBTCtoUSD = 'loading...';
  String ratingETHtoUSD = 'loading...';
  String ratingLTCtoUSD = 'loading...';

  DropdownButton<String> getAndroidDropDown() { 

    List<DropdownMenuItem<String>> items = [];
    for (String currency in currenciesList) {
      DropdownMenuItem<String> newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      items.add(newItem);
    }

    return DropdownButton(
      value: selectedCurrency,
      items: items, 
      onChanged: (String? value) { 
        updateUI(value!);
      },
    );
  }

  CupertinoPicker getIOsPicker() {

    List<Text> items = [];
    for (String currency in currenciesList) {
      Text newItem = Text(currency);
      items.add(newItem);
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        String selectedCurrency = currenciesList[selectedIndex];
        updateUI(selectedCurrency);
      },
      children: items,
    );
  }

  Widget getPicker() => Platform.isIOS ? getIOsPicker() : getAndroidDropDown();

  Future<String> getBTCRate(String selected) async {
    return (await coinApi.getBTCRate(selected)).toStringAsFixed(2);
  }

  Future<String> getETHRate(String selected) async {
    return (await coinApi.getETHRate(selected)).toStringAsFixed(2);
  }

  Future<String> getLTCRate(String selected) async {
    return (await coinApi.getLTCRate(selected)).toStringAsFixed(2);
  }

  void updateUI(String selectedCurrency) async {
    String ratingBTCtoUSD = await getBTCRate(selectedCurrency);
    String ratingETHtoUSD = await getETHRate(selectedCurrency);
    String ratingLTCtoUSD = await getLTCRate(selectedCurrency);
    setState(() {
      this.selectedCurrency = selectedCurrency;
      this.ratingBTCtoUSD = ratingBTCtoUSD;
      this.ratingETHtoUSD = ratingETHtoUSD;
      this.ratingLTCtoUSD = ratingLTCtoUSD;
    });
  }

  @override
  void initState() {
    super.initState();
    updateUI(selectedCurrency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = $ratingBTCtoUSD $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = $ratingETHtoUSD $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = $ratingLTCtoUSD $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          ),
        ],
      ),
    );
  }
}