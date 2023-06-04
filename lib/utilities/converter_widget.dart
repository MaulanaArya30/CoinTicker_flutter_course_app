import 'package:flutter/material.dart';
import 'constant.dart';

class ConverterWidget extends StatefulWidget {
  const ConverterWidget({
    super.key,
    required this.currency,
    required this.coin,
    this.price,
  });

  final String currency;
  final String coin;
  final String? price;

  @override
  State<ConverterWidget> createState() => _ConverterWidgetState();
}

class _ConverterWidgetState extends State<ConverterWidget> {
  late String currency;
  late String coin;
  late String? price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: kMainBlue,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 ${widget.coin} = ${widget.price} ${widget.currency}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
