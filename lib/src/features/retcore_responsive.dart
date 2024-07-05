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
    return MediaQuery.of(context!).size.width <= 500;
  }

  static bool isMobileLarge() {
    BuildContext? context = FindContext.getContext();
    return MediaQuery.of(context!).size.width <= 700;
  }

  static bool isTablet() {
    BuildContext? context = FindContext.getContext();
    return  MediaQuery.of(context!).size.width < 1024;
  }

  static bool isDesktop() {
    BuildContext? context = FindContext.getContext();
    return  MediaQuery.of(context!).size.width >= 1024;
  }

}