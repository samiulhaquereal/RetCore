class RetCoreDateTimeParse {
  static RetCoreDateTimeParse? _instance;
  RetCoreDateTimeParse._internal();
  factory RetCoreDateTimeParse() {
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
    final Map<String, RegExp> dateFormats = {
      'YYMMDD': RegExp(r'^(\d{2})(\d{2})(\d{2})$'),
      'MMDDYY': RegExp(r'^(\d{2})(\d{2})(\d{2})$'),
      'YYYYMMDD': RegExp(r'^(\d{4})(\d{2})(\d{2})$'),
      'DDMMYYYY': RegExp(r'^(\d{2})(\d{2})(\d{4})$'),
      'MMDDYYYY': RegExp(r'^(\d{2})(\d{2})(\d{4})$'),
      'DDMMYY': RegExp(r'^(\d{2})(\d{2})(\d{2})$'),
      'YY/MM/DD': RegExp(r'^(\d{2})/(\d{2})/(\d{2})$'),
      'DD/MM/YY': RegExp(r'^(\d{2})/(\d{2})/(\d{2})$'),
      'MM/DD/YY': RegExp(r'^(\d{2})/(\d{2})/(\d{2})$'),
      'YYYY/MM/DD': RegExp(r'^(\d{4})/(\d{2})/(\d{2})$'),
      'DD/MM/YYYY': RegExp(r'^(\d{2})/(\d{2})/(\d{4})$'),
      'MM/DD/YYYY': RegExp(r'^(\d{2})/(\d{2})/(\d{4})$'),
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

    String _convertMonth(String month) {
      const months = {
        'JAN': '01', 'FEB': '02', 'MAR': '03', 'APR': '04',
        'MAY': '05', 'JUN': '06', 'JUL': '07', 'AUG': '08',
        'SEP': '09', 'OCT': '10', 'NOV': '11', 'DEC': '12'
      };
      return months[month.toUpperCase()] ?? '01';
    }

    String _convertDayOfYear(int dayOfYear, int year) {
      final date = DateTime(year).add(Duration(days: dayOfYear - 1));
      return '${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    }

    for (var format in dateFormats.keys) {
      final match = dateFormats[format]?.firstMatch(value);
      if (match != null) {
        switch (format) {
          case 'YYMMDD':
            return '20${match[1]}-${match[2]}-${match[3]}';
          case 'MMDDYY':
            return '20${match[3]}-${match[1]}-${match[2]}';
          case 'YYYYMMDD':
            return '${match[1]}-${match[2]}-${match[3]}';
          case 'DDMMYYYY':
            return '${match[3]}-${match[2]}-${match[1]}';
          case 'MMDDYYYY':
            return '${match[3]}-${match[1]}-${match[2]}';
          case 'DDMMYY':
            return '20${match[3]}-${match[2]}-${match[1]}';
          case 'YY/MM/DD':
            return '20${match[1]}-${match[2]}-${match[3]}';
          case 'DD/MM/YY':
            return '20${match[3]}-${match[2]}-${match[1]}';
          case 'MM/DD/YY':
            return '20${match[3]}-${match[1]}-${match[2]}';
          case 'YYYY/MM/DD':
            return '${match[1]}-${match[2]}-${match[3]}';
          case 'DD/MM/YYYY':
            return '${match[3]}-${match[2]}-${match[1]}';
          case 'MM/DD/YYYY':
            return '${match[3]}-${match[1]}-${match[2]}';
          case 'YYMMMDD':
            return '20${match[1]}-${_convertMonth(match[2]!)}-${match[3]}';
          case 'DDMMMYY':
            return '20${match[3]}-${_convertMonth(match[2]!)}-${match[1]}';
          case 'MMMDDYY':
            return '20${match[3]}-${_convertMonth(match[1]!)}-${match[2]}';
          case 'YYYYMMMDD':
            return '${match[1]}-${_convertMonth(match[2]!)}-${match[3]}';
          case 'DDMMMYYYY':
            return '${match[3]}-${_convertMonth(match[2]!)}-${match[1]}';
          case 'MMMDDYYYY':
            return '${match[3]}-${_convertMonth(match[1]!)}-${match[2]}';
          case 'YYDDD':
            return '20${match[1]}-${_convertDayOfYear(int.parse(match[2]!), int.parse('20${match[1]}!'))}';
          case 'DDDYY':
            return '20${match[2]}-${_convertDayOfYear(int.parse(match[1]!), int.parse('20${match[2]}!'))}';
          case 'YYYYDDD':
            return '${match[1]}-${_convertDayOfYear(int.parse(match[2]!), int.parse(match[1]!))}';
          case 'DDDYYYY':
            return '${match[2]}-${_convertDayOfYear(int.parse(match[1]!), int.parse(match[2]!))}';
          case 'HHMM':
            return '1970-01-01 ${match[1]}:${match[2]}:00';
          case 'HHMMSS':
            return '1970-01-01 ${match[1]}:${match[2]}:${match[3]}';
          case 'HH:MM':
            return '1970-01-01 ${match[1]}:${match[2]}:00';
          case 'HH:MM:SS':
            return '1970-01-01 ${match[1]}:${match[2]}:${match[3]}';
          case 'YYYYMMDDTHHMMSSmmmZ':
            return '${match[1]}-${match[2]}-${match[3]}T${match[4]}:${match[5]}:${match[6]}.${match[7]}Z';
          case 'YYYYMMDDZ':
            return '${match[1]}-${match[2]}-${match[3]}';
          case 'MM/DD/YY HH:MM:SS':
            return '20${match[3]}-${match[1]}-${match[2]} ${match[4]}:${match[5]}:${match[6]}';
          case 'YYMMDD HHMMSS':
            return '20${match[1]}-${match[2]}-${match[3]} ${match[4]}:${match[5]}:${match[6]}';
          case 'YYYY-MMDDTHH:MM:SS':
            return '${match[1]}-${match[2]}T${match[3]}:${match[4]}:${match[5]}';
          case 'YYYY-MM-DD':
            return '${match[1]}-${match[2]}-${match[3]}';
          case 'YYYY-MM':
            return '${match[1]}-${match[2]}-01';
          case 'YYYY':
            return '${match[1]}-01-01';
          case '--MM-DD':
            return '1970-${match[1]}-${match[2]}';
          case '---DD':
            return '1970-01-${match[1]}';
        }
      }
    }
    return value;
  }
}
