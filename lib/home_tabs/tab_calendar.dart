import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:quiver/time.dart';
import 'package:vaktijaba_fl/components/calender_picker_wheel.dart';
import 'package:vaktijaba_fl/components/horizontal_separator.dart';
import 'package:vaktijaba_fl/components/text_styles/text_title.dart';
import 'package:vaktijaba_fl/components/vertical_separator.dart';
import 'package:vaktijaba_fl/data/data.dart';
import 'package:vaktijaba_fl/date_screen/selected_date_screen.dart';
import 'package:vaktijaba_fl/function/dark_mode_check.dart';
import 'package:vaktijaba_fl/function/open_new_screen.dart';
import 'package:vaktijaba_fl/services/calendar_state_provider.dart';

class HomeTabCalendar extends StatefulWidget {
  const HomeTabCalendar({Key? key}) : super(key: key);

  @override
  _HomeTabCalendarState createState() => _HomeTabCalendarState();
}

class _HomeTabCalendarState extends State<HomeTabCalendar> {
  final PageController _pageController = PageController(initialPage: 0);
  String time = '00:00:00.000';
  int day = DateTime.now().day - 1;
  int month = DateTime.now().month - 1;
  int year = DateTime.now().year - 1;

  int dayHijri = HijriCalendar.now().hDay - 1;
  int monthHijri = HijriCalendar.now().hMonth - 1;
  int yearHijri = HijriCalendar.now().hYear - 1;

  int calendarIndex = 0;

  List monthLength = [];
  List hijriMonthLength = [];

  setSelectedDay(index) {
    setState(() {
      day = index;
    });
    //print('day ${day}');
  }

  setSelectedDayHijri(index) {
    setState(() {
      dayHijri = index;
    });
    //print('day ${day}');
  }

  setSelectedMonth(index) {
    setState(() {
      month = index;
    });
  }

  setSelectedMonthHijri(index) {
    setState(() {
      monthHijri = index;
    });
    print(monthHijri);
    //print(hijriMonthLength[monthHijri]);
  }

  setSelectedYear(index) {
    setState(() {
      year = index;
    });
    setMonthLength();
  }

  setSelectedYearHijri(index) {
    setState(() {
      yearHijri = index;
    });
    setHijriMonthLength();
  }

  @override
  void initState() {
    super.initState();
    setMonthLength();
    setHijriMonthLength();
  }

  setMonthLength() {
    setState(() {
      monthLength.clear();
    });
    for (int i = 0; i < 12; i++) {
      int monthDays = daysInMonth(year + 1, i + 1);
      setState(() {
        monthLength.add(monthDays);
      });
    }
  }

  setHijriMonthLength() {
    setState(() {
      hijriMonthLength.clear();
    });
    for (int i = 0; i < 12; i++) {
      DateTime gDate =
          HijriCalendar().hijriToGregorian(yearHijri + 1, i + 1, 1);
      var hDate = HijriCalendar.fromDate(gDate);
      int monthDays = hDate.lengthOfMonth;
      setState(() {
        hijriMonthLength.add(monthDays);
      });
    }
  }

  void setDate() {
    var newDay = (day + 1).toString().padLeft(2, '0');
    var newMonth = (month + 1).toString().padLeft(2, '0');
    var newYear = (year + 1).toString();
    setSelectedDate(context, '${newYear}-${newMonth}-${newDay} ${time}');
  }

  void setDateFromHijri() {
    DateTime gDate = HijriCalendar()
        .hijriToGregorian(yearHijri + 1, monthHijri + 1, dayHijri + 1);
    setSelectedDate(context, gDate.toString());
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkModeOn = isDarkMode(context);
    var activeColor = isDarkModeOn ? Colors.white : colorGreyDark;
    var inactiveColor = isDarkModeOn ? colorGreyLight : colorGreyMedium;
    return Scaffold(
      backgroundColor: isDarkModeOn ? Colors.black : Colors.white,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: const TextTitle(
          text: 'Odaberi datum',
          bold: true,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: colorTitle),
        leading: Container(),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: TextButton(
                onPressed: () {
                  if (calendarIndex == 0) {
                    setDate();
                  } else {
                    setDateFromHijri();
                  }
                  openNewScreen(
                      context, SelectedDateScreen(), 'namaska vremena');
                },
                child: TextTitle(
                  text: 'Prikaži',
                  color: colorAction,
                )),
          )
        ],
      ),
      body: Column(
        children: [
          VerticalListSeparator(
            height: 6,
          ),
          InkWell(
            enableFeedback: false,
            splashColor: Colors.transparent,
            onTap: () {
              if (calendarIndex == 0) {
                setState(() {
                  calendarIndex = 1;
                });
                _pageController.jumpToPage(1);
              } else {
                setState(() {
                  calendarIndex = 0;
                });
                _pageController.jumpToPage(0);
              }
            },
            child: Container(
              padding: EdgeInsets.all(defaultPadding * 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextTitle(
                        text: 'Gregorijanski',
                        bold: calendarIndex == 0 ? true : false,
                        color:
                        calendarIndex == 0 ? activeColor : inactiveColor,
                      ),
                    ),
                  ),
                  const HorizontalListSeparator(
                    width: 1,
                  ),
                  Container(
                    width: 36,
                    child: Center(
                      child: calendarIndex == 0
                          ? Icon(Icons.arrow_forward, color: isDarkModeOn ? Colors.white : colorGreyDark,)
                          : Icon(Icons.arrow_back, color: isDarkModeOn ? Colors.white : colorGreyDark,),
                    ),
                  ),
                  HorizontalListSeparator(
                    width: 1,
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextTitle(
                        text: 'Hidžretski',
                        bold: calendarIndex == 1 ? true : false,
                        color: calendarIndex == 1 ? activeColor : inactiveColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(defaultPadding * 2),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ChooseWheel(
                          length: monthLength[month],
                          initIndex: day,
                          isMonth: false,
                          offset: -0.4,
                          onChangeValue: (index) {
                            setSelectedDay(index);
                          },
                        ),
                        ChooseWheel(
                          length: mjeseciFullName.length,
                          initIndex: month,
                          isMonth: true,
                          onChangeValue: (index) {
                            setSelectedMonth(index);
                          },
                        ),
                        ChooseWheel(
                          length: 20000,
                          initIndex: year,
                          isMonth: false,
                          offset: 0.4,
                          onChangeValue: (index) {
                            setSelectedYear(index);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(defaultPadding * 2),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ChooseWheel(
                          length: hijriMonthLength[monthHijri],
                          initIndex: dayHijri,
                          isMonth: false,
                          offset: -0.4,
                          onChangeValue: (index) {
                            setSelectedDayHijri(index);
                          },
                        ),
                        ChooseWheel(
                          length: mjeseciHidz.length,
                          initIndex: monthHijri,
                          isMonth: true,
                          isHijri: true,
                          onChangeValue: (index) {
                            setSelectedMonthHijri(index);
                          },
                        ),
                        ChooseWheel(
                          length: 1499,
                          initIndex: yearHijri,
                          isMonth: false,
                          isHijri: true,
                          offset: 0.4,
                          onChangeValue: (index) {
                            setSelectedYearHijri(index);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
