import 'package:retcore/src/config/imports.dart';

class RetCorePageRoute{

  static RetCorePageRoute? _instance;
  RetCorePageRoute._internal();
  factory RetCorePageRoute(){
    _instance ??= RetCorePageRoute._internal();
    return _instance!;
  }

  static void to(Widget page){
    BuildContext? context = FindContext.getContext();
    Navigator.push(context!,MaterialPageRoute(builder: (context) => page));
  }
  static void back(dynamic result){
    BuildContext? context = FindContext.getContext();
    Navigator.of(context!).pop(result);
  }

}