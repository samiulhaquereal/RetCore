import 'package:intl/intl.dart';

class RetCoreDateTimeParse {

  static RetCoreDateTimeParse? _instance;
  RetCoreDateTimeParse._internal();
  factory RetCoreDateTimeParse(){
    _instance ??= RetCoreDateTimeParse._internal();
    return _instance!;
  }

  DateTime parseDateTime({required dynamic value, required DateTime defaultValue}) {
    if (value is DateTime) return value;
    if (value is String) {
      final isoFormat = convertToISOFormat(value);
      return DateTime.tryParse(isoFormat) ?? defaultValue;
    }
    return defaultValue;
  }

  String convertToISOFormat(String value) {
    // Define regular expressions for different date formats
    final Map<String, RegExp> dateFormats = {
      'YYMMDD': RegExp(r'^(\d{2})(\d{2})(\d{2})$'),
      'MMDDYY': RegExp(r'^(\d{2})(\d{2})(\d{2})$'),
      'YYYYMMDD': RegExp(r'^(\d{4})(\d{2})(\d{2})$'),
      'DDMMYYYY': RegExp(r'^(\d{2})(\d{2})(\d{4})$'),
      'MMDDYYYY': RegExp(r'^(\d{2})(\d{2})(\d{4})$'),
      'DDMMYY': RegExp(r'^(\d{2})(\d{2})(\d{2})$'),
      'YYMMMDD': RegExp(r'^(\d{2})(\w{3})(\d{2})$'),
      'DDMMMYY': RegExp(r'^(\d{2})(\w{3})(\d{2})$'),
      'MMMDDYY': RegExp(r'^(\w{3})(\d{2})(\d{2})$'),
      'YYYYMMMDD': RegExp(r'^(\d{4})(\w{3})(\d{2})$'),
      'DDMMMYYYY': RegExp(r'^(\d{2})(\w{3})(\d{4})$'),
      'MMMDDYYYY': RegExp(r'^(\w{3})(\d{2})(\d{4})$'),
      'YYDDD': RegExp(r'^(\d{2})(\d{3})$'),
      'DDDYY': RegExp(r'^(\d{3})(\d{2})$'),
      'YYYYDDD': RegExp(r'^(\d{4})(\d{3})$'),
      'DDDYYYY': RegExp(r'^(\d{3})(\d{4})$'),
      'YY/MM/DD': RegExp(r'^(\d{2})/(\d{2})/(\d{2})$'),
      'DD/MM/YY': RegExp(r'^(\d{2})/(\d{2})/(\d{2})$'),
      'MM/DD/YY': RegExp(r'^(\d{2})/(\d{2})/(\d{2})$'),
      'YYYY/MM/DD': RegExp(r'^(\d{4})/(\d{2})/(\d{2})$'),
      'DD/MM/YYYY': RegExp(r'^(\d{2})/(\d{2})/(\d{4})$'),
      'MM/DD/YYYY': RegExp(r'^(\d{2})/(\d{2})/(\d{4})$'),
      'YY/MMM/DD': RegExp(r'^(\d{2})/(\w{3})/(\d{2})$'),
      'DD/MMM/YY': RegExp(r'^(\d{2})/(\w{3})/(\d{2})$'),
      'MMM/DD/YY': RegExp(r'^(\w{3})/(\d{2})/(\d{2})$'),
      'YYYY/MMM/DD': RegExp(r'^(\d{4})/(\w{3})/(\d{2})$'),
      'DD/MMM/YYYY': RegExp(r'^(\d{2})/(\w{3})/(\d{4})$'),
      'MMM/DD/YYYY': RegExp(r'^(\w{3})/(\d{2})/(\d{4})$'),
      'YY/DDD': RegExp(r'^(\d{2})/(\d{3})$'),
      'DDD/YY': RegExp(r'^(\d{3})/(\d{2})$'),
      'YYYY/DDD': RegExp(r'^(\d{4})/(\d{3})$'),
      'DDD/YYYY': RegExp(r'^(\d{3})/(\d{4})$'),
      'MONTH': RegExp(r'^\w+$'),
      'DAY': RegExp(r'^\w+$'),
      'HHMM': RegExp(r'^(\d{2})(\d{2})$'),
      'HHMMSS': RegExp(r'^(\d{2})(\d{2})(\d{2})$'),
      'HH:MM': RegExp(r'^(\d{2}):(\d{2})$'),
      'HH:MM:SS': RegExp(r'^(\d{2}):(\d{2}):(\d{2})$'),
      'YYYYMMDDTHHMMSSmmmZ': RegExp(r'^(\d{4})(\d{2})(\d{2})T(\d{2})(\d{2})(\d{2}).(\d{3})Z$'),
      'YYYYMMDDZ': RegExp(r'^(\d{4})(\d{2})(\d{2})Z$'),
      'MM/DD/YY HH:MM:SS': RegExp(r'^(\d{2})/(\d{2})/(\d{2}) (\d{2}):(\d{2}):(\d{2})$'),
      'YYMMDD HHMMSS': RegExp(r'^(\d{2})(\d{2})(\d{2}) (\d{2})(\d{2})(\d{2})$'),
      'YYYY-MMDDTHH:MM:SS': RegExp(r'^(\d{4})-(\d{2})(\d{2})T(\d{2}):(\d{2}):(\d{2})$'),
      'YYYY-MM-DD': RegExp(r'^(\d{4})-(\d{2})-(\d{2})$'),
      'YYYY-MM': RegExp(r'^(\d{4})-(\d{2})$'),
      'YYYY': RegExp(r'^(\d{4})$'),
      '--MM-DD': RegExp(r'^--(\d{2})-(\d{2})$'),
      '---DD': RegExp(r'^---(\d{2})$')
    };

    // Match input value with regular expressions and convert to ISO format
    for (var format in dateFormats.keys) {
      var match = dateFormats[format]!.firstMatch(value);
      if (match != null) {
        switch (format) {
          case 'YYMMDD':
          case 'MMDDYY':
          case 'DDMMYY':
          case 'YY/MM/DD':
          case 'DD/MM/YY':
          case 'MM/DD/YY':
            var year = format == 'YYMMDD' || format == 'YY/MM/DD' ? '20${match.group(1)}' : '20${match.group(3)}';
            var month = format.contains('MM') ? match.group(2) : format == 'MMDDYY' || format == 'MM/DD/YY' ? match.group(1) : match.group(2);
            var day = format.contains('DD') ? match.group(2) : format == 'DDMMYY' || format == 'DD/MM/YY' ? match.group(1) : match.group(2);
            return '$year-$month-$day';
          case 'YYYYMMDD':
            return '${match.group(1)}-${match.group(2)}-${match.group(3)}';
          case 'DDMMYYYY':
            return '${match.group(3)}-${match.group(2)}-${match.group(1)}';
          case 'MMDDYYYY':
          case 'YYYY/MM/DD':
            return '${match.group(3)}-${match.group(1)}-${match.group(2)}';
          case 'DD/MM/YYYY':
            return '${match.group(3)}-${match.group(2)}-${match.group(1)}';
          case 'MM/DD/YYYY':
            return '${match.group(3)}-${match.group(1)}-${match.group(2)}';
          case 'YYMMMDD':
          case 'DDMMMYY':
          case 'MMMDDYY':
          case 'YYYYMMMDD':
          case 'DDMMMYYYY':
          case 'MMMDDYYYY':
            var year = format.startsWith('YY') ? '20${match.group(1)}' : format.startsWith('YYYY') ? match.group(1) : '20${match.group(3)}';
            var month = _convertMonth(match.group(2));
            var day = format.endsWith('DD') ? match.group(3) : match.group(2);
            return '$year-$month-$day';
          case 'YYDDD':
            return '20${match.group(1)}-${_convertDayOfYear(match.group(2))}';
          case 'DDDYY':
            return '20${match.group(2)}-${_convertDayOfYear(match.group(1))}';
          case 'YYYYDDD':
            return '${match.group(1)}-${_convertDayOfYear(match.group(2))}';
          case 'DDDYYYY':
            return '${match.group(2)}-${_convertDayOfYear(match.group(1))}';
          case 'HHMM':
            return '1970-01-01 ${match.group(1)}:${match.group(2)}:00';
          case 'HHMMSS':
            return '1970-01-01 ${match.group(1)}:${match.group(2)}:${match.group(3)}';
          case 'HH:MM':
            return '1970-01-01 ${match.group(1)}:${match.group(2)}:00';
          case 'HH:MM:SS':
            return '1970-01-01 ${match.group(1)}:${match.group(2)}:${match.group(3)}';
          case 'YYYYMMDDTHHMMSSmmmZ':
          case 'YYYYMMDDZ':
          case 'YYYY-MMDDTHH:MM:SS':
          case 'YYYY-MM-DD':
          case 'YYYY-MM':
          case 'YYYY':
          case '--MM-DD':
          case '---DD':
            return value;
          default:
            return '0000-00-00T00:00:00.000Z'; // Default for unsupported formats
        }
      }
    }

    return '0000-00-00T00:00:00.000Z'; // Default for unmatched formats
  }

  String _convertMonth(String? month) {
    if (month == null) {
      return '01'; // Default to January if month is null
    }
    switch (month.toUpperCase()) {
      case 'JAN':
        return '01';
      case 'FEB':
        return '02';
      case 'MAR':
        return '03';
      case 'APR':
        return '04';
      case 'MAY':
        return '05';
      case 'JUN':
        return '06';
      case 'JUL':
        return '07';
      case 'AUG':
        return '08';
      case 'SEP':
        return '09';
      case 'OCT':
        return '10';
      case 'NOV':
        return '11';
      case 'DEC':
        return '12';
      default:
        return '01'; // Default to January if month is unrecognized
    }
  }

  String _convertDayOfYear(String? dayOfYear) {
    if (dayOfYear == null) {
      return '01-01'; // Default to January 1st if dayOfYear is null
    }

    var day = int.tryParse(dayOfYear) ?? 1;
    var month = 1;

    while (day > 31) {
      if (month == 2) {
        day -= 28;
      } else if ([4, 6, 9, 11].contains(month)) {
        day -= 30;
      } else {
        day -= 31;
      }
      month += 1;
    }

    return '${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  }

}