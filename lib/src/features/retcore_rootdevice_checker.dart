import 'dart:developer';
import 'package:retcore/src/config/imports.dart';

class RetCoreRootDeviceChecker {

  static RetCoreRootDeviceChecker? _instance;
  RetCoreRootDeviceChecker._internal();
  factory RetCoreRootDeviceChecker(){
    _instance ??= RetCoreRootDeviceChecker._internal();
    return _instance!;
  }

  Future<bool> getDetails() async {
    bool isRooted = false;
    String device = RetCoreOS.getOS();
    device == tPlatform2 ? isRooted = await _checkAndroidRoot() : isRooted = await _isJailbroken();
    return isRooted;
  }

  Future<bool> _checkAndroidRoot() async {
    bool isRooted = false;
    try {
      List<String> rootIndicatorsList = [
        '/sbin/su',
        '/system/bin/su',
        '/system/xbin/su',
        '/data/local/xbin/su',
        '/data/local/bin/su',
        '/system/sd/xbin/su',
        '/system/bin/failsafe/su',
        '/data/local/su',
        '/system/app/Superuser.apk',
        '/system/app/SuperSU.apk',
        '/system/app/BusyBox.apk',
        '/system/etc/init.d/99SuperSUDaemon',
        '/dev/com.koushikdutta.superuser.daemon/',
        '/system/xbin/daemonsu',
        '/system/xbin/busybox'
      ];

      for (String indicator in rootIndicatorsList) {
        if (await File(indicator).exists()) {
          isRooted = true;
          break;
        }
      }
    } catch (e) {
      log('Error checking root status: $e');
    }
    return isRooted;
  }

  Future<bool> _isJailbroken() async {
    bool jailbroken = false;
    List<String> jailbrokenPaths = [
      '/Applications/Cydia.app',
      '/Library/MobileSubstrate/MobileSubstrate.dylib',
      '/bin/bash',
      '/usr/sbin/sshd',
      '/etc/apt'
    ];

    for (String path in jailbrokenPaths) {
      if (await File(path).exists()) {
        jailbroken = true;
        break;
      }
    }
    return jailbroken;
  }

}