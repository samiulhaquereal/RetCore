import 'package:retcore/src/config/imports.dart';

class RetCoreBottomSheet {

  static RetCoreBottomSheet? _instance;
  RetCoreBottomSheet._internal();
  factory RetCoreBottomSheet(){
    _instance ??= RetCoreBottomSheet._internal();
    return _instance!;
  }

  static void bottomSheet({
    required Widget child,
    double? boxRadius,
    Color? backgroundColor,
  }) async {
    BuildContext? context = FindContext.getContext();
    return showModalBottomSheet<void>(
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
          child: child,
        );
      },
    );
  }
}
