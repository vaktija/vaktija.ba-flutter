import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/function/dark_mode_check.dart';

class ScreenLoader extends StatelessWidget {
  const ScreenLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkModeOn = isDarkMode(context);
    return Center(
      child: Platform.isAndroid ?
      CircularProgressIndicator(
        color: isDarkModeOn ? Colors.white : Colors.grey,
      ) : CupertinoActivityIndicator(color: isDarkModeOn ? Colors.white : Colors.grey),
    );
  }
}
