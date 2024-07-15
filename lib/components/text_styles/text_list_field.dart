import 'package:flutter/material.dart';

class TextListField extends StatelessWidget {
  final text;

  const TextListField({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyMedium!;
    return Text(
      text ?? 'vakat ime',
      textScaleFactor: 1.0,
      style: textStyle.copyWith(
        fontWeight: FontWeight.w400,
      ),

      // TextStyle(
      //     color: colorGreyDark,
      //     fontSize: 16,
      //     fontWeight: FontWeight.w400
      // ),
    );
  }
}
