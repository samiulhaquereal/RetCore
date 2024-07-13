import 'package:intl/intl.dart';

class RetCoreDateTimeParse {
  static RetCoreDateTimeParse? _instance;
  RetCoreDateTimeParse._internal();

  factory RetCoreDateTimeParse(){
    _instance ??= RetCoreDateTimeParse._internal();
    return _instance!;
  }

  DateTime parseDateTime({required String input}) {
    final formatters = {
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
      'MONTH': RegExp(r'^(January|February|March|April|May|June|July|August|September|October|November|December)$', caseSensitive: false),
      'DAY': RegExp(r'^(Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday)$', caseSensitive: false),
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
      '---DD': RegExp(r'^---(\d{2})$'),
    };

    for (var format in formatters.keys) {
      var regex = formatters[format];
      var match = regex?.firstMatch(input);
      if (match != null) {
        switch (format) {
          case 'YYMMDD':
            return DateTime.parse('20${match[1]}-${match[2]}-${match[3]}');
          case 'MMDDYY':
            return DateTime.parse('20${match[3]}-${match[1]}-${match[2]}');
          case 'YYYYMMDD':
            return DateTime.parse('${match[1]}-${match[2]}-${match[3]}');
          case 'DDMMYYYY':
            return DateTime.parse('${match[3]}-${match[2]}-${match[1]}');
          case 'MMDDYYYY':
            return DateTime.parse('${match[3]}-${match[1]}-${match[2]}');
          case 'DDMMYY':
            return DateTime.parse('20${match[3]}-${match[2]}-${match[1]}');
          case 'YYMMMDD':
            return DateTime.parse('20${match[1]}-${_monthToNumber(match[2]!)}-${match[3]}');
          case 'DDMMMYY':
            return DateTime.parse('20${match[3]}-${_monthToNumber(match[2]!)}-${match[1]}');
          case 'MMMDDYY':
            return DateTime.parse('20${match[3]}-${_monthToNumber(match[1]!)}-${match[2]}');
          case 'YYYYMMMDD':
            return DateTime.parse('${match[1]}-${_monthToNumber(match[2]!)}-${match[3]}');
          case 'DDMMMYYYY':
            return DateTime.parse('${match[3]}-${_monthToNumber(match[2]!)}-${match[1]}');
          case 'MMMDDYYYY':
            return DateTime.parse('${match[3]}-${_monthToNumber(match[1]!)}-${match[2]}');
          case 'YYDDD':
            return DateTime(int.parse('20${match[1]}')).add(Duration(days: int.parse(match[2]!) - 1));
          case 'DDDYY':
            return DateTime(int.parse('20${match[2]}')).add(Duration(days: int.parse(match[1]!) - 1));
          case 'YYYYDDD':
            return DateTime(int.parse(match[1]!)).add(Duration(days: int.parse(match[2]!) - 1));
          case 'DDDYYYY':
            return DateTime(int.parse(match[2]!)).add(Duration(days: int.parse(match[1]!) - 1));
          case 'YY/MM/DD':
            return DateTime.parse('20${match[1]}-${match[2]}-${match[3]}');
          case 'DD/MM/YY':
            return DateTime.parse('20${match[3]}-${match[2]}-${match[1]}');
          case 'MM/DD/YY':
            return DateTime.parse('20${match[3]}-${match[1]}-${match[2]}');
          case 'YYYY/MM/DD':
            return DateTime.parse('${match[1]}-${match[2]}-${match[3]}');
          case 'DD/MM/YYYY':
            return DateTime.parse('${match[3]}-${match[2]}-${match[1]}');
          case 'MM/DD/YYYY':
            return DateTime.parse('${match[3]}-${match[1]}-${match[2]}');
          case 'YY/MMM/DD':
            return DateTime.parse('20${match[1]}-${_monthToNumber(match[2]!)}-${match[3]}');
          case 'DD/MMM/YY':
            return DateTime.parse('20${match[3]}-${_monthToNumber(match[2]!)}-${match[1]}');
          case 'MMM/DD/YY':
            return DateTime.parse('20${match[3]}-${_monthToNumber(match[1]!)}-${match[2]}');
          case 'YYYY/MMM/DD':
            return DateTime.parse('${match[1]}-${_monthToNumber(match[2]!)}-${match[3]}');
          case 'DD/MMM/YYYY':
            return DateTime.parse('${match[3]}-${_monthToNumber(match[2]!)}-${match[1]}');
          case 'MMM/DD/YYYY':
            return DateTime.parse('${match[3]}-${_monthToNumber(match[1]!)}-${match[2]}');
          case 'YY/DDD':
            return DateTime(int.parse('20${match[1]}')).add(Duration(days: int.parse(match[2]!) - 1));
          case 'DDD/YY':
            return DateTime(int.parse('20${match[2]}')).add(Duration(days: int.parse(match[1]!) - 1));
          case 'YYYY/DDD':
            return DateTime(int.parse(match[1]!)).add(Duration(days: int.parse(match[2]!) - 1));
          case 'DDD/YYYY':
            return DateTime(int.parse(match[2]!)).add(Duration(days: int.parse(match[1]!) - 1));
          case 'MONTH':
            return DateFormat('MMMM').parse(match[1]!);
          case 'DAY':
            return DateFormat('EEEE').parse(match[1]!);
          case 'HHMM':
            return DateTime.parse('1970-01-01T${match[1]}:${match[2]}:00');
          case 'HHMMSS':
            return DateTime.parse('1970-01-01T${match[1]}:${match[2]}:${match[3]}');
          case 'HH:MM':
            return DateTime.parse('1970-01-01T${match[1]}:${match[2]}:00');
          case 'HH:MM:SS':
            return DateTime.parse('1970-01-01T${match[1]}:${match[2]}:${match[3]}');
          case 'YYYYMMDDTHHMMSSmmmZ':
            return DateTime.parse('${match[1]}-${match[2]}-${match[3]}T${match[4]}:${match[5]}:${match[6]}.${match[7]}Z');
          case 'YYYYMMDDZ':
            return DateTime.parse('${match[1]}-${match[2]}-${match[3]}Z');
          case 'MM/DD/YY HH:MM:SS':
            return DateTime.parse('20${match[3]}-${match[1]}-${match[2]}T${match[4]}:${match[5]}:${match[6]}');
          case 'YYMMDD HHMMSS':
            return DateTime.parse('20${match[1]}-${match[2]}-${match[3]}T${match[4]}:${match[5]}:${match[6]}');
          case 'YYYY-MMDDTHH:MM:SS':
            return DateTime.parse('${match[1]}-${match[2]}T${match[3]}:${match[4]}:${match[5]}');
          case 'YYYY-MM-DD':
            return DateTime.parse('${match[1]}-${match[2]}-${match[3]}');
          case 'YYYY-MM':
            return DateTime.parse('${match[1]}-${match[2]}-01');
          case 'YYYY':
            return DateTime.parse('${match[1]}-01-01');
          case '--MM-DD':
            return DateTime.parse('1970-${match[1]}-${match[2]}');
          case '---DD':
            return DateTime.parse('1970-01-${match[1]}');
        }
      }
    }
    throw FormatException("Invalid date format");
  }

  String _monthToNumber(String month) {
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
        throw FormatException("Invalid month abbreviation");
    }
  }
}
