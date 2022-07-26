import 'package:flutter/material.dart';

import '../../data/data.dart';

class TextListField extends StatelessWidget {
  final text;
  const TextListField({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? 'vakat ime',
      textScaleFactor: 1.0,
      style: TextStyle(
          color: colorGreyDark,
          fontSize: 16,
          fontWeight: FontWeight.w400
      ),
    );
  }
}
