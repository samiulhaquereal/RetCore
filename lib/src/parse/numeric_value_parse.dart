class RetCoreParse {

  static RetCoreParse? _instance;
  RetCoreParse._internal();
  factory RetCoreParse(){
    _instance ??= RetCoreParse._internal();
    return _instance!;
  }

  int parseInt({required dynamic number, required int defaultValue}) {
    if (number is String) return int.tryParse(number) ?? defaultValue;
    if (number is int) return number;
    if (number is double) return number.toInt();
    return defaultValue;
  }

  double parseDouble({required dynamic number, required double defaultValue}) {
    if (number is String) return double.tryParse(number) ?? defaultValue;
    if (number is int) return number.toDouble();
    if (number is double) return number;
    return defaultValue;
  }

  String parseString({required dynamic value, required String defaultValue}) {
    if (value is String) return value;
    if (value != null) return value.toString();
    return defaultValue;
  }

  bool parseBool({required dynamic value, required bool defaultValue}) {
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

  DateTime parseDateTime({required dynamic value, required DateTime defaultValue}) {
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  List<T> parseList<T>({required dynamic value, required List<T> defaultValue}) {
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
}