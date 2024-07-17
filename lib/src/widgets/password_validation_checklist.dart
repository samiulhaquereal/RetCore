import 'package:retcore/src/config/imports.dart';

class ValidationCheckList extends StatelessWidget {
  const ValidationCheckList({
    super.key,
    required this.text,
    required this.isValid,
    this.width = tValidationCheckListIconWidth,
    this.height = tValidationCheckListIconHeight,
    this.radius,
    this.iconSize = tValidationCheckListIconSize,
    this.validColor = tGreen,
    this.invalidColor = tRed,
    this.validBorderColor,
    this.invalidBorderColor,
    this.validIcon = Icons.check,
    this.invalidIcon = Icons.close,
    this.iconColor = tWhite,
    this.textColor = tBlack,
    this.textSize = tValidationCheckListTextSize,
    this.textFontWeight = FontWeight.w500,
  });

  final bool isValid;
  final String text;
  final double? textSize;
  final FontWeight? textFontWeight;
  final double? width;
  final double? height;
  final double? radius;
  final double? iconSize;
  final Color? validColor;
  final Color? invalidColor;
  final Color? validBorderColor;
  final Color? invalidBorderColor;
  final Color? iconColor;
  final Color? textColor;
  final IconData? validIcon;
  final IconData? invalidIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: isValid ? validColor : invalidColor,
            border: Border.all(color: isValid ? validBorderColor ?? tTransparent : invalidBorderColor ?? tTransparent),
            borderRadius: BorderRadius.circular(radius ?? tValidationCheckListRadius),
          ),
          child: Center(
            child: Icon(
              isValid ? validIcon : invalidIcon,
              color: iconColor,
              size: iconSize,
            ),
          ),
        ),
        RetCore.space(10),
        Text(text,style: TextStyle(color: textColor,fontSize: textSize,fontWeight:textFontWeight)),
      ],
    );
  }
}