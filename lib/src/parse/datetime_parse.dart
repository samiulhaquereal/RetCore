class RetCoreDateTimeParse {
  DateTime parseDateTime({required String value, required DateTime defaultValue}) {
    try {
      // Try parsing with known formats
      if (RegExp(r'^\d{6}$').hasMatch(value)) {
        // YYMMDD
        int year = int.parse(value.substring(0, 2)) + 2000;
        int month = int.parse(value.substring(2, 4));
        int day = int.parse(value.substring(4, 6));
        return DateTime(year, month, day);
      } else if (RegExp(r'^\d{8}$').hasMatch(value)) {
        // YYYYMMDD or DDMMYYYY
        int year = int.parse(value.substring(0, 4));
        int month = int.parse(value.substring(4, 6));
        int day = int.parse(value.substring(6, 8));
        return DateTime(year, month, day);
      } else if (RegExp(r'^\d{4}/\d{2}/\d{2}$').hasMatch(value) ||
          RegExp(r'^\d{2}/\d{2}/\d{2}$').hasMatch(value)) {
        // YYYY/MM/DD or YY/MM/DD
        var parts = value.split('/');
        if (parts[0].length == 4) {
          // YYYY/MM/DD
          int year = int.parse(parts[0]);
          int month = int.parse(parts[1]);
          int day = int.parse(parts[2]);
          return DateTime(year, month, day);
        } else {
          // YY/MM/DD
          int year = int.parse(parts[0]) + 2000;
          int month = int.parse(parts[1]);
          int day = int.parse(parts[2]);
          return DateTime(year, month, day);
        }
      } else if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value)) {
        // YYYY-MM-DD
        return DateTime.parse(value);
      } else if (RegExp(r'^\d{2}:\d{2}:\d{2}$').hasMatch(value)) {
        // HH:MM:SS
        return DateTime(1970, 1, 1, int.parse(value.substring(0, 2)), int.parse(value.substring(3, 5)), int.parse(value.substring(6, 8)));
      } else if (RegExp(r'^\d{2}:\d{2}$').hasMatch(value)) {
        // HH:MM
        return DateTime(1970, 1, 1, int.parse(value.substring(0, 2)), int.parse(value.substring(3, 5)));
      } else if (RegExp(r'^\d{2}\d{2}\d{2}$').hasMatch(value)) {
        // HHMMSS
        return DateTime(1970, 1, 1, int.parse(value.substring(0, 2)), int.parse(value.substring(2, 4)), int.parse(value.substring(4, 6)));
      } else if (RegExp(r'^\d{2}\d{2}$').hasMatch(value)) {
        // HHMM
        return DateTime(1970, 1, 1, int.parse(value.substring(0, 2)), int.parse(value.substring(2, 4)));
      } else if (RegExp(r'^\d{8}T\d{6}\.\d{3}Z$').hasMatch(value)) {
        // YYYYMMDDTHHMMSSmmmZ
        return DateTime.parse(value);
      } else if (RegExp(r'^\d{8}Z$').hasMatch(value)) {
        // YYYYMMDDZ
        return DateTime.parse(value.substring(0, 8));
      } else if (RegExp(r'^\d{4}').hasMatch(value)) {
        // YYYY or YYYY-MM
        if (value.length == 4) {
          return DateTime(int.parse(value), 1, 1);
        } else if (value.length == 7) {
          return DateTime(int.parse(value.substring(0, 4)), int.parse(value.substring(5, 7)));
        }
      }
    } catch (e) {
      // Return default value if parsing fails
      return defaultValue;
    }
    // Return default value if no format matched
    return defaultValue;
  }
}
