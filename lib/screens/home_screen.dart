import 'package:flutter/material.dart';
import '../services/brain.dart';
import '../services/coin_data.dart';
import '../utilities/constant.dart';
import '../utilities/coin_widget.dart';
import '../utilities/converter_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.defaultExchange});

  final defaultExchange;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ConverterWidget> converterList = [];

  @override
  void initState() {
    super.initState();
    updateUI(widget.defaultExchange);
  }

  List<ConverterWidget> updateUI(dynamic exchangeData) {
    for (var brain in widget.defaultExchange) {
      var newItem = ConverterWidget(
        coin: brain.coin,
        currency: brain.currency,
        price: brain.rate,
      );
      converterList.add(newItem);
    }
    return converterList;
  }

  Future<List> getExchangeData(String? coin) async {
    List<Brain> rates = [];
    for (var currency in currenciesList) {
      Brain brain = Brain(
        coin: coin,
        currency: currency,
      );
      brain.rate = await brain.getExchangeRate();
      brain.rate = brain.rate['rate'].toStringAsFixed(2);
      rates.add(brain);
    }
    return rates;
  }

  List<CoinWidget> getCoinWidget() {
    List<CoinWidget> coinWidgetList = [];
    for (String coins in cryptoList) {
      var newItem = CoinWidget(
          coin: coins,
          onTap: () async {
            var newexchange = getExchangeData("$coins");
            setState(() {
              updateUI(newexchange);
            });
            print("tap $coins");
          });
      coinWidgetList.add(newItem);
    }
    return coinWidgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBlue,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'CoinTicker',
                style: kTitleTextStyle,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: getCoinWidget(),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 12,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: converterList,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
