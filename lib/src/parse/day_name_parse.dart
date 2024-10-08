import 'package:intl/intl.dart';
import 'package:retcore/src/config/imports.dart';

class RetCoreDayMonthName{

  static RetCoreDayMonthName? _instance;
  RetCoreDayMonthName._internal();
  factory RetCoreDayMonthName(){
    _instance ??= RetCoreDayMonthName._internal();
    return _instance!;
  }

  static String getDayName({required DateTime date}) {
    // Map of day names, where key is the weekday number (1-7) and value is the day name
    final Map<int, String> dayNames = {
      1: 'Monday',
      2: 'Tuesday',
      3: 'Wednesday',
      4: 'Thursday',
      5: 'Friday',
      6: 'Saturday',
      7: 'Sunday',
    };

    int dayOfWeek = date.weekday;

    // Using null-aware operator to access the map and provide a default value
    return dayNames[dayOfWeek] ?? 'Invalid day';
  }

  static String getMonthName({required DateTime date}) {
    // Map of month names, where key is the month number (1-12) and value is the month name
    final Map<int, String> monthNames = {
      1: 'January',
      2: 'February',
      3: 'March',
      4: 'April',
      5: 'May',
      6: 'June',
      7: 'July',
      8: 'August',
      9: 'September',
      10: 'October',
      11: 'November',
      12: 'December',
    };

    int month = date.month;

    // Using null-aware operator to access the map and provide a default value
    return monthNames[month] ?? 'Invalid month';
  }

  final Map<String, String> banglaDays = {
    'Monday': 'সোম',
    'Tuesday': 'মঙ্গল',
    'Wednesday': 'বুধ',
    'Thursday': 'বৃহ',
    'Friday': 'শুক্র',
    'Saturday': 'শনি',
    'Sunday': 'রবি',
  };

  final Map<String, String> banglaDigits = {
    '0': '০',
    '1': '১',
    '2': '২',
    '3': '৩',
    '4': '৪',
    '5': '৫',
    '6': '৬',
    '7': '৭',
    '8': '৮',
    '9': '৯',
  };

  final Map<String, String> banglaMonths = {
    'January': 'জানুয়ারী',
    'February': 'ফেব্রুয়ারী',
    'March': 'মার্চ',
    'April': 'এপ্রিল',
    'May': 'মে',
    'June': 'জুন',
    'July': 'জুলাই',
    'August': 'আগস্ট',
    'September': 'সেপ্টেম্বর',
    'October': 'অক্টোবর',
    'November': 'নভেম্বর',
    'December': 'ডিসেম্বর',
  };


  String getBanglaDayName(String isoDateString) {
    DateTime date = DateTime.parse(isoDateString);
    String dayInEnglish = getDayName(date: date);
    return banglaDays[dayInEnglish] ?? dayInEnglish;
  }
  String getBanglaDigit(dynamic digit) {
    String banglaDigit = RetCore.parseString(value: digit, defaultValue: '0');
    return banglaDigit.split('').map((digit) => banglaDigits[digit] ?? digit).join('');
  }
  String getBanglaDay(String isoDateString) {
    DateTime parsedDate = DateTime.parse(isoDateString);
    // Extract only the day part
    DateFormat dayFormat = DateFormat('dd');
    String day = dayFormat.format(parsedDate);
    return day.split('').map((digit) => banglaDigits[digit] ?? digit).join('');
  }
  String getEnglishDay(String isoDateString) {
    DateTime parsedDate = DateTime.parse(isoDateString);
    // Extract only the day part
    DateFormat dayFormat = DateFormat('dd');
    String day = dayFormat.format(parsedDate);
    return day;
  }

  String getBanglaMonthNumber(String isoDateString) {
    DateTime date = DateTime.parse(isoDateString);
    String monthNumber = date.month.toString();
    return monthNumber.split('').map((digit) => banglaDigits[digit] ?? digit).join('');
  }
  String getEnglishMonthNumber(String isoDateString) {
    DateTime date = DateTime.parse(isoDateString);
    String monthNumber = date.month.toString();
    return monthNumber;
  }
  String getBanglaYear(String isoDateString) {
    DateTime date = DateTime.parse(isoDateString);
    String year = date.year.toString();
    return year.split('').map((digit) => banglaDigits[digit] ?? digit).join('');
  }
  String getEnglishYear(String isoDateString) {
    DateTime date = DateTime.parse(isoDateString);
    String year = date.year.toString();
    return year;
  }

  String getBanglaFullMonthName(String isoDateString) {
    DateTime time = DateTime.parse(isoDateString);
    String monthInEnglish = getMonthName(date: time);
    return banglaMonths[monthInEnglish] ?? monthInEnglish;
  }

  Map<String , dynamic> getBanglaDate({required String isoDateString}) {
    String day = RetCore.getDayBangla(isoDateString: isoDateString);
    String month = RetCore.getMonthNameBangla(isoDateString: isoDateString);
    String year = RetCore.getYearBangla(isoDateString: isoDateString);
    return {
      'day': day ,
      'month': month,
      'year': year,
    };
  }
  Map<String , dynamic> getEnglishDate({required String isoDateString}) {
    DateTime parsedDate = DateTime.parse(isoDateString);
    String day = RetCore.getDayEnglish(isoDateString: isoDateString);
    String month = RetCore.getMonthNameEnglish(date: parsedDate);
    String year = RetCore.getYearEnglish(isoDateString: isoDateString);
    return {
      'day': day ,
      'month': month,
      'year': year,
    };
  }

  Map<String , dynamic> getBanglaTime({required String isoDateString,bool? isSecond}) {
    isSecond == null ? isSecond = false : null;
    DateTime time = DateTime.parse(isoDateString);
    // Format the DateTime in 12-hour format without AM/PM
    String formattedTime = DateFormat("h:mm:ss").format(time.toLocal());
    String inBanglaTime = formattedTime.split('').map((digit) => banglaDigits[digit] ?? digit).join('');
    String period = getPeriod(time);
    if (!isSecond!) {
      inBanglaTime = inBanglaTime.substring(0, inBanglaTime.length - 3);
    }
    return {'period': period , 'time': '$inBanglaTime মি.'};
  }

  String getPeriod(DateTime dateTime) {
    String period;
    int hour = dateTime.hour;
    if (hour >= 4 && hour < 12) {
      period = 'সকাল';
    } else if (hour >= 12 && hour < 16) {
      period = 'দুপুর';
    } else if (hour >= 16 && hour < 20) {
      period = 'বিকেল';
    } else {
      period = 'রাত';
    }
    return period;
  }

}