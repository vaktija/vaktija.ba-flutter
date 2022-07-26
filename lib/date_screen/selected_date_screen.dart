import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:vaktijaba_fl/components/text_styles/text_title.dart';
import 'package:vaktijaba_fl/components/text_styles/text_title_big.dart';
import 'package:vaktijaba_fl/components/vertical_divider.dart';
import 'package:vaktijaba_fl/components/vertical_separator.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/function/dark_mode_check.dart';
import 'package:vaktijaba_fl/function/date_2_hijra.dart';
import 'package:vaktijaba_fl/function/sec_2_hhmm.dart';
import 'package:vaktijaba_fl/services/calendar_state_provider.dart';
import 'package:vaktijaba_fl/services/state_provider.dart';


class SelectedDateScreen extends StatelessWidget {
  const SelectedDateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkModeOn = isDarkMode(context);
    var vaktijaProvider = vaktijaStateProvider(context);
    int grad = vaktijaProvider.currentLocation;
    DateTime date = calendarPickerStateProvider(context).selectedDateTime;
    //var h_date = HijriCalendar.fromDate(date);
    var year = date.year;
    var month = date.month;
    //var monthLength = monthDaysNumber(date);
    var hijraDate = year < 2077 && year > 1939 ? dateToHijraDate(date) : '';
    var day = date.day;
    var weekDay = date.weekday;

    return Scaffold(
      backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(
            color: colorAction
        ),
        title: const TextTitle(
          text: 'Namaska vremena',
          bold: true,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: TextTitleBig(
              text: gradovi[grad],
              fontSize: 20.0,
            ),
          ),
          VerticalListSeparator(height: 2,),
          Align(
            alignment: Alignment.center,
            child: TextTitle(
              text: '${daniSedmiceFull[weekDay-1]}, ${day}. ${mjeseciFullName[month-1]} ${year}.',
              bold: true,
            ),
          ),
          //year > 2079 ? Container() :
          Align(
            alignment: Alignment.center,
            child: TextTitle(
              text: hijraDate,
              bold: true,
            ),
          ),
          //VerticalListSeparator(height: 2,),
          ListView.separated(
              padding: EdgeInsets.all(defaultPadding*2),
              itemBuilder: (context, index){
                int vakatTime = vaktijaData['months'][month-1]['days'][day-1]['vakat'][index] +
                    differences[grad]['months'][month-1]['vakat'][index] +
                    3600;
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: defaultPadding*2),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextTitle(
                        text: vaktoviName[index],
                        bold: false,
                      ),
                      TextTitle(
                        text: vaktijaSec2Min(vakatTime),
                        color: colorSubtitle,
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index){
                return VerticalListDivider();
              },
              itemCount: vaktoviName.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          )

        ],
      ),
    );
  }
}
