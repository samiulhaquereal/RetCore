class RetCoreParse {

  static RetCoreParse? _instance;
  RetCoreParse._internal();
  factory RetCoreParse(){
    _instance ??= RetCoreParse._internal();
    return _instance!;
  }

  static int parseInt({required dynamic number, required int defaultValue}) {
    if (number is String) return int.tryParse(number) ?? defaultValue;
    if (number is int) return number;
    if (number is double) return number.toInt();
    return defaultValue;
  }

  static double parseDouble({required dynamic number, required double defaultValue}) {
    if (number is String) return double.tryParse(number) ?? defaultValue;
    if (number is int) return number.toDouble();
    if (number is double) return number;
    return defaultValue;
  }

  static String parseString({required dynamic value, required String defaultValue}) {
    if (value is String) return value;
    if (value != null) return value.toString();
    return defaultValue;
  }

  static bool parseBool({required dynamic value, required bool defaultValue}) {
    if (value is bool) return value;
    if (value is String) {
      if (value.toLowerCase() == 'true') return true;
      if (value.toLowerCase() == 'false') return false;
    }
    if (value is int) {
      if (value == 1) return true;
      if (value == 0) return false;
    }
    return defaultValue;
  }

  static List<T> parseList<T>({required dynamic value, required List<T> defaultValue}) {
    if (value is List<T>) return value;
    if (value is String) {
      try {
        return List<T>.from(value.split(',').map((e) => e.trim() as T));
      } catch (e) {
        return defaultValue;
      }
    }
    return defaultValue;
  }

  static String formatNumber({required double number, required int decimalPlaces}) {
    if (number == number.toInt()) {
      return number.toInt().toString(); // Remove decimal part if it's .0
    } else {
      // Convert to string but check if it rounds
      String str = number.toString();

      // Split the string at the decimal point
      List<String> parts = str.split('.');

      // If it has a decimal part, return it as is unless it's longer than decimalPlaces
      if (parts.length > 1 && parts[1].length > decimalPlaces) {
        return number.toStringAsFixed(decimalPlaces); // If more than decimalPlaces, format to limit decimal places
      }
      return str; // Otherwise, return as it is
    }
  }

}