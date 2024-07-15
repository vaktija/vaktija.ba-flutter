import 'package:flutter/material.dart';

class DividerCustomHorizontal extends StatelessWidget {
  final double? height;
  const DividerCustomHorizontal({Key? key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Theme.of(context).dividerColor,
      height: height ?? 1.0,
      thickness: 1.0,
    );
  }
}
