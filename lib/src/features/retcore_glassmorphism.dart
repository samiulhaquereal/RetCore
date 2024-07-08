import 'dart:ui';
import 'package:retcore/src/config/imports.dart';

class RetCoreGlassmorphism extends StatelessWidget {

  final double? blur;
  final double? opacity;
  final Widget child;
  final double? borderRadius;
  final double? borderWidth;
  final Color? borderColor;
  final Color? background;

  const RetCoreGlassmorphism({
    super.key,
    required this.child,
    this.blur = tGlassmorphismBlur,
    this.opacity = tGlassmorphismOpacity,
    this.borderRadius = tGlassmorphismRadius,
    this.borderWidth = tGlassmorphismBorderWidth,
    this.background = tTransparent,
    this.borderColor = tGrey,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius!),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur!,sigmaY: blur!),
        child: Container(
          decoration: BoxDecoration(
            color: background!.withOpacity(opacity!),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius!)),
            border: Border.all(
              width: borderWidth!,
              color: borderColor!.withOpacity(opacity!),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}