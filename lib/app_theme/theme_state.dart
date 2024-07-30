import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaktijaba_fl/data/app_data.dart';

List<ThemeMode> themeModes = [
  ThemeMode.light,
  ThemeMode.system,
  ThemeMode.dark
];

int themeModeInit = 1;
double fontSizeIncreaseInit = 0.0;

class StateAppTheme extends ChangeNotifier {
  //bool _darkTheme = darkModeInitValue;
  //bool _darkThemeAuto = darkModeAutoInitValue;
  int _themeMode = themeModeInit;
  double _fontSizeMultiplier = fontSizeIncreaseInit;

  int get themeMode => _themeMode;

  double get fontSizeMultiplier => _fontSizeMultiplier;

  setThemeMode(int index) {
    _themeMode = index;
    notifyListeners();
    saveThemeModeData();
  }

  setFontSize(double value) {
    _fontSizeMultiplier = value;
    notifyListeners();
    saveThemeModeData();
  }

  saveThemeModeData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt(SpKeys.initThemeMode, _themeMode);
    sp.setDouble(SpKeys.initFontSizeMultiplier, _fontSizeMultiplier);
    //print('status teme, ${_themeMode}');
  }
}
