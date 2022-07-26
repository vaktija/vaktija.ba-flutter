import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

calendarPickerStateProvider(context){
  return Provider.of<CalendarPickerStateProvider>(context);
}

void setSelectedDate(context, dateTimeData){
  Provider.of<CalendarPickerStateProvider>(context, listen: false)
      .setSelectedDateTime(dateTimeData);
}

class CalendarPickerStateProvider extends ChangeNotifier {
  DateTime _dateTime = DateTime.now();

  DateTime get selectedDateTime => _dateTime;

  void setSelectedDateTime(dateTimeData){
     _dateTime = DateTime.parse(dateTimeData.toString());
     notifyListeners();
  }
}