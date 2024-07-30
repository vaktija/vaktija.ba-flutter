import 'package:flutter/material.dart';

class TextBodyMedium extends StatelessWidget {
  final text;
  final bold;
  final color;
  final TextAlign? textAlign;

  const TextBodyMedium({
    Key? key,
    this.text,
    this.bold,
    this.color,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bool isDarkModeOn = isDarkMode(context);
    final isBold = bold ?? false;
    TextStyle textStyle = Theme.of(context).textTheme.bodyMedium!;
    return Text(
      text ?? 'TextBodyMedium',
      textScaleFactor: 1.0,
      textAlign: textAlign,
      style: textStyle.copyWith(
        color: color,
        fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
      ),
    );
  }
}
