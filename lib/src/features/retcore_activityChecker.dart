import 'package:retcore/src/config/imports.dart';

class RetCoreActivityDetector extends StatelessWidget {
  RetCoreActivityDetector({super.key,required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent ,
      onPointerMove: (_) {
        //log('Screen tapped Move');
        RetCoreActivityDetectorController().resetTimer();
      },
      onPointerDown: (_) {
        //log('Screen tapped Down');
        RetCoreActivityDetectorController().resetTimer();
      },
      child: child,
    );
  }
}
