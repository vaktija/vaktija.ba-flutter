import 'package:flutter/material.dart';
import 'package:vaktijaba_fl/function/dark_mode_check.dart';

class TextHeadlineSmall extends StatelessWidget {
  final text;
  final fontSize;
  final color;

  const TextHeadlineSmall({Key? key, this.text, this.fontSize, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.headlineSmall!;
    return Text(
      text ?? 'vakat ime',
      textScaleFactor: 1.0,
      style: textStyle.copyWith(
        fontWeight: FontWeight.w700,
        color: color,
      ),
    );
  }
}
