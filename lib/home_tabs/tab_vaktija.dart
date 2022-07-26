import 'package:flutter/material.dart';
import 'package:vaktijaba_fl/components/hijra_date_home.dart';
import 'package:vaktijaba_fl/components/location_field_home.dart';
import 'package:vaktijaba_fl/components/vakat_field.dart';
import 'package:vaktijaba_fl/components/vertical_separator.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/function/dark_mode_check.dart';

class HomeTabVaktija extends StatefulWidget {
  const HomeTabVaktija({Key? key}) : super(key: key);

  @override
  _HomeTabVaktijaState createState() => _HomeTabVaktijaState();
}

class _HomeTabVaktijaState extends State<HomeTabVaktija> {
  @override
  Widget build(BuildContext context) {
    bool isDarkModeOn = isDarkMode(context);
    return Scaffold(
      backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LocationFieldHome(),
          VerticalListSeparator(
            height: 1,
          ),
          HijraDateHome(),
          VerticalListSeparator(
            height: 4,
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                  vaktoviName.length,
                  (index) => VakatField(
                        index: index,
                      )
              ),
            ),
        ],
      ),
    );
  }
}
