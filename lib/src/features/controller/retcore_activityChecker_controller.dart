import 'dart:developer' as dev;
import 'package:retcore/src/config/imports.dart';

class RetCoreActivityDetectorController {

  static RetCoreActivityDetectorController? _instance;
  RetCoreActivityDetectorController._internal();
  factory RetCoreActivityDetectorController(){
    _instance ??= RetCoreActivityDetectorController._internal();
    return _instance!;
  }

  Timer? _timer;
  Timer? _timer2;
  Duration? _storedTime = const Duration(minutes: 5);
  void Function()? _storedAfterTimeout;

  void startTouchDetection({Duration? time = const Duration(minutes: 5),void Function()? afterTimeout}) {
    dev.log('Time Started');
    // Store the parameters
    _storedTime = time!;
    _storedAfterTimeout = afterTimeout;
    _timer = Timer(time, () => _sessionOut(afterTimeout));
    //_timer = Timer(Duration(hours: 2), _sessionOut);
  }

  void startAutoSession({Duration? time = const Duration(minutes: 4),void Function()? process}) {
    dev.log('Time Started Auto Session');
    _timer2 = Timer(time!, () => _newSession(time,process));
  }


  void resetTimer() {
    _timer?.cancel();
    dev.log('Time Reset');
    startTouchDetection(time: _storedTime, afterTimeout: _storedAfterTimeout);
  }

  void stopActivityDetection(){
    if (_timer != null) {
      _timer?.cancel();
    }else if(_timer2 != null){
      _timer2?.cancel();
    }
  }

  void onClose() {
    _timer?.cancel();
    _timer2?.cancel();
  }

  void _newSession(Duration? time,void Function()? process){
    dev.log('Time End Auto Session');
    try {
      startAutoSession(time: time,process: process);
      if (process != null) {
        process!(); // Call the callback if it's set
      }
    } catch (e) {
      dev.log(e.toString());
    }
  }

  void _sessionOut(void Function()? afterTimeout) {
    dev.log('Time End Activity Detection');
    try {
      if (_timer2 != null) {
        _timer2?.cancel();
      }
      if (afterTimeout != null) {
        afterTimeout!(); // Call the callback if it's set
      }
    } catch (e) {
      dev.log(e.toString());
    }

  }
}