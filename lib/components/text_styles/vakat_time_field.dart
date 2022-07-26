import 'package:flutter/material.dart';

import '../../data/data.dart';

class TextVakatTime extends StatelessWidget {
  final text;
  const TextVakatTime({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        text ?? 'vakat vrijeme',
      textScaleFactor: 1.0,
      style: TextStyle(
          color: colorGreyLight,
          fontSize: 28,
          fontWeight: FontWeight.w700
      ),
    );
  }
}
