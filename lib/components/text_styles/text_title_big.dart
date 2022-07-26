import 'package:flutter/material.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/function/dark_mode_check.dart';

class TextTitleBig extends StatelessWidget {
  final text;
  final fontSize;
  final color;
  const TextTitleBig({Key? key, this.text, this.fontSize, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkModeOn = isDarkMode(context);
    return Text(
        text ?? 'vakat ime',
      textScaleFactor: 1.0,
        style: TextStyle(
          color: color ?? (isDarkModeOn ? colorWhite : colorGreyDark),
          fontSize: fontSize ?? 24,
          fontWeight: FontWeight.w700
        ),
    );
  }
}
