import 'package:flutter/material.dart';
import 'package:mercadinho/src/config/custom_colors.dart';

class AppNameWidget extends StatelessWidget {
  final Color? greenTitleColor;
  final double textSize;

  const AppNameWidget({
    super.key,
    this.greenTitleColor,
    this.textSize = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: textSize,
        ),
        children: [
          TextSpan(
            text: 'Mer',
            style: TextStyle(
              color: greenTitleColor ?? Colors.amber,
              fontWeight: FontWeight.bold,
            ),
          ),
          const TextSpan(
            text: 'ca',
            style: TextStyle(
              color: Colors.brown,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'di',
            style: TextStyle(
              color: CustomColors.customConstrastColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const TextSpan(
            text: 'nho',
            style: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
