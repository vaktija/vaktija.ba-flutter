import 'package:flutter/material.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/function/dark_mode_check.dart';

class TextTitle extends StatelessWidget {
  final text;
  final bold;
  final color;
  const TextTitle({Key? key, this.text, this.bold, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkModeOn = isDarkMode(context);
    final isBold = bold ?? false;
    return Text(
      text ?? 'vakat ime',
      textScaleFactor: 1.0,
      style: TextStyle(
          color: color ?? (isDarkModeOn ? colorWhite : colorGreyDark),
          fontSize: isBold ? 16:16,
          fontWeight: isBold ? FontWeight.w700 : FontWeight.w500
      ),
    );
  }
}
