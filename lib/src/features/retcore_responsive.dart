import 'package:retcore/src/config/imports.dart';

class RetCoreResponsive{

  static RetCoreResponsive? _instance;
  RetCoreResponsive._internal();
  factory RetCoreResponsive(){
    _instance ??= RetCoreResponsive._internal();
    return _instance!;
  }

  static bool isMobile() {
    BuildContext? context = FindContext.getContext();
    var width = MediaQuery.of(context!).size.width;
    var orientation = MediaQuery.of(context!).orientation;
    return orientation == Orientation.portrait && width <= 700;
  }

  static bool isTablet() {
    BuildContext? context = FindContext.getContext();
    var width = MediaQuery.of(context!).size.width;
    var orientation = MediaQuery.of(context!).orientation;
    return orientation == Orientation.portrait && width > 700 && width < 1024;
  }

  static bool isDesktop() {
    BuildContext? context = FindContext.getContext();
    var width = MediaQuery.of(context!).size.width;
    return width >= 1024;
  }

}