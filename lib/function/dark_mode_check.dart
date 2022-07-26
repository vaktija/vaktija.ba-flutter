
import 'package:flutter/material.dart';

bool isDarkMode(context){
  var brightness = MediaQuery.of(context).platformBrightness;
  bool darkMode = brightness == Brightness.dark ? true : false;
  return darkMode;
}