import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  final text;
  const AppBarTitle({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textScaleFactor: 1.0,
      style: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.w600,
        fontSize: 20
      ),
    );
  }
}
