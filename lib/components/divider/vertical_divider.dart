import 'package:flutter/material.dart';

class DividerCustomVertical extends StatelessWidget {
  final double? width;
  const DividerCustomVertical({Key? key, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      color: Theme.of(context).dividerColor,
      width: width ?? 1.0,
      thickness: 1.0,
    );
  }
}
