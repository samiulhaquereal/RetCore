import 'package:retcore/src/config/imports.dart';

class RetCoreNeumorphism extends StatelessWidget {
  const RetCoreNeumorphism({
    super.key,
    required this.child,
    this.height = tNeumorphismHeight,
    this.width = tNeumorphismWidth,
    this.color = tNeumorphismBackgroundColor,
    this.radius = tNeumorphismRadius,
    this.blurRadius = tNeumorphismBlurRadius,
    this.topLeftshadowcolor = tWhite,
    this.bottomRightshadowcolor = tNeumorphismBottomRightShadowColor,
    this.bottomRightoffset = tNeumorphismBottomRightOffset,
    this.bottomRightspreadRadius = tNeumorphismbottomRightspreadRadius,
    this.topLeftoffset = tNeumorphismTopLeftOffset,
    this.topLeftspreadRadius = tNeumorphismtopLeftspreadRadius,
  });

  final double? height;
  final double? width;
  final double? radius;
  final double? bottomRightspreadRadius;
  final double? topLeftspreadRadius;
  final double? blurRadius;
  final Color? color;
  final Color? topLeftshadowcolor;
  final Color? bottomRightshadowcolor;
  final Widget child;
  final Offset bottomRightoffset;
  final Offset topLeftoffset;

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
              color: bottomRightshadowcolor!,
              offset: bottomRightoffset,
              blurRadius: blurRadius!,
              spreadRadius: bottomRightspreadRadius!,
            ),
            BoxShadow(
              color: topLeftshadowcolor!,
              offset: topLeftoffset,
              blurRadius: blurRadius!,
              spreadRadius: topLeftspreadRadius!,
            )
          ]
      ),
      child: child,
    );
  }
}