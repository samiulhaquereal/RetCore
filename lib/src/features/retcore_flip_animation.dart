import 'package:retcore/src/config/imports.dart';

class RetCoreFlipAnimation extends StatefulWidget {
  const RetCoreFlipAnimation({
    super.key,
    required this.firstPage,
    required this.secondPage,
    this.flipOnTouch = true,
    this.curves = Curves.easeInOut,
    this.duration = const Duration(milliseconds: 800),
  });

  final Widget firstPage;
  final Widget secondPage;
  final bool? flipOnTouch;
  final Curve? curves;
  final Duration? duration;

  @override
  State<RetCoreFlipAnimation> createState() => _FlipAnimationState();
}

class _FlipAnimationState extends State<RetCoreFlipAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFront = true;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration!,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curves!,
    );
    super.initState();
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

  void _toggleCard() {
    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {
      _isFront = !_isFront;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.flipOnTouch!) {
          _toggleCard();
        }
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value * pi;
          final isUnder = (angle > pi / 2.0);
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0015)
              ..rotateY(angle),
            child: isUnder
                ? Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi),
              child: widget.secondPage,
            )
                : widget.firstPage,
          );
        },
      ),
    );
  }
}