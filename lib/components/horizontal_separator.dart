import 'package:flutter/material.dart';
import '../data/data.dart';

class HorizontalListSeparator extends StatelessWidget {
  final width;
  const HorizontalListSeparator({Key? key, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: defaultPadding*(width ?? 2),
      height: 1,
    );
  }
}