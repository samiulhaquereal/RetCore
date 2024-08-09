import 'dart:io' as io;
import 'dart:typed_data' as type;
import 'dart:developer' as dev;
import 'package:retcore/src/config/imports.dart';



Future<void> saveFileMobile(type.Uint8List fileResponse, String baseFileName, String extension, String appName) async {
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
}
