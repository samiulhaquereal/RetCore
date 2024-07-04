import 'dart:developer';
import 'package:retcore/src/config/imports.dart';

class FindContext{

  static FindContext? _instance;
  FindContext._internal();
  factory FindContext(){
    _instance ??= FindContext._internal();
    return _instance!;
  }

  static BuildContext? getContext() {
    // Example: Access context from Navigator or other methods
    // Replace with your own logic to obtain the current BuildContext
    BuildContext? context = RetCoreNavigatorKey.currentContext;
    if (context == null) {
      log('Warning: BuildContext is null.');
    }
    return context;
  }
}