import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateUtil {
  /// 格式转换（String→DateTime）
  static DateTime convertStringToDateTime(String str, String spl) {
    final splTimeList = str.split(spl).map(int.parse).toList();
    return DateTime(splTimeList[0], splTimeList[1], splTimeList[2]);
  }

  /// 格式转换（DateTime→String）yyyy/MM/dd
  static String convertDataTimeToString(DateTime time) {
    if (time == null) {
      return null;
    }
    return new DateFormat('yyyy/MM/dd').format(time);
  }

  /// 格式转换（DateTime→int）yyyyMMdd
  static int convertDataTimeToYYYYMMDD(DateTime time) {
    if (time == null) {
      return null;
    }
    return int.parse(DateFormat('yyyyMMdd').format(time));
  }

  static String convertDateTimeToStringText(DateTime time,String language) {
    if (time == null) {
      return null;
    }
    initializeDateFormatting();
    return new DateFormat.yMMMd(language).format(time);
  }

  static String covertIntegerToDateTimeString(int integerTime,String language){
    int year = (integerTime/100).floor();
    int month = integerTime - year*100;
    DateTime time = DateTime(year,month,1);
    return convertDateTimeToStringYYYYMM(time,language);
  }

  static String convertTimeOfDayToString(TimeOfDay time) {
    if (time == null) {
      return null;
    }
    String hour = time.hour < 10 ? "0" + time.hour.toString() : time.hour.toString();
    String minute = time.minute < 10 ? "0" + time.minute.toString() : time.minute.toString();
    return hour + ":" + minute;
  }

  static TimeOfDay convertStringToTimeOfDay(String st) {
    if (st == null) {
      return null;
    }
    List resultList = st.split(":");
    return TimeOfDay(hour: int.parse(resultList[0]), minute: int.parse(resultList[1]));
  }

  static Time convertStringToTime(String st) {
    if (st == null) {
      return null;
    }
    List resultList = st.split(":");
    return Time(int.parse(resultList[0]), int.parse(resultList[1]));
  }

  static String convertDateTimeToStringYYYYMM(DateTime time,String language) {
    if (time == null) {
      return null;
    }
    initializeDateFormatting();
    return new DateFormat.yMMM(language).format(time);
  }

  static String convertDateTimeToStringHHmm(DateTime time) {
    if (time == null) {
      return null;
    }
    initializeDateFormatting();
    return new DateFormat(DateFormat.HOUR24_MINUTE).format(time);
  }

  static String convertDateTimeToStringyyyyMMddHHmm(DateTime time,String language) {
    if (time == null) {
      return null;
    }
    initializeDateFormatting();
    return new DateFormat.yMMMd(language).add_Hm().format(time);
  }

  /// 本周第一天
  static DateTime firstDayOfWeek(DateTime dt) {
    return dt.subtract(new Duration(days: dt.weekday));
  }

  /// 日历页本月第一格日期
  static DateTime firstDayOfMonth(DateTime dt) {
    DateTime time = DateTime(dt.year, dt.month, 1);
    if (time.weekday != 7) {
      return time.subtract(new Duration(days: time.weekday));
    }
    return time;
  }

  /// 闰年判断
  static bool leapYear(int year) {
    bool leapYear = false;

    bool leap = ((year % 100 == 0) && (year % 400 != 0));
    if (leap == true)
      leapYear = false;
    else if (year % 4 == 0) leapYear = true;

    return leapYear;
  }

  static int daysInMonth(int monthNum, int year) {
    List<int> monthLength = new List(12);

    monthLength[0] = 31;
    monthLength[2] = 31;
    monthLength[4] = 31;
    monthLength[6] = 31;
    monthLength[7] = 31;
    monthLength[9] = 31;
    monthLength[11] = 31;
    monthLength[3] = 30;
    monthLength[8] = 30;
    monthLength[5] = 30;
    monthLength[10] = 30;

    if (leapYear(year) == true)
      monthLength[1] = 29;
    else
      monthLength[1] = 28;

    return monthLength[monthNum - 1];
  }

  static int weeksInMonth(int monthNum, int year) {
    int firstDayWeek = DateTime(year, monthNum, 1).weekday;
    int firstDaysInFirstWeek = 7 - firstDayWeek;
    if (firstDayWeek != 7) {
      return ((daysInMonth(monthNum, year) - firstDaysInFirstWeek) / 7).ceil() + 1;
    }
    return (daysInMonth(monthNum, year) / 7).ceil();
  }

  static List<DateTime> collectDateTime(DateTime dt) {
    List<DateTime> list = [];
    // 本页第一天
    DateTime firstDayOfPage = firstDayOfMonth(dt);
    DateTime firstDay = DateTime(dt.year, dt.month, 1);
    int diff = firstDay.difference(firstDayOfPage).inDays;
    // 第一周
    if (diff != 7) {
      for (int i = 0; i < diff; i++) {
        list.add(firstDayOfPage);
        firstDayOfPage = firstDayOfPage.add(Duration(days: 1));
      }
    }
    // 本月
    int days = daysInMonth(dt.month, dt.year);
    for (int i = 0; i < days; i++) {
      list.add(firstDayOfPage);
      firstDayOfPage = firstDayOfPage.add(Duration(days: 1));
    }
    // 最后一周
    DateTime lastDay = DateTime(dt.year, dt.month, days);
    int index;
    if (lastDay.weekday < 7) {
      index = 6 - lastDay.weekday;
    } else {
      index = 6;
    }
    for (int i = 0; i < index; i++) {
      list.add(firstDayOfPage);
      firstDayOfPage = firstDayOfPage.add(Duration(days: 1));
    }
    return list;
  }

  /// 是否同一天
  static bool isSameDay(DateTime a, DateTime b) {
    if (a.difference(b).inDays == 0 && a.day == b.day) {
      return true;
    }
    return false;
  }

  /// 时间分钟差
  static int diffMinutes(DateTime time1, DateTime time2) {
    final Duration diff = time1.difference(time2);
    return diff.inMinutes;
  }

  static int diffMinutesByTimeOfDay(TimeOfDay time1, TimeOfDay time2,TimeOfDay time3) {
    int timeMins1 = time1.hour*60 + time1.minute;
    int timeMins2 = time2.hour*60 + time2.minute;
    int timeMins3 = time3.hour*60 + time3.minute;

    int timeDiff = timeMins1 - timeMins2;

    return timeDiff < 0 ? timeDiff + 1440 - timeMins3 : timeDiff - timeMins3;
  }

  /// true:前面比后面早,false:后面比前面早
  static bool isBeforeByTimeOfDay(TimeOfDay time1,TimeOfDay time2){
    double timehours1 = time1.hour + time1.minute/60;
    double timehours2 = time2.hour + time2.minute/60;
    double diff = timehours1 - timehours2;
    if(diff > 0){
      return false;
    }
    return true;
  }

  static double compareTimeOfDayByHours(TimeOfDay time1, TimeOfDay time2, TimeOfDay time3) {
    double timeHour1 = time1.hour.toDouble() + (time1.minute.toDouble() / 60);
    double timeHour2 = time2.hour.toDouble() + (time2.minute.toDouble() / 60);
    double timeHour3 = time3.hour.toDouble() + (time3.minute.toDouble() / 60);
    double timeDiff = timeHour1 - timeHour2;

    return timeDiff < 0 ? timeDiff + 24 - timeHour3 : timeDiff - timeHour3;
  }

  static int convertTimeOfDayToMinutes(TimeOfDay timeOfDay) {
    if (timeOfDay == null) {
      return 0;
    }
    return timeOfDay.hour * 60 + timeOfDay.minute;
  }

  static String getHourText(int hour) {
    String hourText = hour ~/ 60 < 10 ? "0" + (hour ~/ 60).toString() : (hour ~/ 60).toString();
    String minText = hour % 60 < 10 ? "0" + (hour % 60).toString() : (hour % 60).toString();
    return hourText + ":" + minText;
  }
}
