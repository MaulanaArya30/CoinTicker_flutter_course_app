import 'package:flutter/material.dart';
import '../services/coin_data.dart';
import '../utilities/constant.dart';
import '../utilities/coin_widget.dart';
import '../utilities/converter_widget.dart';
import '../services/networking.dart';
import '../services/brain.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.defaultExchange});

  final defaultExchange;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double price;
  late String coin;
  late String currency;
  var selectedCoin = true;

  @override
  void initState() {
    super.initState();
    updateUI(widget.defaultExchange);
  }

  List<CoinWidget> getCoinWidget() {
    List<CoinWidget> coinList = [];
    for (String coins in cryptoList) {
      var newItem = CoinWidget(
          coin: coins,
          onTap: () async {
            Brain brain = Brain(
              coin: coins,
              currency: 'USD',
            );
            var rate = await brain.getExchangeRate();
            updateUI(rate);
          });
      coinList.add(newItem);
    }
    return coinList;
  }

  void updateUI(dynamic exchangeData) {
    setState(() {
      if (exchangeData == null) {
        coin = 'coin';
        currency = 'currency';
        price = 0;
        return;
      }
      coin = exchangeData['asset_id_base'];
      currency = exchangeData['asset_id_quote'];
      price = exchangeData['rate'];
    });
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ConverterWidget(
                        coin: coin,
                        currency: currency,
                        price: price.toStringAsFixed(2),
                      ),
                      ConverterWidget(
                        coin: coin,
                        currency: 'AUD',
                        price: price.toStringAsFixed(2),
                      ),
                    ],
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
