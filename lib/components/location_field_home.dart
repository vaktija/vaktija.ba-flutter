import 'package:flutter/material.dart';
import 'package:vaktijaba_fl/components/horizontal_separator.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_medium.dart';
import 'package:vaktijaba_fl/components/text_styles/text_headline_small.dart';
import 'package:vaktijaba_fl/data/constants.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/function/dark_mode_check.dart';
import 'package:vaktijaba_fl/function/open_new_screen.dart';
import 'package:vaktijaba_fl/location_screen/location_screen.dart';

import '../services/state_provider.dart';

class LocationFieldHome extends StatefulWidget {
  const LocationFieldHome({Key? key}) : super(key: key);

  @override
  _LocationFieldHomeState createState() => _LocationFieldHomeState();
}

class _LocationFieldHomeState extends State<LocationFieldHome> {
  @override
  Widget build(BuildContext context) {
    bool isDarkModeOn = isDarkMode(context);
    var vaktijaProvider = vaktijaStateProvider(context);
    int grad = vaktijaProvider.currentLocation;
    return GestureDetector(
      onTap: (){
        openNewScreen(context, LocationScreen(), 'lokacija');
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: defaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              size: 22.0,
              color: Theme.of(context).indicatorColor,// isDarkModeOn ? colorWhite : colorGreyDark,
            ),
            gap16,
            TextHeadlineSmall(
              text: gradovi[grad],
              fontSize: 32.0,
            ),
          ],
        ),
      ),
    );
  }
}
