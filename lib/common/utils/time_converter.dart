import 'package:flutter/material.dart';

Map<int, String> daysOfWeek = {
  1: 'Monday',
  2: 'Tuesday',
  3: 'Wednesday',
  4: 'Thursday',
  5: 'Friday',
  6: 'Saturday',
  7: 'Sunday'
};

Map<int, String> daysOfaWeek = {
  1: 'Sunday',
  2: 'Monday',
  3: 'Tuesday',
  4: 'Wednesday',
  5: 'Thursday',
  6: 'Friday',
  7: 'Saturday'
};

String timeConverter(int? timeCount, BuildContext context) {
  try {
    final localization = MaterialLocalizations.of(context);
    if (timeCount == null) {
      return localization.formatTimeOfDay(const TimeOfDay(hour: 0, minute: 0));
    }
    final hour = timeCount / 60;
    final minute = timeCount % 60;

    return localization
        .formatTimeOfDay(TimeOfDay(hour: hour.toInt(), minute: minute));
    // return TimeOfDay(hour: hour.toInt(), minute: minute).format(context);
  } catch (e) {
    print(e);
    return '';
  }
}

TimeOfDay timeConverterTimeOfDay(int? timeCount) {
  try {
    if (timeCount == null) {
      return const TimeOfDay(hour: 0, minute: 0);
    }
    final hour = timeCount / 60;
    final minute = timeCount % 60;

    return TimeOfDay(hour: hour.toInt(), minute: minute);
  } catch (e) {
    print(e);
    return const TimeOfDay(hour: 0, minute: 0);
  }
}

Iterable<TimeOfDay> timeSlotGenerator(
    TimeOfDay startTime, TimeOfDay endTime, Duration interval) sync* {

  var hour = startTime.hour;
  var minute = startTime.minute;
  late TimeOfDay endTimeCalculated;

  if(startTime.hour > endTime.hour){ //Close time is next day i.e. after 12 AM
    endTimeCalculated = const TimeOfDay(hour: 24, minute: 0);
  }else{
    endTimeCalculated = endTime;
  }

  do {
    yield TimeOfDay(hour: hour, minute: minute);
    minute += interval.inMinutes;
    while (minute >= 60) {
      minute -= 60;
      hour++;
    }
    print(minute);
  } while (hour < endTimeCalculated.hour ||
      (hour == endTimeCalculated.hour && minute <= endTimeCalculated.minute));

  if(startTime.hour > endTime.hour) { //Close time is next day i.e. after 12 AM
    ///Start calculation from midnight
    hour = 0;
    minute = interval.inMinutes;

    do {
      yield TimeOfDay(hour: hour, minute: minute);
      minute += interval.inMinutes;
      while (minute >= 60) {
        minute -= 60;
        hour++;
      }
      print(minute);
    } while (hour < endTime.hour ||
        (hour == endTime.hour && minute <= endTime.minute));
  }

}
