import 'package:flutter/material.dart';
import 'package:vaktijaba_fl/function/dark_mode_check.dart';

import '../../data/data.dart';

class TextSubtitle extends StatelessWidget {
  final text;
  final italic;
  final color;
  const TextSubtitle({Key? key, this.text, this.italic, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkModeOn = isDarkMode(context);
    bool isItalic = italic ?? false;
    return Text(
        text ?? 'preostalo vrijeme',
      textScaleFactor: 1.0,
      style: TextStyle(
          color: color ?? (isDarkModeOn ? colorWhite : colorGreyDark),
          fontSize: 14,
          fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
          fontWeight: FontWeight.w300
      ),
    );
  }
}
