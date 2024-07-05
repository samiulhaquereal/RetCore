import 'package:retcore/src/config/imports.dart';

class BottomDialogClass {
  static Future<bool?> showBottomDialog({
    required String title,
    required String content,
    double? boxRadius = tBottomDialogRadius,
    Color? backgroundColor = tBlueGrey,
    double padding = tBottomDialogPadding,
    double? titleSize = tBottomDialogTitleSize,
    double? bottomSpace = tBottomDialogBottomSpace,
    Color? titleColor = tWhite,
    Color? contentFontColor = tWhite,
    Color? buttonColor = tWhite,
    double? buttonFontSize = tBottomDialogButtonFontSize,
    double? contentFontSize = tBottomDialogContentFontSize,
    FontWeight? titleFontWeight = FontWeight.bold,
    FontWeight? contentFontWeight = FontWeight.normal,
    String? dialogBoxConfirmButton = tdialogBox_ConfirmButton,
    String? dialogBoxCancelButton = tdialogBox_CancelButton,
    double? topBarSpace = tBottomDialogTopBarSpace,
    double? barHeight = tBottomDialogBarHeight,
    double? barWidth = tBottomDialogBarWidth,
    double? barRadius = tBottomDialogBarRadius,
    Color? barColor = tWhite,
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
              const SizedBox(height: 20),
              title != null ? const SizedBox(height: 5) : SizedBox(),
              title != null ? Text(
                title,
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: titleFontWeight,
                  color: titleColor,
                ),
              ) : SizedBox(),
              title != null ? const SizedBox(height: 10) : SizedBox(),
              Text(
                content,
                style: TextStyle(fontSize: contentFontSize, color: contentFontColor,fontWeight: contentFontWeight),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      dialogBoxCancelButton!,
                      style: TextStyle(
                        fontSize: buttonFontSize,
                        color: buttonColor,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      dialogBoxConfirmButton!,
                      style: TextStyle(
                        fontSize: buttonFontSize,
                        color: buttonColor,
                      ),
                    ),
                  ),
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
