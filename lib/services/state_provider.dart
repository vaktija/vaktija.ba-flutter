import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:provider/provider.dart';
import 'package:vaktijaba_fl/function/get_next_vakat.dart';

import '../data/data.dart';
import '../function/save_function.dart';
import '../function/sec_2_hhmm.dart';
import 'notification_service.dart';

void startVaktijaTimerCheck(context) {
  Provider.of<VaktijaDateTimeProvider>(context, listen: false)
      .startVaktijaTimer();
}

void setVaktijaLocation(context, index) {
  Provider.of<VaktijaDateTimeProvider>(context, listen: false)
      .setVaktijaLocation(index);
}

void setVaktijaNotification(context, bool) {
  Provider.of<VaktijaDateTimeProvider>(context, listen: false)
      .showVaktijaNotification(bool);
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

void restoreSavedVaktijaData(context, vaktijaSaveData) {
  Provider.of<VaktijaDateTimeProvider>(context, listen: false)
      .restoreVaktijaData(vaktijaSaveData);
}

vaktijaStateProvider(context) {
  return Provider.of<VaktijaDateTimeProvider>(context);
}

final now = DateTime.now();
final nowHijri = HijriCalendar.now();

class VaktijaDateTimeProvider extends ChangeNotifier {
  int _dst = DateTime.now().timeZoneOffset.inHours == 2 ? 3600 : 0;

  List _vaktoviNotifikacijeTime = [900, 900, 900, 900, 900, 900, 900];

  List _vaktoviAlarmTime = [1800, 1800, 1800, 1800, 1800, 1800, 1800];

  List _vaktoviAlarmSound = [false, false, false, false, false, false, false];

  List _vaktoviNotifikacijaSound = [true, true, true, true, true, true, true];

  int _currentWeekDay = now.weekday - 1;
  int _currentDay = now.day - 1;
  int _currentMonth = now.month - 1;
  int _currentYear = now.year;
  int _currentDayHijri = nowHijri.hDay;
  int _currentMonthHijri = nowHijri.hMonth - 1;
  int _currentYearHijri = nowHijri.hYear;
  int _currentTime = (now.hour * 3600) + (now.minute * 60) + now.second;
  int _currentLocation = 77;
  int _currentCountry = 2;
  int _nextVakat = 0;

  //bool _playAlarmSound = false;
  //bool _playNotificationSound = false;

  bool _notificationScheduled = false;
  bool _podneStvarnoVrijeme = false;
  bool _vaktijaNotification = false;
  bool _vaktijaNotificationSet = false;
  bool _vaktijaDzumaVrijeme = false;

  int get currentTimeVaktija => _currentTime;

  int get currentWeekDay => _currentWeekDay;

  int get currentDay => _currentDay;

  int get currentMonth => _currentMonth;

  int get currentYear => _currentYear;

  int get currentDayHijri => _currentDayHijri;

  int get currentMonthHijri => _currentMonthHijri;

  int get currentYearHijri => _currentYearHijri;

  int get currentLocation => _currentLocation;

  int get currentCountry => _currentCountry;

  bool get podneStvarnoVrijeme => _podneStvarnoVrijeme;

  bool get dzumaVrijemeAdet => _vaktijaDzumaVrijeme;

  bool get vaktijaNotification => _vaktijaNotification;

  int get nextVakat => _nextVakat;

  int get dstTime => _dst;

  List get vaktoviNotifikacije => _vaktoviNotifikacijeTime;

  List get vaktoviAlarm => _vaktoviAlarmTime;

  List get playVaktijaAlarmSound => _vaktoviAlarmSound;

  List get playVaktijaNotifikacijaSound => _vaktoviNotifikacijaSound;

  void startVaktijaTimer() {
    _currentTime = (DateTime.now().hour * 3600) +
        (DateTime.now().minute * 60) +
        DateTime.now().second;
    _currentWeekDay = DateTime.now().weekday - 1;
    _currentDay = DateTime.now().day - 1;
    _currentMonth = DateTime.now().month - 1;
    _currentYear = DateTime.now().year;
    _currentDayHijri = HijriCalendar.now().hDay;
    _currentMonthHijri = HijriCalendar.now().hMonth - 1;
    _currentYearHijri = HijriCalendar.now().hYear;
    _dst = DateTime.now().timeZoneOffset.inHours == 2 ? 3600 : 0;
    _nextVakat = getNextVakat(
        _currentTime, _currentLocation, _currentMonth, _currentDay, _dst);
    notifyListeners();
    if (_currentTime < 1 || !_notificationScheduled) {
      _vaktoviScheduleNotification();
    }
    if (_vaktijaNotification) {
      if (_currentTime < 1 || !_vaktijaNotificationSet) {
        _showVaktijaNotifikacija();
      }
    }
    resetTimeDate();
  }

  void resetTimeDate() {
    Future.delayed(Duration(seconds: 1), () {
      startVaktijaTimer();
    });
  }

  void setAlarmSound(bool, index) {
    _vaktoviAlarmSound[index] = bool;
    notifyListeners();
    saveVaktijaData();
  }

  void setAlarmSoundTime(value, index) {
    _vaktoviAlarmTime[index] = value;
    notifyListeners();
    saveVaktijaData();
  }

  void setNotifikacijaSound(bool, index) {
    _vaktoviNotifikacijaSound[index] = bool;
    _notificationScheduled = false;
    notifyListeners();
    saveVaktijaData();
  }

  void setNotifikacijaSoundTime(value, index) {
    _vaktoviNotifikacijeTime[index] = value;
    _notificationScheduled = false;
    notifyListeners();
    saveVaktijaData();
  }

  void setVaktijaLocation(index) {
    _currentLocation = index;
    _notificationScheduled = false;
    _vaktijaNotificationSet = false;
    notifyListeners();
    saveVaktijaData();
  }

  void setPodneVrijeme(bool) {
    _podneStvarnoVrijeme = bool;
    _notificationScheduled = false;
    _vaktijaNotificationSet = false;
    notifyListeners();
    saveVaktijaData();
  }

  void setDzumaVrijeme(bool) {
    _vaktijaDzumaVrijeme = bool;
    _notificationScheduled = false;
    _vaktijaNotificationSet = false;
    notifyListeners();
    saveVaktijaData();
  }

  void showVaktijaNotification(bool) {
    _vaktijaNotification = bool;
    notifyListeners();
    if (_vaktijaNotification) {
      _showVaktijaNotifikacija();
    }
    saveVaktijaData();
  }

  void _showVaktijaNotifikacija() {
    if (_vaktijaNotificationSet) {
      _vaktijaNotificationSet = false;
      NotificationService().cancelNotifications(0);
    } else {
      _vaktijaNotificationSet = true;
      int id = 0;
      String title = 'Vaktija.ba | ' + [_currentLocation].toString();
      String body = (List.generate(
              vaktoviName.length,
              (index) =>
                  vaktoviNotifikacija[index] +
                  ': ' +
                  vaktijaSec2Min(vaktijaData['months'][_currentMonth]['days']
                          [currentDay]['vakat'][index] +
                      vaktijaData.differences[_currentLocation]['months']
                          [_currentMonth]['vakat'][index] +
                      _dst) +
                  (index == 1 || index == 3
                      ? '\n'
                      : (index == 5 ? '' : ' | '))))
          .toString()
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll(', ', '');
      String payload = '0';
      NotificationService().showNotifications(id, title, body, payload);
    }
  }

  void _vaktoviScheduleNotification() {
    _notificationScheduled = true;
    int podneDefaultTime = 43200;
    for (int i = 0; i < vaktoviName.length; i++) {
      var vakatTime = i == 2 && (!_podneStvarnoVrijeme || (_vaktijaDzumaVrijeme && _currentWeekDay == 4))
          ? podneDefaultTime + _dst
          : vaktijaData['months'][_currentMonth]['days'][_currentDay]['vakat']
                  [i] +
              differences[_currentLocation]['months'][_currentMonth]['vakat']
                  [i] +
              _dst;
      var id = i + 10;
      var title =
          'Uskoro nastupa ${vaktoviName[i]}'; //nastupa za ${(_vaktoviNotifikacijeTime[i] / 60).round()} minuta';
      var body =
          '${gradovi[_currentLocation].toString()} | ${vaktoviName[i]} | ${vaktijaSec2Min(vakatTime)}';
      NotificationService().cancelNotifications(id);
      if (vakatTime - _vaktoviNotifikacijeTime[i] > _currentTime &&
          _vaktoviNotifikacijaSound[i]) {
        bool _isDzuma = _currentWeekDay == 4;
        int duration =
            (vakatTime - _vaktoviNotifikacijeTime[(_isDzuma && i == 2 && _vaktijaDzumaVrijeme) ? 6 : i] - _currentTime).round();
        //print(duration);
        NotificationService().scheduleNotifications(id, title, body, duration);
      }
      if (vakatTime - _vaktoviNotifikacijeTime[i] < _currentTime &&
          _vaktoviNotifikacijaSound[i]) {
        DateTime _newDate = DateTime.now().add(Duration(days: 1));
        bool _isDzuma = _newDate.weekday == 4;
        int _newDay = _newDate.day;
        int _newMonth = _newDate.month;
        var vakatTimeForward = i == 2 && (!_podneStvarnoVrijeme || (_vaktijaDzumaVrijeme && _currentWeekDay == 4))
            ? podneDefaultTime + _dst
            : vaktijaData['months'][_newMonth]['days'][_newDay]['vakat'][i] +
                differences[_currentLocation]['months'][_newMonth]['vakat'][i] +
                _dst;
        int addOnTime = 86400 - _currentTime;
        int duration =
            ((vakatTimeForward + addOnTime) - _vaktoviNotifikacijeTime[(_isDzuma && i == 2 && _vaktijaDzumaVrijeme) ? 6 : i])
                .round();
        NotificationService().scheduleNotifications(id, title, body, duration);
      }
    }
  }

  saveVaktijaData() {
    List vaktijaSaveData = [
      _currentLocation,
      _vaktoviNotifikacijeTime,
      _vaktoviNotifikacijaSound,
      _vaktoviAlarmTime,
      _vaktoviAlarmSound,
      _podneStvarnoVrijeme,
      _vaktijaDzumaVrijeme
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
