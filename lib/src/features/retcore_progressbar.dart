import 'package:retcore/src/config/imports.dart';

class RetCoreCircularProgressBar extends StatelessWidget {
  const RetCoreCircularProgressBar({
    super.key,
    required this.percentage,
    this.title,
    this.titleFontSize = tCircularProgressBarTitleFontSize,
    this.stroke = tCircularProgressBarStrokeSize,
    this.fontWeight = FontWeight.w600,
    this.animationSpeed = const Duration(seconds: 2),
    this.activeColor = tGreen,
    this.inactiveColor = tGrey,
    this.startingPoint = RetCoreCircularProgressBarStyle.top,
  });

  final double percentage;
  final double? titleFontSize;
  final double? stroke;
  final String? title;
  final FontWeight? fontWeight;
  final Duration? animationSpeed;
  final Color? activeColor;
  final Color? inactiveColor;
  final RetCoreCircularProgressBarStyle? startingPoint;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: percentage),
            duration: animationSpeed!,
            builder: (context, double value, child) => Stack(
              fit: StackFit.expand,
              children: [
                Transform.rotate(
                  angle: startingPoint == RetCoreCircularProgressBarStyle.bottom ? 267 : 0,
                  child: CircularProgressIndicator(
                    strokeWidth: stroke!,
                    value: value,
                    color: activeColor,
                    backgroundColor: inactiveColor,
                  ),
                ),
                Center(
                  child:Text(
                      title ?? '',
                      style: TextStyle(color: tBlack,fontSize:  titleFontSize, fontWeight: fontWeight)
                  ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}