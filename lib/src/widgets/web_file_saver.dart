import 'dart:js' as js;
import 'dart:typed_data' as type;
import 'dart:convert'; // For base64 encoding

class WebFileSaver {
  Future<void> saveFile({
    required type.Uint8List fileResponse,
    required String baseFileName,
    required String extension,
  }) async {
    final base64String = base64Encode(fileResponse); // Convert Uint8List to base64
    final filename = '$baseFileName.$extension';

    // Call the JavaScript function
    js.context.callMethod('downloadFile', [
      base64String,
      filename,
    ]);
  }
}
