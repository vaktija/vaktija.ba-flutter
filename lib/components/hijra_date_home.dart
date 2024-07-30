import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_small.dart';
import 'package:vaktijaba_fl/services/vaktija_state_provider.dart';

import '../data/data.dart';
import '../function/open_new_screen.dart';
import '../location_screen/location_screen.dart';

class HijraDateHome extends StatefulWidget {
  const HijraDateHome({Key? key}) : super(key: key);

  @override
  _HijraDateHomeState createState() => _HijraDateHomeState();
}

class _HijraDateHomeState extends State<HijraDateHome> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    HijriCalendar nowHijri = HijriCalendar.now();
    int danSed = now.weekday-1;
    int dan = now.day;
    int mjesec = now.month - 1;
    int godina = now.year;

    int danHidz = nowHijri.hDay;
    int mjesecHidz = nowHijri.hMonth - 1;
    int godinaHidz = nowHijri.hYear;
    // var vaktijaProvider = vaktijaStateProvider(context);
    // var danSed = vaktijaProvider.currentWeekDay;
    // var dan = vaktijaProvider.currentDay+1;
    // var mjesec = vaktijaProvider.currentMonth;
    // var godina = vaktijaProvider.currentYear;
    // var danHidz = vaktijaProvider.currentDayHijri;
    // var mjesecHidz = vaktijaProvider.currentMonthHijri;
    // var godinaHidz = vaktijaProvider.currentYearHijri;
    return GestureDetector(
      onTap: (){
        openNewScreen(context, LocationScreen(), 'lokacija');
      },
      child: TextBodySmall(
        text: daniSedmiceShort[danSed] +
            ', ' +
            dan.toString() +
            '. ' +
            mjeseci[mjesec] +
            ' ' +
            godina.toString() +
            ' / ' +
            danHidz.toString() +
            '. ' +
            mjeseciHidz[mjesecHidz] +
            ' ' +
            godinaHidz.toString(),
      ),
    );
  }
}
