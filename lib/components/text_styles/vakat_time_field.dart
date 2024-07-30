import 'package:flutter/material.dart';

class TextVakatTime extends StatelessWidget {
  final text;
  final Color? color;

  const TextVakatTime({Key? key, this.text, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headlineLarge!;
    return Text(
      text ?? 'vakat vrijeme',
      textScaleFactor: 1.0,
      style: textStyle.copyWith(
        fontWeight: FontWeight.w700,
        //fontSize: AppFont.sizeHeadlineL + 6.0,
        color: color ?? textStyle.color!.withOpacity(0.65),
      ),
    );
  }
}
