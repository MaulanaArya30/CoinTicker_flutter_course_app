import 'package:cointicker_app_flutter_course/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/coin_data.dart';
import 'home_screen.dart';
import '../services/brain.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getExchangeDefaultData("BTC");
  }

  void getExchangeDefaultData(String? coin) async {
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

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return HomeScreen(defaultExchange: rates);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBlue,
      body: Center(
        child: SpinKitThreeBounce(
          color: Colors.white,
          size: 40.0,
        ),
      ),
    );
  }
}
