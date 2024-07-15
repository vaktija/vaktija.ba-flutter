import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vaktijaba_fl/components/hijra_date_home.dart';
import 'package:vaktijaba_fl/components/location_field_home.dart';
import 'package:vaktijaba_fl/components/vakat_field.dart';
import 'package:vaktijaba_fl/data/constants.dart';
import 'package:vaktijaba_fl/data/data.dart';

class HomeTabVaktija extends StatefulWidget {
  const HomeTabVaktija({Key? key}) : super(key: key);

  @override
  _HomeTabVaktijaState createState() => _HomeTabVaktijaState();
}

class _HomeTabVaktijaState extends State<HomeTabVaktija> {
  Timer timer = Timer(Duration(seconds: 0), () {});

  @override
  void initState() {
    super.initState();
    startRefreshTimer();
  }

  startRefreshTimer() {
    if (timer.isActive) {
      timer.cancel();
    }
    timer = Timer(Duration(seconds: 1), () {
      setState(() {});
      startRefreshTimer();
    });
  }

  @override
  void dispose() {
    if (timer.isActive) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //bool isDarkModeOn = isDarkMode(context);
    return Scaffold(
      //backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LocationFieldHome(),
          gap4,
          HijraDateHome(),
          gap32,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
                vaktoviName.length,
                (index) => VakatField(
                      index: index,
                    )),
          ),
        ],
      ),
    );
  }
}
