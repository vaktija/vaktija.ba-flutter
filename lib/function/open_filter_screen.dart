import 'package:flutter/material.dart';
import 'package:vaktijaba_fl/data/data.dart';

void openFilterScreen(context, filterScreen) {
  final topPadding = MediaQuery.of(context).padding.top;
  showGeneralDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) {
      return SafeArea(
        bottom: false,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(defaultPadding * 2),
              topRight: Radius.circular(defaultPadding * 2)),
          child: filterScreen,
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
        child: child,
      );
    },
  );
}