import 'package:flutter/material.dart';

class TextBodyMedium extends StatelessWidget {
  final text;
  final bold;
  final color;

  const TextBodyMedium({Key? key, this.text, this.bold, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bool isDarkModeOn = isDarkMode(context);
    final isBold = bold ?? false;
    TextStyle textStyle = Theme.of(context).textTheme.bodyMedium!;
    return Text(
      text ?? 'vakat ime',
      textScaleFactor: 1.0,
      style: textStyle.copyWith(
        color: color,
        fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
      ),
    );
  }
}
