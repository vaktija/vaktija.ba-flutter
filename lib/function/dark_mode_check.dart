
import 'package:flutter/material.dart';

bool isDarkMode(context){
  var brightness = Theme.of(context).brightness;
  bool darkMode = brightness == Brightness.dark ? true : false;
  return darkMode;
}