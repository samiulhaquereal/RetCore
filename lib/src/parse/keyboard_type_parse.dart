import 'package:retcore/src/config/imports.dart';

class RetCoreKeyboardTypeParse{

  static RetCoreKeyboardTypeParse? _instance;
  RetCoreKeyboardTypeParse._internal();
  factory RetCoreKeyboardTypeParse(){
    _instance ??= RetCoreKeyboardTypeParse._internal();
    return _instance!;
  }

  static TextInputType InputType({RetCoreKeyboardType? type}) {
    final Map<String, TextInputType> keyboardTypes = {
      'text': TextInputType.text,
      'number': TextInputType.number,
      'phone': TextInputType.phone,
      'datetime': TextInputType.datetime,
      'multiline': TextInputType.multiline,
      'email': TextInputType.emailAddress,
      'url': TextInputType.url,
      'visible-password': TextInputType.visiblePassword,
      'name': TextInputType.name,
      'street-address': TextInputType.streetAddress,
      'none': TextInputType.none,
      'phoneNumber': TextInputType.phone,
      'signedNumber': const TextInputType.numberWithOptions(signed: true),
      'decimalNumber': const TextInputType.numberWithOptions(decimal: true),
      'decimal': const TextInputType.numberWithOptions(decimal: true),
      'textUri': TextInputType.text,
      'numberUri': TextInputType.number,
    };

    return keyboardTypes[type?.toString().split('.').last] ?? TextInputType.text;
  }
}


