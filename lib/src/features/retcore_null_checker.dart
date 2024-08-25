class NullChecker {
  //// Removes null values from a collection.
  ///
  static NullChecker? _instance;
  NullChecker._internal();
  factory NullChecker(){
    _instance ??= NullChecker._internal();
    return _instance!;
  }
  ///
  /// Supports [List], [Map], and [Set].
  /// - For [List], removes any null elements.
  /// - For [Map], removes any entries with null values.
  /// - For [Set], removes any null elements.
  T removeNullValues<T>(T collection) {
    if (collection is List) {
      return collection.where((element) => element != null && element != '').toList() as T;
    } else if (collection is Map) {
      // Correctly filter out null and empty string values from a Map
      Map<String, dynamic> cleanedMap = {};
      collection.forEach((key, value) {
        if (value != null && value != '') {
          cleanedMap[key] = value;
        }
      });
      return cleanedMap as T;
    } else if (collection is Set) {
      return collection.where((element) => element != null && element != '').toSet() as T;
    } else {
      throw ArgumentError('Unsupported collection type');
    }
  }

  T assignIfEmptyOrNull<T>(T? variable, T defaultValue) {
    if (variable == null || (variable is String && variable.isEmpty) || (variable is List && variable.isEmpty)) {
      return defaultValue;
    }
    return variable;
  }


}