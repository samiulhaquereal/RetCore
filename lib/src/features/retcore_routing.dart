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
  static void removeAllTo(Widget page){
    BuildContext? context = FindContext.getContext();
    Navigator.of(context!).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page), (Route<dynamic> route) => false);  // This predicate always returns false, so all previous routes are removed
  }
  static void removeTo(Widget page){
    BuildContext? context = FindContext.getContext();
    Navigator.of(context!).pushReplacement(MaterialPageRoute(builder: (context) => page));
  }
  static double width(){
    BuildContext? context = FindContext.getContext();
    double size = 0.0;
    size = MediaQuery.of(context!).size.width;
    return size;
  }
  static double height(){
    BuildContext? context = FindContext.getContext();
    double size = 0.0;
    size = MediaQuery.of(context!).size.height;
    return size;
  }
  static double infinity(){
    double size = 0.0;
    size = double.infinity;
    return size;
  }

}