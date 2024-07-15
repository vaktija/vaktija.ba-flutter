import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:vaktijaba_fl/app_theme/theme_data.dart';
import 'package:vaktijaba_fl/components/text_styles/text_body_medium.dart';
import 'package:vaktijaba_fl/components/text_styles/text_headline_small.dart';
import 'package:vaktijaba_fl/components/divider/horizontal_divider.dart';
import 'package:vaktijaba_fl/components/vertical_separator.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/function/check_dst.dart';
import 'package:vaktijaba_fl/function/dark_mode_check.dart';
import 'package:vaktijaba_fl/function/date_2_hijra.dart';
import 'package:vaktijaba_fl/function/sec_2_hhmm.dart';
import 'package:vaktijaba_fl/services/calendar_state_provider.dart';
import 'package:vaktijaba_fl/services/state_provider.dart';


class SelectedDateScreen extends StatelessWidget {
  const SelectedDateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //bool isDarkModeOn = isDarkMode(context);
    var vaktijaProvider = vaktijaStateProvider(context);
    int grad = vaktijaProvider.currentLocation;
    DateTime date = calendarPickerStateProvider(context).selectedDateTime;
    //var h_date = HijriCalendar.fromDate(date);
    int dstAddonTime = checkDST(date) ? 3600 : 0;
    var year = date.year;
    var month = date.month;
    //var monthLength = monthDaysNumber(date);
    var hijraDate = year < 2077 && year > 1939 ? dateToHijraDate(date) : '';
    var day = date.day;
    var weekDay = date.weekday;

    return Scaffold(
     // backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
      appBar: AppBar(
    //    backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
     //   elevation: 0,
    //    shadowColor: Colors.transparent,
        iconTheme: IconThemeData(
            color: AppColors.colorAction
        ),
        title: const TextBodyMedium(
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
            child: TextHeadlineSmall(
              text: gradovi[grad],
              fontSize: 20.0,
            ),
          ),
          VerticalListSeparator(height: 2,),
          Align(
            alignment: Alignment.center,
            child: TextBodyMedium(
              text: '${daniSedmiceFull[weekDay-1]}, ${day}. ${mjeseciFullName[month-1]} ${year}.',
              bold: true,
            ),
          ),
          //year > 2079 ? Container() :
          Align(
            alignment: Alignment.center,
            child: TextBodyMedium(
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
                    dstAddonTime;
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: defaultPadding*2),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextBodyMedium(
                        text: vaktoviName[index],
                        bold: false,
                      ),
                      TextBodyMedium(
                        text: vaktijaSec2HourString(vakatTime),
                        color: AppColors.colorSubtitle,
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index){
                return DividerCustomHorizontal();
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
