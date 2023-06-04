import 'package:flutter/material.dart';
import './constant.dart';

class CoinWidget extends StatelessWidget {
  const CoinWidget({
    super.key,
    required this.coin,
    required this.onTap,
  });

  final String coin;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 20),
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 23,
        width: 114,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Text(
          coin,
          style: kCoinWidgetTextStyle,
        ),
      ),
    );
  }
}
