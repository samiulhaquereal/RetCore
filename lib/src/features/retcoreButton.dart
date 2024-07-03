import 'package:retcore/src/config/imports.dart';

enum RetCoreButtonStyle{vertical,horizontal,text}

class RetCoreButton extends StatelessWidget {
  RetCoreButton(
      {super.key,
        required this.onTap,
        this.isBorder = false,
        required this.buttonStyle,
        this.height = tButtonHeightSize,
        this.width = tButtonWidthSize,
        this.buttonColor = tBlack,
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
      });

  final double? height;
  final double? width;
  final double? radius;
  final double? iconSize;
  final double? fontSize;
  final Color? buttonColor;
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


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: buttonStyle == RetCoreButtonStyle.text ? Text(title ?? 'Click', style: TextStyle(color: fontColor, fontSize: fontSize, fontWeight: fontWeight)) : Container(
        padding: EdgeInsets.all(padding!),
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: isBorder == true ? Border.all(color: borderColor!,width: borderWidth!) : null,
          color: buttonColor,
          borderRadius: BorderRadius.circular(radius!),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buttonStyle == RetCoreButtonStyle.vertical ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isPrefixIcon == true ? iconWidget ?? Icon(icon, size: iconSize, color: iconColor) : const SizedBox(),
                SizedBox(width: isPrefixIcon == true && icon != null ? iconSpace : 0),
                title == null ? icon == null ? const SizedBox() : iconWidget ?? Icon(icon, size: iconSize, color: iconColor) : Text(title!, style: TextStyle(color: fontColor, fontSize: fontSize, fontWeight: fontWeight)),
                SizedBox(width: isSuffixIcon == true && icon != null ? iconSpace : 0),
                isSuffixIcon == true ? iconWidget ?? Icon(icon, size: iconSize, color: iconColor) : const SizedBox(),
              ],
            ) : const SizedBox(),
            buttonStyle == RetCoreButtonStyle.horizontal ? icon == null ? const SizedBox() : iconWidget ?? Icon(icon, size: iconSize, color: iconColor): const SizedBox(),
            SizedBox(height: buttonStyle == RetCoreButtonStyle.horizontal && title != null && icon != null ? iconSpace : 0),
            buttonStyle == RetCoreButtonStyle.horizontal ? title == null ? const SizedBox() : Text(title!,style: TextStyle(color: fontColor, fontSize: fontSize, fontWeight: fontWeight)) : const SizedBox(),
          ],
        ),
      ),
    );
  }
}