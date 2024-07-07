import 'package:retcore/src/config/imports.dart';

class RetCoreBottomDialogBox {

  static Future<bool?> confirm({
    required String content,
    RetCoreBottomDialogBoxButtonStyle? confirmButtonStyle,
    RetCoreBottomDialogBoxButtonStyle? cancelButtonStyle,
    String? title,
    double? boxRadius,
    Color? backgroundColor,
    double? padding,
    double? titleSize,
    double? bottomSpace,
    Color? titleColor ,
    Color? contentFontColor,
    Color? confirmButtonFontColor,
    Color? cancelButtonFontColor,
    double? buttonFontSize ,
    double? contentFontSize,
    FontWeight? titleFontWeight,
    FontWeight? contentFontWeight,
    FontWeight? confirmButtonFontWeight,
    FontWeight? cancelButtonFontWeight ,
    String? dialogBoxConfirmButton,
    String? dialogBoxCancelButton,
    double? topBarSpace,
    double? bottomBarSpace ,
    double? bottomTitleSpace,
    double? bottomContentSpace ,
    double? barHeight ,
    double? barWidth ,
    double? barRadius ,
    double? buttonRadius ,
    Color? barColor,
    Color? buttonColor,
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
            vertical: padding ?? tBottomDialogPadding,
            horizontal: padding ?? tBottomDialogPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              RetCore.space(topBarSpace!),
              Container(
                height: barHeight,
                width: barWidth,
                decoration: BoxDecoration(
                    color: barColor,
                    borderRadius: BorderRadius.all(Radius.circular(barRadius!))
                ),
              ),
              RetCore.space(bottomBarSpace!),
              title != null ? Text(
                title,
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: titleFontWeight,
                  color: titleColor,
                ),
              ) : const SizedBox(),
              title != null ? RetCore.space(bottomTitleSpace!) : const SizedBox(),
              Text(
                content,
                style: TextStyle(fontSize: contentFontSize, color: contentFontColor,fontWeight: contentFontWeight),
              ),
              RetCore.space(bottomContentSpace!),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RetCoreButton(
                      onTap: (){
                        RetCore.back(result: false);
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
                        RetCore.back(result: true);
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
              RetCore.space(bottomSpace!),
            ],
          ),
        );
      },
    );
  }
}
