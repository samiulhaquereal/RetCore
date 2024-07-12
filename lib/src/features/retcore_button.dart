import 'package:retcore/src/config/imports.dart';

class RetCoreButton extends StatelessWidget {
  const RetCoreButton(
      {super.key,
        required this.onTap,
        required this.buttonStyle,
        this.isBorder = false,
        this.height = tButtonHeightSize,
        this.width = tButtonWidthSize,
        this.backgroundColor = tBlack,
        this.backgroundGradientColor1,
        this.backgroundGradientColor2,
        this.title,
        this.icon,
        this.iconWidget,
        this.isPrefixIcon,
        this.isSuffixIcon,
        this.radius = tButtonRadiusSize,
        this.padding = tButtonPaddingSize,
        this.iconSize = tButtonIconSize,
        this.fontSize = tButtonFontSize,
        this.fontWeight,
        this.iconColor = tWhite,
        this.borderColor = tWhite,
        this.iconSpace = tButtonIconSpaceSize,
        this.borderWidth = tButtonBorderWidthSize,
        this.fontColor = tWhite,
        this.prefixIcon,
        this.suffixIcon,
        this.suffixIconWidget,
        this.prefixIconWidget,
      });

  final double? height;
  final double? width;
  final double? radius;
  final double? iconSize;
  final double? fontSize;
  final Color? backgroundColor;
  final Color? backgroundGradientColor1;
  final Color? backgroundGradientColor2;
  final Color? iconColor;
  final Color? fontColor;
  final Color? borderColor;
  final String? title;
  final FontWeight? fontWeight;
  final bool? isPrefixIcon;
  final bool? isSuffixIcon;
  final bool? isBorder;
  final IconData? icon;
  final double? padding;
  final double? borderWidth;
  final double? iconSpace;
  final RetCoreButtonStyle buttonStyle;
  final VoidCallback onTap;
  final Widget? iconWidget;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? suffixIconWidget;
  final Widget? prefixIconWidget;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: buttonStyle == RetCoreButtonStyle.text ? Text(title ?? tClickButton, style: TextStyle(color: fontColor, fontSize: fontSize, fontWeight: fontWeight)) : Container(
        padding: EdgeInsets.all(padding!),
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: isBorder == true ? Border.all(color: borderColor!,width: borderWidth!) : null,
          color: (backgroundGradientColor1 == null || backgroundGradientColor2 == null) ? backgroundColor : null,
          gradient: (backgroundGradientColor1 != null && backgroundGradientColor2 != null)
              ? LinearGradient(colors: [backgroundGradientColor1!, backgroundGradientColor2!])
              : null,
          borderRadius: BorderRadius.circular(radius!),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buttonStyle == RetCoreButtonStyle.vertical ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                prefixIconWidget ?? (prefixIcon != null ? Icon(prefixIcon, color: iconColor,size: iconSize) : const SizedBox()),
                prefixIconWidget != null ? SizedBox(width: iconSpace) : const SizedBox(),
                prefixIcon != null ? SizedBox(width: iconSpace) : const SizedBox(),
                title == null ? icon == null ? const SizedBox() : iconWidget ?? Icon(icon, size: iconSize, color: iconColor) : Text(title!, style: TextStyle(color: fontColor, fontSize: fontSize, fontWeight: fontWeight)),
                suffixIconWidget != null ? SizedBox(width: iconSpace) : const SizedBox(),
                suffixIcon != null ? SizedBox(width: iconSpace) : const SizedBox(),
                suffixIconWidget ?? (suffixIcon != null ? Icon(suffixIcon, color: iconColor, size: iconSize) : const SizedBox()),
              ],
            ) : const SizedBox(),
            buttonStyle == RetCoreButtonStyle.horizontal ? icon == null ? const SizedBox() : iconWidget ?? Icon(icon, size: iconSize, color: iconColor): const SizedBox(),
            SizedBox(height: buttonStyle == RetCoreButtonStyle.horizontal && title != null && icon != null ? iconSpace : tIconSpaceSize),
            buttonStyle == RetCoreButtonStyle.horizontal ? title == null ? const SizedBox() : Text(title!,style: TextStyle(color: fontColor, fontSize: fontSize, fontWeight: fontWeight)) : const SizedBox(),
          ],
        ),
      ),
    );
  }
}