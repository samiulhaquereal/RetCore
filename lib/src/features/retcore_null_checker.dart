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
      return (collection.where((element) => element != null).toList() as T);
    } else if (collection is Map) {
      // Create a new map excluding entries with null values
      var cleanedMap = Map.fromEntries(
          collection.entries.where((entry) => entry.value != null)
      );
      return cleanedMap as T;
    } else if (collection is Set) {
      return (collection.where((element) => element != null).toSet() as T);
    } else {
      throw ArgumentError('Unsupported collection type');
    }
  }
}