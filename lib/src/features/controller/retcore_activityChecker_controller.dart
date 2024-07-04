import 'dart:developer';
import 'package:retcore/src/config/imports.dart';

class RetCoreActivityDetectorController {

  static RetCoreActivityDetectorController? _instance;
  RetCoreActivityDetectorController._internal();
  factory RetCoreActivityDetectorController(){
    _instance ??= RetCoreActivityDetectorController._internal();
    return _instance!;
  }

  late Timer _timer;
  late Timer _timer2;
  Duration? _storedTime;
  void Function()? _storedAfterTimeout;

  void startTouchDetection({Duration? time = const Duration(minutes: 5),void Function()? afterTimeout}) {
    //log('Time Started');
    // Store the parameters
    _storedTime = time!;
    _storedAfterTimeout = afterTimeout;
    _timer = Timer(time!, () => _sessionOut(afterTimeout));
    //_timer = Timer(Duration(hours: 2), _sessionOut);
  }

  void startAutoSession({Duration? time = const Duration(minutes: 4),void Function()? process}) {
    //print('Time Started New Session');
    _timer2 = Timer(time!, () => _newSession(time,process));
  }


  void resetTimer() {
    _timer.cancel();
    //log('Time Reset');
    startTouchDetection(time: _storedTime, afterTimeout: _storedAfterTimeout);
  }

  void stopActivityDetection(){
    if (_timer != null && _timer2 != null) {
      _timer.cancel();
      _timer2.cancel();
    }
  }

  void onClose() {
    _timer.cancel();
    _timer2.cancel();
  }

  void _newSession(Duration? time,void Function()? process){
    //print('Time End New Session');
    try {
      startAutoSession(time: time,process: process);
      if (process != null) {
        process!(); // Call the callback if it's set
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void _sessionOut(void Function()? afterTimeout) {
    //print('Time End');
    try {
      _timer2.cancel();
      if (afterTimeout != null) {
        afterTimeout!(); // Call the callback if it's set
      }
    } catch (e) {
      log(e.toString());
    }

  }
}