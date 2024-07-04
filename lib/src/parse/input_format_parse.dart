import 'package:retcore/src/config/imports.dart';

TextInputFormatter RetCoreInputType({String? type}) {
  final Map<String, TextInputFormatter> formatters = {
    'text': FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
    'double': FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]')),
    'int': FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
    'email': FilteringTextInputFormatter.allow(
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'),
    ),
    'password': FilteringTextInputFormatter.allow(
      RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>]).+$'),
    ),
  };
  return formatters[type] ?? FilteringTextInputFormatter.deny(RegExp(r'.'));
}