import 'package:retcore/src/config/imports.dart';
import 'dart:developer' as dev;

class RetCoreFadeAnimation extends StatefulWidget {
  const RetCoreFadeAnimation({
    super.key,
    required this.child,
    required this.customAnimationTransition,
    this.startOffset,
    this.curves = Curves.easeInOut,
    this.autoReverse = false,
    this.endOffset = const Offset(0, 0),
    this.duration = const Duration(milliseconds: 1000),
    this.autoReverseDuration = const Duration(seconds: 3),
    VoidCallback? onDismiss,
  })  : this.onDismiss = onDismiss ?? _defaultOnDismiss;

  final Widget child;
  final Offset? startOffset;
  final Offset? endOffset;
  final Duration? duration;
  final Duration? autoReverseDuration;
  final RetCoreAnimationStyle customAnimationTransition;
  final Curve? curves;
  final bool? autoReverse;
  final VoidCallback? onDismiss ;

  @override
  CustomAnimationState createState() => CustomAnimationState();

  static void _defaultOnDismiss() {
    dev.log('Auto reverse animation is activate');
  }
}

class CustomAnimationState extends State<RetCoreFadeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration!,
      vsync: this,
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curves!,
    ));

    _animation = Tween<Offset>(
      begin: {
        RetCoreAnimationStyle.right: const Offset(1, 0),
        RetCoreAnimationStyle.bottom: const Offset(0, 1),
        RetCoreAnimationStyle.left: const Offset(-1, 0),
        RetCoreAnimationStyle.top: const Offset(0, -1),
      }[widget.customAnimationTransition] ?? widget.startOffset,
      end: widget.endOffset!,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curves!,
    ));

    // Start the animation
    _controller.forward();

    if(widget.autoReverse == true){
      Future.delayed( widget.autoReverseDuration!, () {
        _controller.reverse().then((value) => widget.onDismiss!());
      });
    }

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void forward() {
    _controller.forward();
  }

  void reverse() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: FadeTransition(
        opacity: _opacity,
        child: widget.child,
      ),
    );
  }
}
