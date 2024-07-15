import 'package:flutter/material.dart';
import 'package:vaktijaba_fl/app_theme/theme_data.dart';

class TextVakatTime extends StatelessWidget {
  final text;

  const TextVakatTime({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headlineMedium!;
    return Text(
      text ?? 'vakat vrijeme',
      textScaleFactor: 1.0,
      style: textStyle.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: AppFont.sizeHeadlineM + 4.0,
        color: textStyle.color!.withOpacity(0.65),
      ),
    );
  }
}
