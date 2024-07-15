import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:provider/provider.dart';
import 'package:vaktijaba_fl/function/check_dst.dart';
import 'package:vaktijaba_fl/function/date_data_to_string.dart';
import 'package:vaktijaba_fl/function/save_function.dart';

import '../data/data.dart';
import '../function/sec_2_hhmm.dart';
import 'notification_service.dart';

void setVaktijaLocation(context, index) {
  Provider.of<VaktijaDateTimeProvider>(context, listen: false)
      .setVaktijaLocation(index);
}

void setVaktijaNotification(context, bool) {
  Provider.of<VaktijaDateTimeProvider>(context, listen: false)
      .setDnevnaVaktijaNotification(bool);
}

void setVaktijaPodneVrijeme(context, bool) {
  Provider.of<VaktijaDateTimeProvider>(context, listen: false)
      .setPodneVrijeme(bool);
}

void setVaktijaDzumaVrijeme(context, bool) {
  Provider.of<VaktijaDateTimeProvider>(context, listen: false)
      .setDzumaVrijeme(bool);
}

void setVaktijaAlarmSound(context, bool, index) {
  Provider.of<VaktijaDateTimeProvider>(context, listen: false)
      .setAlarmSound(bool, index);
}

void setVaktijaAlarmTime(context, value, index) {
  Provider.of<VaktijaDateTimeProvider>(context, listen: false)
      .setAlarmSoundTime(value, index);
}

void setVakatNotifikacijaSound(context, bool, index) {
  Provider.of<VaktijaDateTimeProvider>(context, listen: false)
      .setNotifikacijaSound(bool, index);
}

void setVakatNotifikacijaTime(context, value, index) {
  Provider.of<VaktijaDateTimeProvider>(context, listen: false)
      .setNotifikacijaSoundTime(value, index);
}

vaktijaStateProvider(context) {
  return Provider.of<VaktijaDateTimeProvider>(context);
}

//initData

int currentLocationInit = 77;
List vaktoviNotifikacijeTimeInit = [900, 900, 900, 900, 900, 900, 900];
List vaktoviNotifikacijaSoundInit = [true, true, true, true, true, true, true];
List vaktoviAlarmTimeInit = [1800, 1800, 1800, 1800, 1800, 1800, 1800];
List vaktoviAlarmSoundInit = [false, false, false, false, false, false, false];
bool podneStvarnoVrijemeInit = false;
bool vaktijaDzumaVrijemeInit = false;
bool showDailyVaktijaInit = false;

class VaktijaDateTimeProvider extends ChangeNotifier {
  List _vaktoviNotifikacijeTime = vaktoviNotifikacijeTimeInit;
  List _vaktoviAlarmTime = vaktoviAlarmTimeInit;
  List _vaktoviAlarmSound = vaktoviAlarmSoundInit;
  List _vaktoviNotifikacijaSound = vaktoviNotifikacijaSoundInit;

  int _currentLocation = currentLocationInit;
  int _currentCountry = 2;

  // bool _notificationScheduled = false;
  bool _podneStvarnoVrijeme = podneStvarnoVrijemeInit;

  //bool _vaktijaNotification = false;
  bool _showDailyVaktija = showDailyVaktijaInit;

  // bool _vaktijaNotificationSet = false;
  bool _vaktijaDzumaVrijeme = vaktijaDzumaVrijemeInit;

  // int get currentTimeVaktija => _currentTime;
  //
  // int get currentWeekDay => _currentWeekDay;
  //
  // int get currentDay => _currentDay;
  //
  // int get currentMonth => _currentMonth;
  //
  // int get currentYear => _currentYear;
  //
  // int get currentDayHijri => _currentDayHijri;
  //
  // int get currentMonthHijri => _currentMonthHijri;
  //
  // int get currentYearHijri => _currentYearHijri;
  // int get nextVakat => _nextVakat;
  //
  // //int get dstTime => _dst;

  int get currentLocation => _currentLocation;

  int get currentCountry => _currentCountry;

  bool get podneStvarnoVrijeme => _podneStvarnoVrijeme;

  bool get dzumaVrijemeAdet => _vaktijaDzumaVrijeme;

  //bool get vaktijaNotification => _vaktijaNotification;

  bool get showDailyVaktija => _showDailyVaktija;

  List get vaktoviNotifikacije => _vaktoviNotifikacijeTime;

  List get vaktoviAlarm => _vaktoviAlarmTime;

  List get playVaktijaAlarmSound => _vaktoviAlarmSound;

  List get playVaktijaNotifikacijaSound => _vaktoviNotifikacijaSound;

  void startVaktijaTimer() {
    _vaktoviScheduleNotification();
    _showDnevnaVaktija();
    //_showVaktijaNotifikacija();
  }

  // void resetTimeDate() {
  //   Future.delayed(Duration(seconds: 1), () {
  //     startVaktijaTimer();
  //   });
  // }

  void setAlarmSound(bool, index) {
    _vaktoviAlarmSound[index] = bool;
    notifyListeners();
    saveVaktijaData();
  }

  void setAlarmSoundTime(value, index) {
    _vaktoviAlarmTime[index] = value;
    startVaktijaTimer();
    notifyListeners();
    saveVaktijaData();
  }

  void setNotifikacijaSound(bool, index) {
    _vaktoviNotifikacijaSound[index] = bool;
    //_notificationScheduled = false;
    startVaktijaTimer();
    notifyListeners();
    saveVaktijaData();
  }

  void setNotifikacijaSoundTime(value, index) {
    _vaktoviNotifikacijeTime[index] = value;
    //_notificationScheduled = false;
    startVaktijaTimer();
    notifyListeners();
    saveVaktijaData();
  }

  void setVaktijaLocation(index) {
    _currentLocation = index;
    //_notificationScheduled = false;
    // _vaktijaNotificationSet = false;
    startVaktijaTimer();
    notifyListeners();
    saveVaktijaData();
  }

  void setPodneVrijeme(bool) {
    _podneStvarnoVrijeme = bool;
    // _notificationScheduled = false;
    // _vaktijaNotificationSet = false;
    startVaktijaTimer();
    notifyListeners();
    saveVaktijaData();
  }

  void setDzumaVrijeme(bool) {
    _vaktijaDzumaVrijeme = bool;

    /// _notificationScheduled = false;
    // _vaktijaNotificationSet = false;
    startVaktijaTimer();
    notifyListeners();
    saveVaktijaData();
  }

  void setDnevnaVaktijaNotification(bool) {
    //_vaktijaNotification;
    _showDailyVaktija = bool;
    startVaktijaTimer();
    notifyListeners();
    // if (_vaktijaNotification) {
    //   _showDnevnaVaktija();
    // }
    saveVaktijaData();
  }

  void _showDnevnaVaktija() {
    if (vaktijaData != null) {
      for (int dayIndex = 0; dayIndex < 6; dayIndex++) {
        NotificationService().cancelNotifications(dayIndex);
        if (_showDailyVaktija) {
          DateTime day = DateTime.now().add(
            Duration(
              days: dayIndex,
            ),
          );
          int dstAddonTime = checkDST(day) ? 3600 : 0;
          int _currentTime = (day.hour * 3600) + (day.minute * 60) + day.second;
          int timeOut = dayIndex == 0 ? (86280 - _currentTime) : 86280;
          String date = dateDMY(day.toString());
          String hDate = dateToStringHijri(HijriCalendar.now());
          String grad = gradovi[_currentLocation];
          String title = 'Vaktija.ba | $grad';
          String vaktoviIOS = List.generate(
            vaktoviName.length,
            (index) =>
                vaktoviNotifikacija[index] +
                ': ' +
                vaktijaSec2HourString(vaktijaData['months'][day.month - 1]
                        ['days'][day.day - 1]['vakat'][index] +
                    differences[_currentLocation]['months'][day.month - 1]
                        ['vakat'][index] +
                    dstAddonTime) +
                (index.isOdd ? '\n' : ' | '),
          ).join();
          String payload = dayIndex.toString();
          //print(bodyIOS);<b>
          String vaktoviAndroid = List.generate(
            vaktoviName.length,
            (index) =>
                '<b>${vaktoviNotifikacija[index]}<b>' +
                ': ' +
                vaktijaSec2HourString(vaktijaData['months'][day.month - 1]
                        ['days'][day.day - 1]['vakat'][index] +
                    differences[_currentLocation]['months'][day.month - 1]
                        ['vakat'][index] +
                    dstAddonTime) +
                (index.isOdd ? (index == 5 ? '' : '<br>') : '  |  '),
          ).join();

          //print(vaktoviAndroid);

          String bodyIOS =
              '${daniSedmiceShort[day.weekday - 1]}, $date/$hDate\n$vaktoviIOS';

          String bodyAndroid =
              '${daniSedmiceShort[day.weekday - 1]}, <b>$date</b> / <b>$hDate</b><br>$vaktoviAndroid';

          NotificationService().dnevnaVaktijaNotification(
            dayIndex,
            title,
            Platform.isIOS ? bodyIOS : bodyAndroid,
            payload,
            day,
            timeOut,
          );
        }
      }
    }
  }

  void _vaktoviScheduleNotification() {
    if (vaktijaData != null) {
      DateTime _currentVaktijaDay = DateTime.now();
      int podneDefaultTime = 43200;
      NotificationService().cancelAllNotifications();
      for (int indexDan = 0; indexDan < 9; indexDan++) {
        DateTime _vaktijaScheduleDate =
            _currentVaktijaDay.add(Duration(days: indexDan));
        //DateTime today = DateTime.now();
        int dstAddonTime = checkDST(_vaktijaScheduleDate) ? 3600 : 0;
        // int _newDST =
        //     _vaktijaScheduleDate.timeZoneOffset.inHours == 2 ? 3600 : 0;
        int _vaktijaScheduleDateDay = _vaktijaScheduleDate.day - 1;
        int _vaktijaScheduleDateMonth = _vaktijaScheduleDate.month - 1;
        bool _isDzuma = _vaktijaScheduleDate.weekday == 4;
        for (int indexVakat = 0; indexVakat < 6; indexVakat++) {
          var vakatTime = indexVakat == 2 && !_podneStvarnoVrijeme
              ? podneDefaultTime + dstAddonTime
              : vaktijaData['months'][_vaktijaScheduleDateMonth]['days']
                      [_vaktijaScheduleDateDay]['vakat'][indexVakat] +
                  differences[_currentLocation]['months']
                      [_vaktijaScheduleDateMonth]['vakat'][indexVakat] +
                  dstAddonTime;

          var id = ((indexDan + 1) * 10) + (indexVakat + 1);
          var title = 'Uskoro nastupa ${vaktoviName[indexVakat]}';
          // vaktoviName[indexVakat].toString() +
          // ' nastupa za ' +
          // ((_vaktoviNotifikacijeTime[indexVakat] / 60).round()).toString() +
          // ' minuta';
          var body =
              '${gradovi[_currentLocation]} | ${vaktoviName[indexVakat]}: ${vaktijaSec2HourString(vakatTime)}';

          List vakatTimeNotificationTime = vaktijaSec2HoursMinutes(vakatTime -
              _vaktoviNotifikacijeTime[
                  (_isDzuma && (indexVakat == 2) && _vaktijaDzumaVrijeme)
                      ? 6
                      : indexVakat]);
          int notificationHour = vakatTimeNotificationTime[0];
          int notificationMinutes = vakatTimeNotificationTime[1];
          //NotificationService().cancelNotifications(id);
          if (indexDan == 0) {
            int _currentTime = (_currentVaktijaDay.hour * 3600) +
                (_currentVaktijaDay.minute * 60) +
                _currentVaktijaDay.second;
            if (vakatTime - _vaktoviNotifikacijeTime[indexVakat] >
                _currentTime) {
              if (_vaktoviNotifikacijaSound[indexVakat] == true) {
                NotificationService().scheduleNotifications(
                    id,
                    title,
                    body,
                    _vaktijaScheduleDate,
                    notificationHour,
                    notificationMinutes,
                    _vaktoviNotifikacijeTime[indexVakat]);
              }
            }
          } else {
            if (_vaktoviNotifikacijaSound[indexVakat] == true) {
              NotificationService().scheduleNotifications(
                  id,
                  title,
                  body,
                  _vaktijaScheduleDate,
                  notificationHour,
                  notificationMinutes,
                  _vaktoviNotifikacijeTime[indexVakat]);
            }
          }
        }
      }
    }

    // int podneDefaultTime = 43200;
    // for (int i = 0; i < vaktoviName.length; i++) {
    //   var vakatTime = i == 2 &&
    //           (!_podneStvarnoVrijeme ||
    //               (_vaktijaDzumaVrijeme && _currentWeekDay == 4))
    //       ? podneDefaultTime + _dst
    //       : vaktijaData['months'][_currentMonth]['days'][_currentDay]['vakat']
    //               [i] +
    //           differences[_currentLocation]['months'][_currentMonth]['vakat']
    //               [i] +
    //           _dst;
    //   var id = i + 10;
    //   var title =
    //       'Uskoro nastupa ${vaktoviName[i]}'; //nastupa za ${(_vaktoviNotifikacijeTime[i] / 60).round()} minuta';
    //   var body =
    //       '${gradovi[_currentLocation].toString()} | ${vaktoviName[i]} | ${vaktijaSec2HourString(vakatTime)}';
    //   NotificationService().cancelNotifications(id);
    //   if (vakatTime - _vaktoviNotifikacijeTime[i] > _currentTime &&
    //       _vaktoviNotifikacijaSound[i]) {
    //     bool _isDzuma = _currentWeekDay == 4;
    //     int duration = (vakatTime -
    //             _vaktoviNotifikacijeTime[
    //                 (_isDzuma && i == 2 && _vaktijaDzumaVrijeme) ? 6 : i] -
    //             _currentTime)
    //         .round();
    //     //print(duration);
    //     NotificationService().scheduleNotifications(id, title, body, duration);
    //   }
    //   if (vakatTime - _vaktoviNotifikacijeTime[i] < _currentTime &&
    //       _vaktoviNotifikacijaSound[i]) {
    //     DateTime _newDate = DateTime.now().add(Duration(days: 1));
    //     bool _isDzuma = _newDate.weekday == 4;
    //     int _newDay = _newDate.day;
    //     int _newMonth = _newDate.month;
    //     var vakatTimeForward = i == 2 &&
    //             (!_podneStvarnoVrijeme ||
    //                 (_vaktijaDzumaVrijeme && _currentWeekDay == 4))
    //         ? podneDefaultTime + _dst
    //         : vaktijaData['months'][_newMonth]['days'][_newDay]['vakat'][i] +
    //             differences[_currentLocation]['months'][_newMonth]['vakat'][i] +
    //             _dst;
    //     int addOnTime = 86400 - _currentTime;
    //     int duration = ((vakatTimeForward + addOnTime) -
    //             _vaktoviNotifikacijeTime[
    //                 (_isDzuma && i == 2 && _vaktijaDzumaVrijeme) ? 6 : i])
    //         .round();
    //     NotificationService().scheduleNotifications(id, title, body, duration);
    //   }
    // }
  }

  saveVaktijaData() {
    List vaktijaSaveData = [
      _currentLocation,
      _vaktoviNotifikacijeTime,
      _vaktoviNotifikacijaSound,
      _vaktoviAlarmTime,
      _vaktoviAlarmSound,
      _podneStvarnoVrijeme,
      _vaktijaDzumaVrijeme,
      _showDailyVaktija
    ];
    saveVaktijaInitData(vaktijaSaveData);
  }

  restoreVaktijaData(vaktijaSaveData) {
    _currentLocation = vaktijaSaveData[0];
    _vaktoviNotifikacijeTime = vaktijaSaveData[1];
    _vaktoviNotifikacijaSound = vaktijaSaveData[2];
    _vaktoviAlarmTime = vaktijaSaveData[3];
    _vaktoviAlarmSound = vaktijaSaveData[4];
    _podneStvarnoVrijeme = vaktijaSaveData[5];
    _vaktijaDzumaVrijeme = vaktijaSaveData[6];
    notifyListeners();
  }
}
