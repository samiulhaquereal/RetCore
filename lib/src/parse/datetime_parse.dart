import 'dart:developer';
import 'package:intl/intl.dart';

class RetCoreDateTimeParse {
  static RetCoreDateTimeParse? _instance;
  RetCoreDateTimeParse._internal();

  factory RetCoreDateTimeParse() {
    _instance ??= RetCoreDateTimeParse._internal();
    return _instance!;
  }

  static String CurrentTime() {
    DateTime now = DateTime.now();

    // Manually format each component
    String year = now.year.toString().padLeft(4, '0');
    String month = now.month.toString().padLeft(2, '0');
    String day = now.day.toString().padLeft(2, '0');
    String hour = now.hour.toString().padLeft(2, '0');
    String minute = now.minute.toString().padLeft(2, '0');
    String second = now.second.toString().padLeft(2, '0');
    String millisecond = now.millisecond.toString().padLeft(3, '0');

    // Calculate the timezone offset in hours and minutes
    int offset = now.timeZoneOffset.inMinutes;
    String sign = offset >= 0 ? '+' : '-';
    int offsetHours = (offset.abs() / 60).floor();
    int offsetMinutes = offset.abs() % 60;
    String timeZone = '$sign${offsetHours.toString().padLeft(2, '0')}:${offsetMinutes.toString().padLeft(2, '0')}';

    // Combine all components into the final formatted string
    String formattedDateTime = '$year-$month-{$day}T$hour:$minute:$second.$millisecond$timeZone';

    return formattedDateTime;
  }

  String? parseDateTime({required String input}) {
    final formatters = {
      'YYMMDD': RegExp(r'^(\d{2})(\d{2})(\d{2})$'),
      'MMDDYY': RegExp(r'^(\d{2})(\d{2})(\d{2})$'),
      'YYYYMMDD': RegExp(r'^(\d{4})(\d{2})(\d{2})$'),
      'DDMMYYYY': RegExp(r'^(\d{2})(\d{2})(\d{4})$'),
      'MMDDYYYY': RegExp(r'^(\d{2})(\d{2})(\d{4})$'),
      'DDMMYY': RegExp(r'^(\d{2})(\d{2})(\d{2})$'),
      'YYDDD': RegExp(r'^(\d{2})(\d{3})$'),
      'DDDYY': RegExp(r'^(\d{3})(\d{2})$'),
      'YY/MM/DD': RegExp(r'^(\d{2})/(\d{2})/(\d{2})$'),
      'DD/MM/YY': RegExp(r'^(\d{2})/(\d{2})/(\d{2})$'),
      'MM/DD/YY': RegExp(r'^(\d{2})/(\d{2})/(\d{2})$'),
      'YYYY/MM/DD': RegExp(r'^(\d{4})/(\d{2})/(\d{2})$'),
      'DD/MM/YYYY': RegExp(r'^(\d{2})/(\d{2})/(\d{4})$'),
      'MM/DD/YYYY': RegExp(r'^(\d{2})/(\d{2})/(\d{4})$'),
      'YY/DDD': RegExp(r'^(\d{2})/(\d{3})$'),
      'DDD/YY': RegExp(r'^(\d{3})/(\d{2})$'),
      'YYYY/DDD': RegExp(r'^(\d{4})/(\d{3})$'),
      'DDD/YYYY': RegExp(r'^(\d{3})/(\d{4})$'),
      'HHMMSS': RegExp(r'^(\d{2})(\d{2})(\d{2})$'),
      'HH:MM': RegExp(r'^(\d{2}):(\d{2})$'),
      'HH:MM:SS': RegExp(r'^(\d{2}):(\d{2}):(\d{2})$'),
      'MM/DD/YY HH:MM:SS': RegExp(r'^(\d{2})/(\d{2})/(\d{2}) (\d{2}):(\d{2}):(\d{2})$'),
      'YYYY-MM-DD': RegExp(r'^(\d{4})-(\d{1,2})-(\d{1,2})$'),  // Adjusted for single-digit month and day
      'YYYY-MM': RegExp(r'^(\d{4})-(\d{2})$'),
      '--MM-DD': RegExp(r'^--(\d{2})-(\d{2})$'),
      '---DD': RegExp(r'^---(\d{2})$'),
      'YYMMMDD': RegExp(r'^(\d{2})(\w{3})(\d{2})$'),
      'DDMMMYY': RegExp(r'^(\d{2})(\w{3})(\d{2})$'),
      'MMMDDYY': RegExp(r'^(\w{3})(\d{2})(\d{2})$'),
      'YYYYMMMDD': RegExp(r'^(\d{4})(\w{3})(\d{2})$'),
      'DDMMMYYYY': RegExp(r'^(\d{2})(\w{3})(\d{4})$'),
      'MMMDDYYYY': RegExp(r'^(\w{3})(\d{2})(\d{4})$'),
      'YYYYDDD': RegExp(r'^(\d{4})(\d{3})$'),
      'DDDYYYY': RegExp(r'^(\d{3})(\d{4})$'),
      'YY/MMM/DD': RegExp(r'^(\d{2})/(\w{3})/(\d{2})$'),
      'DD/MMM/YY': RegExp(r'^(\d{2})/(\w{3})/(\d{2})$'),
      'MMM/DD/YY': RegExp(r'^(\w{3})/(\d{2})/(\d{2})$'),
      'YYYY/MMM/DD': RegExp(r'^(\d{4})/(\w{3})/(\d{2})$'),
      'DD/MMM/YYYY': RegExp(r'^(\d{2})/(\w{3})/(\d{4})$'),
      'MMM/DD/YYYY': RegExp(r'^(\w{3})/(\d{2})/(\d{4})$'),
      'HHMM': RegExp(r'^(\d{2})(\d{2})$'),
      'YYYYMMDDTHHMMSSmmmZ': RegExp(r'^(\d{4})(\d{2})(\d{2})T(\d{2})(\d{2})(\d{2}).(\d{3})Z$'),
      'YYYYMMDDZ': RegExp(r'^(\d{4})(\d{2})(\d{2})Z$'),
      'YYMMDD HHMMSS': RegExp(r'^(\d{2})(\d{2})(\d{2}) (\d{2})(\d{2})(\d{2})$'),
      'YYYY-MMDDTHH:MM:SS': RegExp(r'^(\d{4})-(\d{2})(\d{2})T(\d{2}):(\d{2}):(\d{2})$'),
    };

    for (var format in formatters.keys) {
      var regex = formatters[format];
      var match = regex?.firstMatch(input);
      if (match != null) {
        switch (format) {
          case 'YYMMDD':
            return DateTime.parse('20${match[1]}-${match[2]}-${match[3]}T00:00:00.000Z').toString();
          case 'MMDDYY':
            if (input.length == 6) {
              // Attempt to parse as MMDDYY
              try {
                String month = match[1]!;
                String day = match[2]!;
                String year = match[3]!;
                // Adjust the year to a four-digit format (assuming it's always 20YY)
                String fullYear = '20$year';
                // Create DateTime object
                DateTime dateTime = DateTime(
                  int.parse(fullYear),
                  int.parse(month),
                  int.parse(day),
                );
                // Format DateTime in ISO 8601 format with milliseconds and UTC timezone
                String formattedDateTime = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(dateTime);
                return formattedDateTime;
              } catch (e) {
                // If parsing as MMDDYY fails, attempt to parse as HHMMSS
                try {
                  String hour = input.substring(0, 2);
                  String minute = input.substring(2, 4);
                  String second = input.substring(4, 6);

                  DateTime now = DateTime.now();
                  DateTime dateTime = DateTime(
                    now.year,
                    now.month,
                    now.day,
                    int.parse(hour),
                    int.parse(minute),
                    int.parse(second),
                  );

                  String formattedDateTime = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS\'Z\'').format(dateTime.toUtc());
                  return formattedDateTime;
                } catch (e) {
                  log('Invalid format: Unable to parse the input string.');
                }
              }
            } else {
              log('Invalid input length: Expected length of 6 characters.');
            }
          case 'YYYYMMDD':
            return DateTime.parse('${match[1]}-${match[2]}-${match[3]}T00:00:00.000Z').toString();
          case 'DDMMYYYY':
            String day = match.group(1)!;
            String month = match.group(2)!;
            String year = match.group(3)!;
            // Create DateTime object
            DateTime dateTime = DateTime(int.parse(year), int.parse(month), int.parse(day));
            // Format DateTime object in ISO 8601 format with UTC timezone
            String formattedDateTime = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(dateTime);
            return formattedDateTime;
          case 'MMDDYYYY':
            String month = match.group(1)!;
            String day = match.group(2)!;
            String year = match.group(3)!;
            // Create DateTime object
            DateTime dateTime = DateTime(int.parse(year), int.parse(month), int.parse(day));
            // Format DateTime object in ISO 8601 format with UTC timezone
            String formattedDateTime = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(dateTime.toUtc());
            return formattedDateTime;
          case 'DDMMYY':
            String day = match.group(1)!;
            String month = match.group(2)!;
            String year = match.group(3)!;
            // Determine the full year
            int fullYear = int.parse(year) >= 50 ? 1900 + int.parse(year) : 2000 + int.parse(year);
            // Create DateTime object
            DateTime dateTime = DateTime(fullYear, int.parse(month), int.parse(day));
            // Format DateTime object in ISO 8601 format with UTC timezone
            String formattedDateTime = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS\'Z\'').format(dateTime.toUtc());
            return formattedDateTime;
          case 'YYMMMDD':
            String yearYY = match.group(1)!;
            String monthMMM = match.group(2)!;
            String dayDD = match.group(3)!;
            int year = int.parse('20$yearYY');
            // Parse month from abbreviation
            int month = monthMapping[monthMMM.toUpperCase()] ?? 1;
            // Parse day as an integer
            int day = int.parse(dayDD);
            // Create DateTime object with parsed components
            DateTime dateTime = DateTime(year, month, day);
            String formattedDateTime = dateTime.toIso8601String();
            formattedDateTime = formattedDateTime.substring(0, 10) + 'T00:00:00.000Z';
            return formattedDateTime;
          case 'DDMMMYY':
            String dayDD = match.group(1)!;
            String monthMMM = match.group(2)!;
            String yearYY = match.group(3)!;
            // Parse year as an integer (assumed to be in the 20YY format)
            int year = int.parse('20$yearYY');
            // Parse month from abbreviation
            int month = monthMapping2[monthMMM.substring(0, 1).toUpperCase() + monthMMM.substring(1).toLowerCase()] ?? 1;
            // Parse day as an integer
            int day = int.parse(dayDD);
            // Create DateTime object with parsed components
            DateTime dateTime = DateTime(year, month, day);
            // Format DateTime in ISO 8601 format with milliseconds and UTC timezone
            String formattedDateTime = dateTime.toIso8601String();
            // Append the time component 'T00:00:00.000Z'
            formattedDateTime = formattedDateTime.substring(0, 10) + 'T00:00:00.000Z';
            return formattedDateTime;
          case 'MMMDDYY':
            String monthMMM = match.group(1)!;
            String dayDD = match.group(2)!;
            String yearYY = match.group(3)!;
            // Parse year as an integer (assumed to be in the 20YY format)
            int year = int.parse('20$yearYY');
            // Parse month from abbreviation
            int month = monthMapping2[monthMMM.substring(0, 1).toUpperCase() + monthMMM.substring(1).toLowerCase()] ?? 1;
            // Parse day as an integer
            int day = int.parse(dayDD);
            // Create DateTime object with parsed components
            DateTime dateTime = DateTime(year, month, day);
            // Format DateTime in ISO 8601 format with milliseconds and UTC timezone
            String formattedDateTime = dateTime.toIso8601String();
            // Append the time component 'T00:00:00.000Z'
            formattedDateTime = formattedDateTime.substring(0, 10) + 'T00:00:00.000Z';
            return formattedDateTime;
          case 'YYYYMMMDD':
            String yearYYYY = match.group(1)!;
            String monthMMM = match.group(2)!;
            String dayDD = match.group(3)!;
            // Parse year as an integer
            int year = int.parse(yearYYYY);
            // Parse month from abbreviation
            int month = monthMapping2[monthMMM.substring(0, 1).toUpperCase() + monthMMM.substring(1).toLowerCase()] ?? 1;
            // Parse day as an integer
            int day = int.parse(dayDD);
            // Create DateTime object with parsed components
            DateTime dateTime = DateTime(year, month, day);
            // Format DateTime in ISO 8601 format with milliseconds and UTC timezone
            String formattedDateTime = dateTime.toIso8601String();
            // Append the time component 'T00:00:00.000Z'
            formattedDateTime = formattedDateTime.substring(0, 10) + 'T00:00:00.000Z';
            return formattedDateTime;
          case 'DDMMMYYYY':
            String dayDD = match.group(1)!;
            String monthMMM = match.group(2)!;
            String yearYYYY = match.group(3)!;
            // Parse day as an integer
            int day = int.parse(dayDD);
            // Parse month from abbreviation
            int month = monthMapping2[monthMMM.substring(0, 1).toUpperCase() + monthMMM.substring(1).toLowerCase()] ?? 1;
            // Parse year as an integer
            int year = int.parse(yearYYYY);
            // Create DateTime object with parsed components
            DateTime dateTime = DateTime(year, month, day);
            // Format DateTime in ISO 8601 format with milliseconds and UTC timezone
            String formattedDateTime = dateTime.toIso8601String();
            // Append the time component 'T00:00:00.000Z'
            formattedDateTime = formattedDateTime.substring(0, 10) + 'T00:00:00.000Z';
            return formattedDateTime;
          case 'MMMDDYYYY':
            String monthMMM = match.group(1)!;
            String dayDD = match.group(2)!;
            String yearYYYY = match.group(3)!;
            // Parse month from abbreviation
            int month = monthMapping[monthMMM.substring(0, 1).toUpperCase() + monthMMM.substring(1).toLowerCase()] ?? 1;
            // Parse day and year as integers
            int day = int.parse(dayDD);
            int year = int.parse(yearYYYY);
            // Create DateTime object with parsed components
            DateTime dateTime = DateTime(year, month, day);
            // Format DateTime in ISO 8601 format with milliseconds and UTC timezone
            String formattedDateTime = dateTime.toIso8601String();
            // Append the time component 'T00:00:00.000Z'
            formattedDateTime = formattedDateTime.substring(0, 10) + 'T00:00:00.000Z';
            return formattedDateTime;
          case 'YYDDD':
            //return DateTime(int.parse('20${match[1]}')).add(Duration(days: int.parse(match[2]!) - 1));
          // Assuming match[1] contains the last two digits of the year and match[2] contains the day of the year
          // Extract year and day of year
            int year = int.parse('20${match[1]}');
            int dayOfYear = int.parse(match[2]!);
            // Calculate date and format as required
            DateTime dateTime = DateTime(year).add(Duration(days: dayOfYear - 1));
            String formattedDate = '${dateTime.year.toString().padLeft(4, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}T00:00:00.000Z';
            return formattedDate;
          case 'DDDYY':
            //return DateTime(int.parse('20${match[2]}')).add(Duration(days: int.parse(match[1]!) - 1));
          // Extract year and day of year
            int year = int.parse('20${match[2]}');
            int dayOfYear = int.parse(match[1]!);
            // Calculate date and format as required
            DateTime dateTime = DateTime(year).add(Duration(days: dayOfYear - 1));
            String formattedDate = '${dateTime.year.toString().padLeft(4, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}T00:00:00.000Z';
            return formattedDate;
          case 'YYYYDDD':
          // Extract components from the match
            String yearYYYY = match.group(1)!;
            String dayOfYearDDD = match.group(2)!;
            // Parse year and dayOfYear as integers
            int year = int.parse(yearYYYY);
            int dayOfYear = int.parse(dayOfYearDDD);
            // Create DateTime object for the given year and day of year
            DateTime dateTime = DateTime(year, 1, 1).add(Duration(days: dayOfYear - 1));
            // Format DateTime in ISO 8601 format with milliseconds and UTC timezone
            String formattedDateTime = dateTime.toIso8601String();
            // Append the time component 'T00:00:00.000Z'
            formattedDateTime = formattedDateTime.substring(0, 10) + 'T00:00:00.000Z';
            return formattedDateTime;
          case 'DDDYYYY':
          // Extract components from the match
            String dayOfYearDDD = match.group(1)!;
            String yearYYYY = match.group(2)!;
            // Parse year and dayOfYear as integers
            int year = int.parse(yearYYYY);
            int dayOfYear = int.parse(dayOfYearDDD);
            // Create DateTime object for the given year and day of year
            DateTime dateTime = DateTime(year, 1, 1).add(Duration(days: dayOfYear - 1));
            // Format DateTime in ISO 8601 format with milliseconds and UTC timezone
            String formattedDateTime = dateTime.toIso8601String();
            // Append the time component 'T00:00:00.000Z'
            formattedDateTime = formattedDateTime.substring(0, 10) + 'T00:00:00.000Z';
            return formattedDateTime;
          case 'YY/MM/DD':
            String year = match.group(1)!;
            String month = match.group(2)!;
            String day = match.group(3)!;
            // Determine the full year
            int fullYear = int.parse(year) >= 50 ? 1900 + int.parse(year) : 2000 + int.parse(year);
            // Create DateTime object
            DateTime dateTime = DateTime(fullYear, int.parse(month), int.parse(day));
            // Format DateTime object in ISO 8601 format with UTC timezone
            String formattedDateTime = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(dateTime.toUtc());
            return formattedDateTime;
          case 'DD/MM/YY':
            String day = match.group(1)!;
            String month = match.group(2)!;
            String year = match.group(3)!;
            // Determine the full year
            int fullYear = int.parse(year) >= 50 ? 1900 + int.parse(year) : 2000 + int.parse(year);
            // Create DateTime object
            DateTime dateTime = DateTime(fullYear, int.parse(month), int.parse(day));
            // Format DateTime object in ISO 8601 format with UTC timezone
            String formattedDateTime = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS\'Z\'').format(dateTime.toUtc());
            return formattedDateTime;
          case 'MM/DD/YY':
            String month = match.group(1)!;
            String day = match.group(2)!;
            String year = match.group(3)!;
            // Determine the full year
            int fullYear = int.parse(year) >= 50 ? 1900 + int.parse(year) : 2000 + int.parse(year);
            // Create DateTime object
            DateTime dateTime = DateTime(fullYear, int.parse(month), int.parse(day));
            // Format DateTime object in ISO 8601 format with UTC timezone
            String formattedDateTime = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS\'Z\'').format(dateTime.toUtc());
            return formattedDateTime;
          case 'YYYY/MM/DD':
            return DateTime.parse('${match[1]}-${match[2]}-${match[3]}T00:00:00.000Z').toString();
          case 'DD/MM/YYYY':
            return DateTime.parse('${match[3]}-${match[2]}-${match[1]}T00:00:00.000Z').toString();
          case 'MM/DD/YYYY':
            String month = match.group(1)!;
            String day = match.group(2)!;
            String year = match.group(3)!;
            // Create DateTime object
            DateTime dateTime = DateTime(int.parse(year), int.parse(month), int.parse(day));
            // Format DateTime object in ISO 8601 format with UTC timezone
            String formattedDateTime = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS\'Z\'').format(dateTime.toUtc());
            return formattedDateTime;
          case 'YY/MMM/DD':
            String yearYY = match.group(1)!;
            String monthMMM = match.group(2)!;
            String dayDD = match.group(3)!;
            // Convert month abbreviation to numeric month
            int month = _getMonthFromAbbreviation(monthMMM);
            // Parse year, month, and day as integers
            int year = 2000 + int.parse(yearYY); // Assuming year range from 2000-2099
            int day = int.parse(dayDD);
            // Create DateTime object for the given year, month, and day
            DateTime dateTime = DateTime(year, month, day);
            // Format DateTime in ISO 8601 format with milliseconds and UTC timezone
            String formattedDateTime = dateTime.toIso8601String();
            // Append the time component 'T00:00:00.000Z'
            formattedDateTime = formattedDateTime.substring(0, 10) + 'T00:00:00.000Z';
            return formattedDateTime;
          case 'DD/MMM/YY':
          // Extract components from the match
            String day = match.group(1)!;
            String monthAbbreviation = match.group(2)!;
            String year = '20${match.group(3)}';
            // Convert month abbreviation to numeric month
            String month = monthMap[monthAbbreviation] ?? '01'; // Default to '01' if not found
            // Create DateTime object
            DateTime dateTime = DateTime(int.parse(year), int.parse(month), int.parse(day));

            // Format DateTime to ISO 8601 format
            String isoFormatted = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS\'Z\'').format(dateTime.toUtc());
            return isoFormatted;
          case 'MMM/DD/YY':
            String monthMMM = match.group(1)!;
            String dayDD = match.group(2)!;
            String yearYY = match.group(3)!;
            // Convert month abbreviation to numeric month
            int month = _getMonthFromAbbreviation(monthMMM);
            // Parse year, month, and day as integers
            int year = 2000 + int.parse(yearYY); // Assuming year range from 2000-2099
            int day = int.parse(dayDD);
            // Create DateTime object for the given year, month, and day
            DateTime dateTime = DateTime(year, month, day);
            // Format DateTime in ISO 8601 format with milliseconds and UTC timezone
            String formattedDateTime = dateTime.toIso8601String();
            // Append the time component 'T00:00:00.000Z'
            formattedDateTime = formattedDateTime.substring(0, 10) + 'T00:00:00.000Z';
            return formattedDateTime;
          case 'YYYY/MMM/DD':
          // Extract components from the match
            String yearYYYY = match.group(1)!;
            String monthMMM = match.group(2)!;
            String dayDD = match.group(3)!;
            // Convert month abbreviation to numeric month
            int month = _getMonthFromAbbreviation(monthMMM);
            // Parse year, month, and day as integers
            int year = int.parse(yearYYYY);
            int day = int.parse(dayDD);
            // Create DateTime object for the given year, month, and day
            DateTime dateTime = DateTime(year, month, day);
            // Format DateTime in ISO 8601 format with milliseconds and UTC timezone
            String formattedDateTime = dateTime.toIso8601String();
            // Append the time component 'T00:00:00.000Z'
            formattedDateTime = formattedDateTime.substring(0, 10) + 'T00:00:00.000Z';
            return formattedDateTime;
          case 'DD/MMM/YYYY':
          // Extract components from the match
            String dayDD = match.group(1)!;
            String monthMMM = match.group(2)!;
            String yearYYYY = match.group(3)!;
            // Convert month abbreviation to numeric month
            int month = _getMonthFromAbbreviation(monthMMM);
            // Parse year, month, and day as integers
            int year = int.parse(yearYYYY);
            int day = int.parse(dayDD);
            // Create DateTime object for the given year, month, and day
            DateTime dateTime = DateTime(year, month, day);
            // Format DateTime in ISO 8601 format with milliseconds and UTC timezone
            String formattedDateTime = dateTime.toIso8601String();
            // Append the time component 'T00:00:00.000Z'
            formattedDateTime = formattedDateTime.substring(0, 10) + 'T00:00:00.000Z';
            return formattedDateTime;
          case 'MMM/DD/YYYY':
          // Extract components from the match
            String monthMMM = match.group(1)!;
            String dayDD = match.group(2)!;
            String yearYYYY = match.group(3)!;
            // Convert month abbreviation to numeric month
            int month = _getMonthFromAbbreviation(monthMMM);
            // Parse year, month, and day as integers
            int year = int.parse(yearYYYY);
            int day = int.parse(dayDD);
            // Create DateTime object for the given year, month, and day
            DateTime dateTime = DateTime(year, month, day);
            // Format DateTime in ISO 8601 format with milliseconds and UTC timezone
            String formattedDateTime = dateTime.toIso8601String();
            // Append the time component 'T00:00:00.000Z'
            formattedDateTime = formattedDateTime.substring(0, 10) + 'T00:00:00.000Z';
            return formattedDateTime;
          case 'YY/DDD':
            int yearYYDDD = int.parse('20${match[1]}');
            int dayOfYearYYDDD = int.parse(match[2]!);
            DateTime dateTimeYYDDD = DateTime(yearYYDDD).add(Duration(days: dayOfYearYYDDD - 1));
            return '${dateTimeYYDDD.year.toString().padLeft(4, '0')}-${dateTimeYYDDD.month.toString().padLeft(2, '0')}-${dateTimeYYDDD.day.toString().padLeft(2, '0')}T00:00:00.000Z';

          case 'DDD/YY':
            int yearDDDYY = int.parse('20${match[2]}');
            int dayOfYearDDDYY = int.parse(match[1]!);
            DateTime dateTimeDDDYY = DateTime(yearDDDYY).add(Duration(days: dayOfYearDDDYY - 1));
            return '${dateTimeDDDYY.year.toString().padLeft(4, '0')}-${dateTimeDDDYY.month.toString().padLeft(2, '0')}-${dateTimeDDDYY.day.toString().padLeft(2, '0')}T00:00:00.000Z';

          case 'YYYY/DDD':
            int yearYYYYDDD = int.parse(match[1]!);
            int dayOfYearYYYYDDD = int.parse(match[2]!);
            DateTime dateTimeYYYYDDD = DateTime(yearYYYYDDD).add(Duration(days: dayOfYearYYYYDDD - 1));
            return '${dateTimeYYYYDDD.year.toString().padLeft(4, '0')}-${dateTimeYYYYDDD.month.toString().padLeft(2, '0')}-${dateTimeYYYYDDD.day.toString().padLeft(2, '0')}T00:00:00.000Z';

          case 'DDD/YYYY':
            int yearDDDYYYY = int.parse(match[2]!);
            int dayOfYearDDDYYYY = int.parse(match[1]!);
            DateTime dateTimeDDDYYYY = DateTime(yearDDDYYYY).add(Duration(days: dayOfYearDDDYYYY - 1));
            return '${dateTimeDDDYYYY.year.toString().padLeft(4, '0')}-${dateTimeDDDYYYY.month.toString().padLeft(2, '0')}-${dateTimeDDDYYYY.day.toString().padLeft(2, '0')}T00:00:00.000Z';
          case 'HHMM':
          // Parse hours and minutes from input
            String hours = input.substring(0, 2);
            String minutes = input.substring(2, 4);
            // Get current date to create DateTime object
            DateTime now = DateTime.now();
            // Create DateTime object with current date, parsed hours, and minutes
            DateTime dateTime = DateTime(now.year, now.month, now.day, int.parse(hours), int.parse(minutes));
            // Format DateTime in ISO 8601 format with milliseconds and UTC timezone
            String formattedDateTime = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(dateTime);
            return formattedDateTime;
          case 'HH:MM':
            DateTime dateTimeHHMM = DateFormat('HH:mm').parse(input);
            return DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(dateTimeHHMM.toUtc()).toString();
          case 'HH:MM:SS':
            DateTime dateTimeHHMMSS = DateFormat('HH:mm:ss').parse(input);
            return DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(dateTimeHHMMSS.toUtc()).toString();
          case 'YYYYMMDDTHHMMSSmmmZ':
          // Parse year, month, day, hour, minute, second, millisecond, and timezone offset from input
            String year = input.substring(0, 4);
            String month = input.substring(4, 6);
            String day = input.substring(6, 8);
            String hour = input.substring(9, 11);
            String minute = input.substring(11, 13);
            String second = input.substring(13, 15);
            String millisecond = input.substring(15, 18);
            String timezoneOffset = input.substring(18); // Z or timezone offset
            // Create DateTime object
            DateTime dateTime = DateTime.utc(
              int.parse(year),
              int.parse(month),
              int.parse(day),
              int.parse(hour),
              int.parse(minute),
              int.parse(second),
              int.parse(millisecond),
            );
            // Handle timezone offset
            if (timezoneOffset == 'Z') {
              // UTC time, already handled by DateTime.utc()
            } else if (timezoneOffset.startsWith('+') || timezoneOffset.startsWith('-')) {
              // Parse offset like '+HH:mm' or '-HH:mm' and adjust dateTime
              String sign = timezoneOffset.substring(0, 1);
              String hoursStr = timezoneOffset.substring(1, 3);
              String minutesStr = timezoneOffset.substring(3);
              int hours = int.parse(hoursStr);
              int minutes = int.parse(minutesStr);
              // Adjust dateTime based on the offset
              dateTime = dateTime.add(Duration(
                hours: (sign == '+' ? -hours : hours),
                minutes: (sign == '+' ? -minutes : minutes),
              ));
            } else {
              throw FormatException('Invalid timezone offset: $timezoneOffset');
            }
            // Format DateTime in ISO 8601 format with milliseconds and UTC timezone
            String formattedDateTime = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(dateTime);
            return formattedDateTime;
          case 'YYYYMMDDZ':
          // Parse year, month, and day from input
            String year = input.substring(0, 4);
            String month = input.substring(4, 6);
            String day = input.substring(6, 8);
            // Create DateTime object
            DateTime dateTime = DateTime(int.parse(year), int.parse(month), int.parse(day));
            // Format DateTime in ISO 8601 format with milliseconds and UTC timezone
            String formattedDateTime = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(dateTime);
            return formattedDateTime;
          case 'MM/DD/YY HH:MM:SS':
            DateTime dateTimeMMDDYY_HHMMSS = DateFormat('MM/dd/yy HH:mm:ss').parse(input);
            return DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(dateTimeMMDDYY_HHMMSS.toUtc()).toString();
          case 'YYMMDD HHMMSS':
          // Extract components from the match
            String year = '20${match[1]}';
            String month = match[2]!;
            String day = match[3]!;
            String hour = match[4]!;
            String minute = match[5]!;
            String second = match[6]!;
            // Create DateTime object
            DateTime dateTime = DateTime(
              int.parse(year),
              int.parse(month),
              int.parse(day),
              int.parse(hour),
              int.parse(minute),
              int.parse(second),
            );
            // Format DateTime in ISO 8601 format with milliseconds and UTC timezone
            String formattedDateTime = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(dateTime);
            return formattedDateTime;
          case 'YYYY-MMDDTHH:MM:SS':
            String year = match[1]!;
            String month = match[2]!;
            String day = match[3]!;
            String hour = match[4]!;
            String minute = match[5]!;
            String second = match[6]!;
            // Create DateTime object
            DateTime dateTime = DateTime(
              int.parse(year),
              int.parse(month),
              int.parse(day),
              int.parse(hour),
              int.parse(minute),
              int.parse(second),
            );
            // Format DateTime in ISO 8601 format with milliseconds and UTC timezone
            String formattedDateTime = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(dateTime);
            return formattedDateTime;
          case 'YYYY-MM-DD':
          // Ensure leading zeros for single-digit months and days
            var year = match[1]!;
            var month = match[2]!.padLeft(2, '0');
            var day = match[3]!.padLeft(2, '0');
            DateTime dateTimeYYYYMMDD = DateTime.parse('$year-$month-$day');
            return DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(dateTimeYYYYMMDD.toUtc()).toString();
          case 'YYYY-MM':
            DateTime dateTimeYYYYMM = DateFormat('yyyy-MM').parse(input);
            return DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(dateTimeYYYYMM.toUtc()).toString();
          /*case 'YYYY':
            return DateFormat('yyyy').parse(input);*/
          case '--MM-DD':
            DateTime dateTimeMMDD = DateFormat('--MM-dd').parse(input);
            return DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(dateTimeMMDD.toUtc()).toString();
          case '---DD':
            DateTime dateTimeDD = DateFormat('---dd').parse(input);
            return DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(dateTimeDD.toUtc()).toString();
          default:
            log('Unsupported format: $input', name: 'parseDateTime');
            return null;
        }
      }
    }
    log('Unsupported format: $input', name: 'parseDateTime');
    return null;
  }

  Map<String, int> monthMapping = {
    'JAN': 1, 'FEB': 2, 'MAR': 3, 'APR': 4,
    'MAY': 5, 'JUN': 6, 'JUL': 7, 'AUG': 8,
    'SEP': 9, 'OCT': 10, 'NOV': 11, 'DEC': 12
  };
  Map<String, String> monthMap = {
    'Jan': '01', 'Feb': '02', 'Mar': '03', 'Apr': '04',
    'May': '05', 'Jun': '06', 'Jul': '07', 'Aug': '08',
    'Sep': '09', 'Oct': '10', 'Nov': '11', 'Dec': '12'
  };
  Map<String, int> monthMapping2 = {
    'Jan': 1, 'Feb': 2, 'Mar': 3, 'Apr': 4,
    'May': 5, 'Jun': 6, 'Jul': 7, 'Aug': 8,
    'Sep': 9, 'Oct': 10, 'Nov': 11, 'Dec': 12
  };
  int _getMonthFromAbbreviation(String abbreviation) {
    switch (abbreviation.toLowerCase()) {
      case 'jan':
        return 1;
      case 'feb':
        return 2;
      case 'mar':
        return 3;
      case 'apr':
        return 4;
      case 'may':
        return 5;
      case 'jun':
        return 6;
      case 'jul':
        return 7;
      case 'aug':
        return 8;
      case 'sep':
        return 9;
      case 'oct':
        return 10;
      case 'nov':
        return 11;
      case 'dec':
        return 12;
      default:
        throw FormatException('Invalid month abbreviation: $abbreviation');
    }
}
}
