/*
import 'package:retcore/src/config/imports.dart';
import 'dart:html' as html; // For web support
import 'package:http/http.dart' as http;
import 'dart:typed_data' as type;
import 'dart:io' as io;
import 'dart:developer' as dev;

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
      // Web platform
      final blob = html.Blob([fileResponse]);
      final blobUrl = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: blobUrl)
        ..setAttribute('download', '$baseFileName.$extension')
        ..click();
      html.Url.revokeObjectUrl(blobUrl);
    } else if (io.Platform.isAndroid || io.Platform.isIOS) {
      // Mobile platforms (Android and iOS)
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      PermissionStatus permissionStatus;

      if (io.Platform.isAndroid && androidInfo.version.sdkInt > 29) {
        permissionStatus = await Permission.manageExternalStorage.request();
      } else {
        permissionStatus = await Permission.storage.request();
      }

      if (!permissionStatus.isGranted) {
        if (permissionStatus.isDenied) {
          dev.log("Storage permission denied");
        } else if (permissionStatus.isPermanentlyDenied) {
          dev.log("Storage permission permanently denied");
          openAppSettings();
        }
        return;
      }

      final dir = await getExternalStorageDirectory();
      if (dir == null) throw Exception("Unable to get external storage directory");

      String newPath = '';
      List<String> folders = dir.path.split('/');
      for (int x = 1; x < folders.length; x++) {
        String folder = folders[x];
        if (folder != 'Android') {
          newPath += "/$folder";
        } else {
          break;
        }
      }
      newPath = '$newPath/$appName';
      final newDir = io.Directory(newPath);

      if (!await newDir.exists()) {
        await newDir.create(recursive: true);
      }

      final filePath = '${newDir.path}/$baseFileName.$extension';
      io.File saveFile = io.File(filePath);
      if (await saveFile.exists()) {
        int index = 1;
        String uniqueFileName;
        do {
          uniqueFileName = '$baseFileName($index).$extension';
          index++;
        } while (await io.File('${newDir.path}/$uniqueFileName').exists());
        saveFile = io.File('${newDir.path}/$uniqueFileName');
      }
      await saveFile.writeAsBytes(fileResponse);
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
*/
import 'dart:typed_data' as type;
import 'dart:io' as io;
import 'dart:developer' as dev;

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:retcore/src/widgets/mobile_file_saver.dart' if (dart.library.io) 'package:retcore/src/widgets/web_file_saver.dart';
import 'package:retcore/src/widgets/web_file_saver.dart'; // Conditional imports

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
      await saveFileWeb(fileResponse, baseFileName, extension);
    } else {
      // Mobile-specific implementation
      await saveFileMobile(fileResponse, baseFileName, extension, appName);
    }
  }
}
