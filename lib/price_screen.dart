import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currentCurrency = 'USD';
  int rate1;
  int rate2;
  int rate3;

  DropdownButton androidDropDown() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      dropDownItems.add(DropdownMenuItem(
        child: Text(currency),
        value: currency,
      ));
    }

    return DropdownButton(
      value: currentCurrency,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          currentCurrency = value;
          getData();
        });
      },
    );
  }

  CupertinoPicker getIOSPicker() {
    List<Text> items = [];
    for (String currency in currenciesList) {
      items.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          currentCurrency = currenciesList[selectedIndex];
          getData();
        });
      },
      children: items,
    );
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      return CupertinoPicker();
    } else if (Platform.isAndroid) {
      return androidDropDown();
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    CoinData coinData = CoinData();
    Map data1 = await coinData.getRate(cryptoList[0], currentCurrency);
    Map data2 = await coinData.getRate(cryptoList[1], currentCurrency);
    Map data3 = await coinData.getRate(cryptoList[2], currentCurrency);
    setState(() {
      rate1 = data1['rate'].toInt();
      rate2 = data2['rate'].toInt();
      rate3 = data3['rate'].toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('💱 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  rate1 != null
                      ? '1 ${cryptoList[0]} = $rate1 $currentCurrency'
                      : '1 ${cryptoList[0]} = ? $currentCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  rate2 != null
                      ? '1 ${cryptoList[1]} = $rate2 $currentCurrency'
                      : '1 ${cryptoList[1]} = ? $currentCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  rate3 != null
                      ? '1 ${cryptoList[2]} = $rate3 $currentCurrency'
                      : '1 ${cryptoList[2]} = ? $currentCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getIOSPicker(),
          )
        ],
      ),
    );
  }
}

//Platform.isIOS ? getIOSPicker() : androidDropDown()
