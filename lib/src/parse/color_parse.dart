import 'package:retcore/src/config/imports.dart';

Color RetCoreparseColor({required String colorCode}) {
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