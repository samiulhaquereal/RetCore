import 'package:retcore/src/config/imports.dart';

class RetCoreAnimation extends StatefulWidget {
  const RetCoreAnimation({
    super.key,
    required this.child,
    required this.customAnimationTransition,
    this.startOffset,
    this.curves = Curves.easeInOut,
    this.endOffset = const Offset(0, 0),
    this.duration = const Duration(milliseconds: 1000),
  });

  final Widget child;
  final Offset? startOffset;
  final Offset? endOffset;
  final Duration? duration;
  final RetCoreAnimationStyle customAnimationTransition;
  final Curve? curves;

  @override
  CustomAnimationState createState() => CustomAnimationState();
}

class CustomAnimationState extends State<RetCoreAnimation> with SingleTickerProviderStateMixin {
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
