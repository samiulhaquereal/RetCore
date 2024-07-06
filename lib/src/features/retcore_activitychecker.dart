import 'dart:developer' as dev;
import 'package:retcore/src/config/imports.dart';

class RetCoreActivityDetector extends StatelessWidget {
  const RetCoreActivityDetector({super.key,required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent ,
      onPointerMove: (_) {
        dev.log('Screen tapped Move');
        RetCoreActivityDetectorController().resetTimer();
      },
      onPointerDown: (_) {
        dev.log('Screen tapped Down');
        RetCoreActivityDetectorController().resetTimer();
      },
      child: child,
    );
  }
}
