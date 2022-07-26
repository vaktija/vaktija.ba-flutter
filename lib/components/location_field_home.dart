import 'package:flutter/material.dart';
import 'package:vaktijaba_fl/components/horizontal_separator.dart';
import 'package:vaktijaba_fl/components/text_styles/text_title.dart';
import 'package:vaktijaba_fl/components/text_styles/text_title_big.dart';
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
              size: 32,
              color: isDarkModeOn ? colorWhite : colorGreyDark,
            ),
            HorizontalListSeparator(width: 1,),
            TextTitleBig(
              text: gradovi[grad],
              fontSize: 32.0,
            ),
          ],
        ),
      ),
    );
  }
}
