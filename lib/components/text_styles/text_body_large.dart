import 'package:flutter/material.dart';

class TextBodyLarge extends StatelessWidget {
  final String? text;
  final bool? bold;
  final Color? color;

  const TextBodyLarge({Key? key, this.text, this.bold, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bool isDarkModeOn = isDarkMode(context);
    final isBold = bold ?? false;
    TextStyle textStyle = Theme.of(context).textTheme.bodyLarge!;
    return Text(
      text ?? 'Text_Body_Large',
      textScaleFactor: 1.0,
      style: textStyle.copyWith(
        color: color,
        fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
      ),
    );
  }
}
