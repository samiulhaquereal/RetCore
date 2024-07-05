import 'package:retcore/src/config/imports.dart';

class RetCoreBottomDialogBox {

  static Future<bool?> confirm({
    required String content,
    RetCoreBottomDialogBoxButtonStyle? confirmButtonStyle,
    RetCoreBottomDialogBoxButtonStyle? cancelButtonStyle,
    String? title,
    double? boxRadius = tBottomDialogRadius,
    Color? backgroundColor = tBlueGrey,
    double padding = tBottomDialogPadding,
    double? titleSize = tBottomDialogTitleSize,
    double? bottomSpace = tBottomDialogBottomSpace,
    Color? titleColor = tWhite,
    Color? contentFontColor = tWhite,
    Color? confirmButtonFontColor = tBlack,
    Color? cancelButtonFontColor = tWhite,
    double? buttonFontSize = tBottomDialogButtonFontSize,
    double? contentFontSize = tBottomDialogContentFontSize,
    FontWeight? titleFontWeight = FontWeight.bold,
    FontWeight? contentFontWeight = FontWeight.normal,
    FontWeight? confirmButtonFontWeight = FontWeight.normal,
    FontWeight? cancelButtonFontWeight = FontWeight.normal,
    String? dialogBoxConfirmButton = tdialogBox_ConfirmButton,
    String? dialogBoxCancelButton = tdialogBox_CancelButton,
    double? topBarSpace = tBottomDialogTopBarSpace,
    double? bottomBarSpace = tBottomDialogBottomBarSpace,
    double? bottomTitleSpace = tBottomDialogBottomTitleSpace,
    double? bottomContentSpace = tBottomDialogBottomContentSpace,
    double? barHeight = tBottomDialogBarHeight,
    double? barWidth = tBottomDialogBarWidth,
    double? barRadius = tBottomDialogBarRadius,
    double? buttonRadius = tBottomDialogButtonRadius,
    Color? barColor = tWhite,
    Color? buttonColor = tWhite,
  }) async {
    BuildContext? context = FindContext.getContext();
    return showModalBottomSheet<bool>(
      context: context!,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(boxRadius!),
              topRight: Radius.circular(boxRadius!),
            ),
            color: backgroundColor,
          ),
          padding: EdgeInsets.symmetric(
            vertical: padding,
            horizontal: padding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: topBarSpace),
              Container(
                height: barHeight,
                width: barWidth,
                decoration: BoxDecoration(
                    color: barColor,
                    borderRadius: BorderRadius.all(Radius.circular(barRadius!))
                ),
              ),
              SizedBox(height: bottomBarSpace),
              title != null ? Text(
                title,
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: titleFontWeight,
                  color: titleColor,
                ),
              ) : const SizedBox(),
              title != null ? SizedBox(height: bottomTitleSpace) : const SizedBox(),
              Text(
                content,
                style: TextStyle(fontSize: contentFontSize, color: contentFontColor,fontWeight: contentFontWeight),
              ),
              SizedBox(height: bottomContentSpace),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RetCoreButton(
                      onTap: (){
                        Navigator.of(context).pop(false);
                      },
                      buttonStyle: cancelButtonStyle == RetCoreBottomDialogBoxButtonStyle.withBackground ? RetCoreButtonStyle.vertical : RetCoreButtonStyle.text,
                      radius: buttonRadius,
                      backgroundColor: buttonColor,
                      title: dialogBoxCancelButton,
                      fontSize: buttonFontSize,
                      fontColor: cancelButtonFontColor,
                      fontWeight: cancelButtonFontWeight,
                  ),
                  RetCoreButton(
                      onTap: (){
                        Navigator.of(context).pop(true);
                      },
                      buttonStyle: confirmButtonStyle == RetCoreBottomDialogBoxButtonStyle.text ? RetCoreButtonStyle.text : RetCoreButtonStyle.vertical,
                      radius: buttonRadius,
                      backgroundColor: buttonColor,
                      title: dialogBoxConfirmButton,
                      fontSize: buttonFontSize,
                      fontColor: confirmButtonFontColor,
                      fontWeight: confirmButtonFontWeight,
                  )
                ],
              ),
              SizedBox(height: bottomSpace),
            ],
          ),
        );
      },
    );
  }
}
