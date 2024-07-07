import 'package:retcore/src/config/imports.dart';

class RetCore{

  static RetCore? _instance;
  RetCore._internal();
  factory RetCore(){
    _instance ??= RetCore._internal();
    return _instance!;
  }

  static void to(Widget page){
    RetCorePageRoute.to(page);
  }
  static void back(dynamic result){
    RetCorePageRoute.back(result);
  }
  static double width(){
    double size = RetCorePageRoute.width();
    return size;
  }
  static double height(){
    double size = RetCorePageRoute.height();
    return size;
  }
  static double infinity(){
    double size = RetCorePageRoute.infinity();
    return size;
  }
  static void space(double size){
    RetcoreSpace(size:size);
  }
  static int parseInt({required dynamic number, required int defaultValue}){
    int value = RetCoreParse.parseInt(number: number, defaultValue: defaultValue);
    return value;
  }
  static double parseDouble({required dynamic number, required double defaultValue}){
    double value = RetCoreParse.parseDouble(number: number, defaultValue: defaultValue);
    return value;
  }
  static String parseString({required dynamic value, required String defaultValue}){
    String response = RetCoreParse.parseString(value: value, defaultValue: defaultValue);
    return response;
  }
  static bool parseBool({required dynamic value, required bool defaultValue}){
    bool response = RetCoreParse.parseBool(value: value, defaultValue: defaultValue);
    return response;
  }
  static DateTime parseDateTime({required dynamic value, required DateTime defaultValue}){
    DateTime response = RetCoreParse.parseDateTime(value: value, defaultValue: defaultValue);
    return response;
  }
  static List<T> parseList<T>({required dynamic value, required List<T> defaultValue}){
    List<T> response = RetCoreParse.parseList(value: value, defaultValue: defaultValue);
    return response;
  }
  static Color parseColor({required String colorCode}){
    Color value = RetCoreParseColor.RetCoreColor(colorCode: colorCode);
    return value;
  }
  static TextInputFormatter parseInputType({required RetCoreInputType? type}){
    TextInputFormatter value = RetCoreInputTypeParse.InputType(type: type);
    return value;
  }
  static TextInputType parseKeyboardType({required RetCoreKeyboardType? type}){
    TextInputType value = RetCoreKeyboardTypeParse.InputType(type: type);
    return value;
  }

}