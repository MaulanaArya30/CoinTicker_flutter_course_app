import 'package:cointicker_app_flutter_course/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
    getExchangeDefaultData();
  }

  void getExchangeDefaultData() async {
    Brain brain = Brain(
      coin: 'BTC',
      currency: 'USD',
    );
    var rate = await brain.getExchangeRate();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return HomeScreen(defaultExchange: rate);
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
