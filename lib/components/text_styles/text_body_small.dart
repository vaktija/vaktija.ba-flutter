import 'package:flutter/material.dart';

class TextBodySmall extends StatelessWidget {
  final text;
  final italic;
  final color;
  final TextAlign? textAlign;

  const TextBodySmall({Key? key, this.text, this.italic, this.color, this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //bool isDarkModeOn = isDarkMode(context);
    bool isItalic = italic ?? false;
    TextStyle textStyle = Theme.of(context).textTheme.bodySmall!;
    return Text(
      text ?? 'preostalo vrijeme',
      textScaleFactor: 1.0,
      textAlign: textAlign,
      style: textStyle.copyWith(
        color: color,
        fontWeight: FontWeight.w300,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
      ),
    );
  }
}
