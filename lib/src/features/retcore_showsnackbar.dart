import 'package:retcore/src/config/imports.dart';
import 'dart:developer' as dev;
class RetCoreShowSnackBar {

  static RetCoreShowSnackBar? _instance;

  RetCoreShowSnackBar._internal();
  factory RetCoreShowSnackBar(){
    _instance ??= RetCoreShowSnackBar._internal();
    return _instance!;
  }

  static void show({
    required String content,
    required String title,
    double? contentFontSize,
    double? snackBarPadding,
    double? snackBarHeight,
    double? snackBarRadius,
    double? titleFontSize,
    double? spacing,
    Color? titleColor,
    Color? contentColor,
    Color? backgroundColor,
    int? contentMaxLine,
    Duration? duration,
  }) {
    OverlayState? overlayState = RetCoreNavigatorKey.currentState?.overlay;
    if (overlayState == null) {
      dev.log('No overlay found. Make sure the MaterialApp uses CustomSnackbarManager.navigatorKey.');
      return;
    }
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _RetCoreNormalSnackBarContent(
        content: content,
        title: title,
        contentFontSize: contentFontSize,
        snackBarPadding: snackBarPadding,
        snackBarHeight: snackBarHeight,
        snackBarRadius: snackBarRadius,
        titleFontSize: titleFontSize,
        spacing: spacing,
        titleColor: titleColor,
        contentColor: contentColor,
        contentMaxLine: contentMaxLine,
        backgroundColor: backgroundColor,
        onDismiss: (){
          overlayEntry.remove();
        },
      ),
    );
    overlayState.insert(overlayEntry);
  }
}

class _RetCoreNormalSnackBarContent extends StatelessWidget {

  const _RetCoreNormalSnackBarContent(
      { super.key,
        required this.content,
        required this.title,
        this.contentFontSize,
        this.snackBarPadding ,
        this.snackBarHeight ,
        this.snackBarRadius,
        this.titleFontSize,
        this.titleColor,
        this.spacing,
        this.contentColor,
        this.contentMaxLine,
        this.onDismiss,
        this.backgroundColor,
      });

  final String content;
  final String title;
  final double? contentFontSize;
  final double? snackBarPadding;
  final double? snackBarHeight;
  final double? snackBarRadius;
  final double? titleFontSize;
  final double? spacing;
  final Color? titleColor;
  final Color? contentColor;
  final Color? backgroundColor;
  final int? contentMaxLine;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: MediaQuery.of(context).padding.top + 10,
        left: 10,
        right: 10,
        child: RetCoreFadeAnimation(
          autoReverse: true,
          onDismiss: onDismiss,
          customAnimationTransition: RetCoreAnimationStyle.top,
          curves: Curves.fastOutSlowIn,
          child: Material(
            color: tTransparent,
            child: RetCoreGlassmorphism(
              blur: 8,
              borderColor: backgroundColor == tTransparent ? Colors.grey.withOpacity(0.2) : tTransparent,
              child: Container(
                padding: EdgeInsets.all(snackBarPadding!),
                height: snackBarHeight,
                width: RetCore.width(),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(snackBarRadius!)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: titleFontSize,
                        color: titleColor,
                      ),
                    ),
                    RetCore.space(spacing!),
                    Text(
                      content,
                      style: TextStyle(
                        fontSize: contentFontSize,
                        color: contentColor,
                      ),
                      maxLines: contentMaxLine,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }
}