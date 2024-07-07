import 'package:retcore/src/config/imports.dart';

class RetCoreNeumorphism extends StatelessWidget {
  const RetCoreNeumorphism({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.color = tNeumorphismBackgroundColor,
    this.radius = tNeumorphismRadius,
    this.blurRadius = tNeumorphismBlurRadius,
    this.TopLeftshadowcolor = tWhite,
    this.BottomRightshadowcolor = tNeumorphismBottomRightShadowColor,
  });

  final double? height;
  final double? width;
  final double? radius;
  final double? blurRadius;
  final Color? color;
  final Color? TopLeftshadowcolor;
  final Color? BottomRightshadowcolor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius!),
          boxShadow: [
            BoxShadow(
              color: BottomRightshadowcolor!,
              offset: const Offset(4,4),
              blurRadius: blurRadius!,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: TopLeftshadowcolor!,
              offset: const Offset(-4,-4),
              blurRadius: blurRadius!,
              spreadRadius: 1,
            )
          ]
      ),
      child: child,
    );
  }
}