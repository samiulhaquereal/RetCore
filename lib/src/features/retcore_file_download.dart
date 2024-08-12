import 'dart:typed_data' as type;
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:retcore/src/config/imports.dart';
// import 'package:retcore/src/widgets/web_file_saver.dart';

abstract class FileSaver {
  Future<String?> saveFile({
    type.Uint8List? response,
    String? url,
    required String baseFileName,
    required String extension,
    required String folderName,
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
  Future<String?> saveFile({
    type.Uint8List? response,
    String? url,
    required String baseFileName,
    required String extension,
    required String folderName,
  }) async {
    type.Uint8List fileResponse;

    // Fetch data from URL if provided
    if (url != null && url.isNotEmpty) {
      try {
        final httpResponse = await http.get(Uri.parse(url));
        retcoreLogger.info(url, level: 'RESPONSE', method: 'GET', status: '${httpResponse.statusCode}');
        if (httpResponse.statusCode == 200) {
          fileResponse = httpResponse.bodyBytes;
        } else {
          retcoreLogger.error('Failed to download file: ${httpResponse.statusCode}');
          return null;
        }
      } catch (e) {
        retcoreLogger.error('Error downloading file: $e');
        return null;
      }
    } else {
      // Use provided response
      if (response == null) {
        throw ArgumentError("No data provided for the file download.");
      }
      fileResponse = response;
    }

    if (kIsWeb) {
      // Web-specific implementation
      // return await saveFileWeb(fileResponse, baseFileName, extension);
      return null; // Implement this method as needed for web
    } else {
      // Mobile-specific implementation
      String path = await saveFileMobile(fileResponse, baseFileName, extension, folderName) ?? '';
      return path;
    }
  }
}
