import 'dart:typed_data' as type;
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:retcore/src/config/imports.dart';
//import 'package:retcore/src/widgets/web_file_saver.dart';

abstract class FileSaver {
  Future<void> saveFile({
    type.Uint8List? response,
    String? url,
    required String baseFileName,
    required String extension,
    required String appName,
  });
}

class FileDownload implements FileSaver {
  static FileDownload? _instance;

  FileDownload._internal();
  factory FileDownload() {
    _instance ??= FileDownload._internal();
    return _instance!;
  }

  @override
  Future<void> saveFile({
    type.Uint8List? response,
    String? url,
    required String baseFileName,
    required String extension,
    required String appName,
  }) async {
    type.Uint8List fileResponse;

    // Fetch data from URL if provided
    if (url != null && url.isNotEmpty) {
      try {
        final httpResponse = await http.get(Uri.parse(url));
        if (httpResponse.statusCode == 200) {
          fileResponse = httpResponse.bodyBytes;
        } else {
          dev.log("Failed to download file from URL. Status code: ${httpResponse.statusCode}");
          return;
        }
      } catch (e) {
        dev.log("Error fetching file from URL: $e");
        return;
      }
    } else {
      // Use provided response
      if (response == null) {
        throw ArgumentError("Either 'response' or 'url' must be provided.");
      }
      fileResponse = response;
    }

    if (kIsWeb) {
      // Web-specific implementation
      //await saveFileWeb(fileResponse, baseFileName, extension);
    } else {
      // Mobile-specific implementation
      await saveFileMobile(fileResponse, baseFileName, extension, appName);
    }
  }
}
