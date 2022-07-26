import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaktijaba_fl/components/screen_loader.dart';
import 'package:vaktijaba_fl/function/dark_mode_check.dart';
import 'package:vaktijaba_fl/home/home_screen.dart';
import 'package:vaktijaba_fl/services/state_provider.dart';

import '../data/data.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    var vaktijaDataBase =
        json.decode(await rootBundle.loadString('assets/vaktija/vaktija.json'));
    setState(() {
      gradovi = vaktijaDataBase['locations'];
      differences = vaktijaDataBase['differences'];
      vaktijaData = vaktijaDataBase['vaktija'];
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _vaktijaSaveData = prefs.getString(prefsVaktijaSaveDataKey) ?? null;

    Future.delayed(Duration(milliseconds: 1), () {
      if (_vaktijaSaveData != null) {
        var vaktijaSaveData = jsonDecode(_vaktijaSaveData);
        restoreSavedVaktijaData(context, vaktijaSaveData);
      }
      startVaktijaTimerCheck(context);
      setState(() {
        isLoading = false;
      });
      // Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkModeOn = isDarkMode(context);
    return Scaffold(
      backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
      body: isLoading ? ScreenLoader() : HomeScreen(),
    );
  }
}
