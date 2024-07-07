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



}