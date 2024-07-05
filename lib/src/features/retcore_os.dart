import 'package:retcore/src/config/imports.dart';

class RetCoreOS{

  static RetCoreOS? _instance;
  RetCoreOS._internal();
  factory RetCoreOS(){
    _instance ??= RetCoreOS._internal();
    return _instance!;
  }

  static String getOS() {
    if (kIsWeb) {
      return tPlatform1;
    } else {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          return tPlatform2;
        case TargetPlatform.iOS:
          return tPlatform3;
        case TargetPlatform.windows:
          return tPlatform4;
        case TargetPlatform.linux:
          return tPlatform5;
        case TargetPlatform.macOS:
          return tPlatform6;
        default:
          return tPlatform7;
      }
    }
  }
}