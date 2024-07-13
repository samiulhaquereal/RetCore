class RetCoreDateTimeParse {
  static RetCoreDateTimeParse? _instance;
  RetCoreDateTimeParse._internal();

  factory RetCoreDateTimeParse(){
    _instance ??= RetCoreDateTimeParse._internal();
    return _instance!;
  }

  DateTime parseDateTime({required dynamic value}) {
    var isoFormat = convertToISOFormat(value);
    return DateTime.tryParse(isoFormat) ?? DateTime(1970);
  }

  String convertToISOFormat(String value) {
    final Map<String, RegExp> dateFormats = {
      'YYYYMMDD': RegExp(r'^(\d{4})(\d{2})(\d{2})$'),
      'DDMMYYYY': RegExp(r'^(\d{2})(\d{2})(\d{4})$'),
      'MMDDYYYY': RegExp(r'^(\d{2})(\d{2})(\d{4})$'),
      'YYYY/MM/DD': RegExp(r'^(\d{4})/(\d{2})/(\d{2})$'),
      'DD/MM/YYYY': RegExp(r'^(\d{2})/(\d{2})/(\d{4})$'),
      'MM/DD/YYYY': RegExp(r'^(\d{2})/(\d{2})/(\d{4})$'),
      'YYYYMMMDD': RegExp(r'^(\d{4})(\w{3})(\d{2})$'),
      'DDMMMYYYY': RegExp(r'^(\d{2})(\w{3})(\d{4})$'),
      'MMMDDYYYY': RegExp(r'^(\w{3})(\d{2})(\d{4})$'),
      'YYDDD': RegExp(r'^(\d{2})(\d{3})$'),
      'YYYYDDD': RegExp(r'^(\d{4})(\d{3})$'),
      'MM/DD/YY HH:MM:SS': RegExp(r'^(\d{2})/(\d{2})/(\d{2}) (\d{2}):(\d{2}):(\d{2})$'),
      'YYMMDD HHMMSS': RegExp(r'^(\d{2})(\d{2})(\d{2}) (\d{2})(\d{2})(\d{2})$'),
      'YYYY-MMDDTHH:MM:SS': RegExp(r'^(\d{4})-(\d{2})(\d{2})T(\d{2}):(\d{2}):(\d{2})$'),
      'YYYY-MM-DD': RegExp(r'^(\d{4})-(\d{2})-(\d{2})$'),
      'YYYY-MM': RegExp(r'^(\d{4})-(\d{2})$'),
    };

    for (var format in dateFormats.keys) {
      var match = dateFormats[format]!.firstMatch(value);
      if (match != null) {
        switch (format) {
          case 'YYYYMMDD':
            return '${match.group(1)}-${match.group(2)}-${match.group(3)}T00:00:00.000Z';
          case 'DDMMYYYY':
            return '${match.group(3)}-${match.group(2)}-${match.group(1)}T00:00:00.000Z';
          case 'MMDDYYYY':
          case 'YYYY/MM/DD':
          case 'DD/MM/YYYY':
          case 'MM/DD/YYYY':
            return '${match.group(3)}-${match.group(1)}-${match.group(2)}T00:00:00.000Z';
          case 'YYYYMMMDD':
            var year = match.group(1);
            var month = _convertMonth(match.group(2)!);
            var day = match.group(3);
            return '$year-$month-${day}T00:00:00.000Z';
          case 'DDMMMYYYY':
            return '${match.group(3)}-${_convertMonth(match.group(2)!)}-${match.group(1)}T00:00:00.000Z';
          case 'MMMDDYYYY':
            var year = match.group(3);
            var month = _convertMonth(match.group(1)!);
            var day = match.group(2);
            return '$year-$month-{$day}T00:00:00.000Z';
          case 'YYDDD':
            return '20${match.group(1)}-${_convertDayOfYear(match.group(2)!)}T00:00:00.000Z';
          case 'YYYYDDD':
            return '${match.group(1)}-${_convertDayOfYear(match.group(2)!)}T00:00:00.000Z';
          case 'MM/DD/YY HH:MM:SS':
            return '20${match.group(1)}-${match.group(2)}-${match.group(3)}T${match.group(4)}:${match.group(5)}:${match.group(6)}.000Z';
          case 'YYMMDD HHMMSS':
            return '20${match.group(1)}-${match.group(2)}-${match.group(3)}T${match.group(4)}:${match.group(5)}:${match.group(6)}.000Z';
          case 'YYYY-MMDDTHH:MM:SS':
            return '${match.group(1)}-${match.group(2)}-${match.group(3)}T${match.group(4)}:${match.group(5)}:${match.group(6)}Z';
          case 'YYYY-MM-DD':
            return '${match.group(1)}-${match.group(2)}-${match.group(3)}T00:00:00.000Z';
          case 'YYYY-MM':
            return '${match.group(1)}-${match.group(2)}-01T00:00:00.000Z';
          default:
            return '0000-00-00T00:00:00.000Z';
        }
      }
    }

    return '0000-00-00T00:00:00.000Z';
  }

  String _convertMonth(String month) {
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
        return '01';
    }
  }

  String _convertDayOfYear(String dayOfYear) {
    var day = int.parse(dayOfYear);
    var date = DateTime(DateTime.now().year, 1, 1).add(Duration(days: day - 1));
    return '${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
