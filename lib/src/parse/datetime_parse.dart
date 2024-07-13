import 'package:intl/intl.dart';

class RetCoreDateTimeParse {

  static RetCoreDateTimeParse? _instance;
  RetCoreDateTimeParse._internal();
  factory RetCoreDateTimeParse(){
    _instance ??= RetCoreDateTimeParse._internal();
    return _instance!;
  }

  static DateTime parseDateTime({required dynamic value, required DateTime defaultValue}) {
    if (value is DateTime) return value;
    if (value is String) {
      try {
        final formats = [
          DateFormat('yyMMdd'),
          DateFormat('MMddyy'),
          DateFormat('yyyyMMdd'),
          DateFormat('ddMMyyyy'),
          DateFormat('MMddyyyy'),
          DateFormat('ddMMyy'),
          DateFormat('yyMMMdd'),
          DateFormat('ddMMMyy'),
          DateFormat('MMMddyy'),
          DateFormat('yyyyMMMdd'),
          DateFormat('ddMMMyyyy'),
          DateFormat('MMMddyyyy'),
          DateFormat('yyDDD'),
          DateFormat('DDDyy'),
          DateFormat('yyyyDDD'),
          DateFormat('DDDyyyy'),
          DateFormat('yy/MM/dd'),
          DateFormat('dd/MM/yy'),
          DateFormat('MM/dd/yy'),
          DateFormat('yyyy/MM/dd'),
          DateFormat('dd/MM/yyyy'),
          DateFormat('MM/dd/yyyy'),
          DateFormat('yy/MMM/dd'),
          DateFormat('dd/MMM/yy'),
          DateFormat('MMM/dd/yy'),
          DateFormat('yyyy/MMM/dd'),
          DateFormat('dd/MMM/yyyy'),
          DateFormat('MMM/dd/yyyy'),
          DateFormat('yy/DDD'),
          DateFormat('DDD/yy'),
          DateFormat('yyyy/DDD'),
          DateFormat('DDD/yyyy'),
          DateFormat('MMMM'), // Full month name
          DateFormat('EEEE'), // Day of the week
          DateFormat('HHmm'),
          DateFormat('HHmmss'),
          DateFormat('HH:mm'),
          DateFormat('HH:mm:ss'),
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"),
          DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'"),
          DateFormat('MM/dd/yy HH:mm:ss'),
          DateFormat('yyMMdd HHmmss'),
          DateFormat("yyyy-MM-dd'T'HH:mm:ss"),
          DateFormat('yyyy-MM-dd'),
          DateFormat('yyyy-MM'),
          DateFormat('yyyy'),
          DateFormat('--MM-dd'),
          DateFormat('---dd')
        ];

        for (var format in formats) {
          try {
            return format.parseStrict(value);
          } catch (e) {
            // continue to next format
          }
        }
      } catch (e) {
        // Continue to default return
      }
    }
    return defaultValue;
  }

}