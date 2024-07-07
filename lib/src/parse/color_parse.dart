import 'package:retcore/src/config/imports.dart';

class RetCoreParseColor {

  static RetCoreParseColor? _instance;
  RetCoreParseColor._internal();
  factory RetCoreParseColor(){
    _instance ??= RetCoreParseColor._internal();
    return _instance!;
  }

  static Color RetCoreColor({required String colorCode}) {
    // Check if the color code starts with #
    if (colorCode.startsWith('#')) {
      // Remove # symbol from the color code
      colorCode = colorCode.substring(1);
    }

    // Add alpha value (fully opaque)
    colorCode = 'FF' + colorCode;

    // Parse the color code to a hexadecimal integer
    int colorValue = int.parse(colorCode, radix: 16);

    // Return the Color object
    return Color(colorValue);
  }
}