import 'package:flutter/material.dart';
import '../data/data.dart';

class VerticalListSeparator extends StatelessWidget {
  final height;
  const VerticalListSeparator({Key? key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: defaultPadding*(height ?? 2),
      width: 1,
    );
  }
}