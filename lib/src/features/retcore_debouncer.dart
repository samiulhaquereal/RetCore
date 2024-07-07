import 'package:retcore/src/config/imports.dart';

class RetCoreDebouncer {

  static RetCoreDebouncer? _instance;
  RetCoreDebouncer._internal();
  factory RetCoreDebouncer(){
    _instance ??= RetCoreDebouncer._internal();
    return _instance!;
  }

  static Timer? _timer;

  static void run({required VoidCallback action,int? milliseconds}) {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds!), action);
  }
}