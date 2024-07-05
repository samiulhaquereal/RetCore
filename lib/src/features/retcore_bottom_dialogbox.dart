import 'package:retcore/src/config/imports.dart';

class BottomDialogClass {
  static Future<bool?> showBottomDialog({
    double? radius = 15,
    Color? backgroundColor = Colors.blueGrey,
    double padding = 10,
    double? titleSize = 15,
    Color? titleColor = Colors.white,
    Color? messageColor = Colors.white,
    Color? buttonColor = Colors.white,
    double? buttonSize = 14,
    double? messageSize = 14,
    FontWeight? titleFontWeight = FontWeight.bold,
    String? cancelButton = "No",
    String? confirmButton = "Yes",
    required String title,
    required String message,
    required BuildContext context,
  }) async {
    return showModalBottomSheet<bool>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius!),
              topRight: Radius.circular(radius!),
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
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: titleFontWeight,
                  color: titleColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                message,
                style: TextStyle(fontSize: messageSize, color: messageColor),
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
                      cancelButton!,
                      style: TextStyle(
                        fontSize: buttonSize,
                        color: buttonColor,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      confirmButton!,
                      style: TextStyle(
                        fontSize: buttonSize,
                        color: buttonColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
