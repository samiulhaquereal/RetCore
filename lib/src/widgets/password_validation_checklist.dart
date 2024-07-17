import 'package:retcore/src/config/imports.dart';

class ValidationCheckList extends StatelessWidget {
  const ValidationCheckList({
    super.key,
    required this.text,
    required this.isValid,
    this.width,
    this.height ,
    this.radius,
    this.iconSize,
    this.validColor,
    this.invalidColor,
    this.validBorderColor,
    this.invalidBorderColor,
    this.validIcon,
    this.invalidIcon,
    this.iconColor,
    this.textColor,
    this.textSize,
    this.textFontWeight,
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
          width: width ?? tValidationCheckListIconWidth,
          height: height ?? tValidationCheckListIconHeight,
          decoration: BoxDecoration(
            color: isValid ? validColor ?? tGreen : invalidColor ?? tRed,
            border: Border.all(color: isValid ? validBorderColor ?? tTransparent : invalidBorderColor ?? tTransparent),
            borderRadius: BorderRadius.circular(radius ?? tValidationCheckListRadius),
          ),
          child: Center(
            child: Icon(
              isValid ? validIcon ?? Icons.check : invalidIcon ?? Icons.close,
              color: iconColor ?? tWhite,
              size: iconSize ?? tValidationCheckListIconSize,
            ),
          ),
        ),
        RetCore.space(10),
        Text(text,style: TextStyle(color: textColor ?? tBlack,fontSize: textSize ?? tValidationCheckListTextSize,fontWeight:textFontWeight ?? FontWeight.w500)),
      ],
    );
  }
}