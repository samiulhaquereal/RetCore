import 'package:retcore/src/config/imports.dart';
import 'dart:developer' as dev;

class RetCoreShowSnackBar {
  static RetCoreShowSnackBar? _instance;

  RetCoreShowSnackBar._internal();

  factory RetCoreShowSnackBar() {
    _instance ??= RetCoreShowSnackBar._internal();
    return _instance!;
  }

  static final Queue<_SnackBarRequest> _queue = Queue<_SnackBarRequest>();
  static OverlayEntry? _currentOverlayEntry;
  static bool _isShowingSnackBar = false;

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
    IconData? prefixIcon,
    IconData? suffixIcon,
    Widget? suffixIconWidget,
    Widget? prefixIconWidget,
    Color? iconColor,
    double? iconSize,
    double? leftIconSpace,
    double? rightIconSpace,
    RetCoreSnackBarPosition? snackBarPosition,
  }) {
    _queue.add(_SnackBarRequest(
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
      backgroundColor: backgroundColor,
      contentMaxLine: contentMaxLine,
      duration: duration,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      suffixIconWidget: suffixIconWidget,
      prefixIconWidget: prefixIconWidget,
      iconColor: iconColor,
      iconSize: iconSize,
      leftIconSpace: leftIconSpace,
      rightIconSpace: rightIconSpace,
      snackBarPosition: snackBarPosition,
    ));

    _showNextSnackBar();
  }

  static void _showNextSnackBar() {
    if (!_isShowingSnackBar && _queue.isNotEmpty) {
      _isShowingSnackBar = true;

      final request = _queue.removeFirst();

      OverlayState? overlayState = RetCoreNavigatorKey.currentState?.overlay;
      if (overlayState == null) {
        dev.log(tSnackBarContextNotFoundHint);
        _isShowingSnackBar = false;
        return;
      }

      late OverlayEntry overlayEntry;
      overlayEntry = OverlayEntry(
        builder: (context) => _RetCoreNormalSnackBarContent(
          content: request.content,
          title: request.title,
          contentFontSize: request.contentFontSize,
          snackBarPadding: request.snackBarPadding,
          snackBarHeight: request.snackBarHeight,
          snackBarRadius: request.snackBarRadius,
          titleFontSize: request.titleFontSize,
          spacing: request.spacing,
          titleColor: request.titleColor,
          contentColor: request.contentColor,
          contentMaxLine: request.contentMaxLine,
          backgroundColor: request.backgroundColor,
          prefixIcon: request.prefixIcon,
          suffixIcon: request.suffixIcon,
          suffixIconWidget: request.suffixIconWidget,
          prefixIconWidget: request.prefixIconWidget,
          iconColor: request.iconColor,
          iconSize: request.iconSize,
          rightIconSpace: request.rightIconSpace,
          leftIconSpace: request.leftIconSpace,
          snackBarPosition: request.snackBarPosition,
          onDismiss: () {
            overlayEntry.remove();
            _isShowingSnackBar = false;
            _showNextSnackBar();
          },
        ),
      );

      _currentOverlayEntry = overlayEntry;
      overlayState.insert(overlayEntry);
    }
  }
}

class _SnackBarRequest {
  final String content;
  final String title;
  final double? contentFontSize;
  final double? snackBarPadding;
  final double? snackBarHeight;
  final double? snackBarRadius;
  final double? titleFontSize;
  final double? leftIconSpace;
  final double? rightIconSpace;
  final double? spacing;
  final Color? titleColor;
  final Color? contentColor;
  final Color? backgroundColor;
  final int? contentMaxLine;
  final Duration? duration;
  final VoidCallback? onDismiss;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? suffixIconWidget;
  final Widget? prefixIconWidget;
  final Color? iconColor;
  final double? iconSize;
  final RetCoreSnackBarPosition? snackBarPosition;

  _SnackBarRequest({
    required this.content,
    this.duration,
    required this.title,
    this.contentFontSize,
    this.snackBarPadding,
    this.snackBarHeight,
    this.snackBarRadius,
    this.titleFontSize,
    this.titleColor,
    this.spacing,
    this.contentColor,
    this.contentMaxLine,
    this.onDismiss,
    this.backgroundColor,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconWidget,
    this.prefixIconWidget,
    this.iconColor,
    this.iconSize,
    this.leftIconSpace,
    this.rightIconSpace,
    this.snackBarPosition,
  });
}

class _RetCoreNormalSnackBarContent extends StatelessWidget {
  const _RetCoreNormalSnackBarContent({
    Key? key,
    required this.content,
    required this.title,
    this.contentFontSize,
    this.snackBarPadding,
    this.snackBarHeight,
    this.snackBarRadius,
    this.titleFontSize,
    this.titleColor,
    this.spacing,
    this.contentColor,
    this.contentMaxLine,
    this.onDismiss,
    this.backgroundColor,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconWidget,
    this.prefixIconWidget,
    this.iconColor,
    this.iconSize,
    this.leftIconSpace,
    this.rightIconSpace,
    this.snackBarPosition,
  });

  final String content;
  final String title;
  final double? contentFontSize;
  final double? snackBarPadding;
  final double? snackBarHeight;
  final double? snackBarRadius;
  final double? titleFontSize;
  final double? leftIconSpace;
  final double? rightIconSpace;
  final double? spacing;
  final Color? titleColor;
  final Color? contentColor;
  final Color? backgroundColor;
  final int? contentMaxLine;
  final VoidCallback? onDismiss;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? suffixIconWidget;
  final Widget? prefixIconWidget;
  final Color? iconColor;
  final double? iconSize;
  final RetCoreSnackBarPosition? snackBarPosition;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: snackBarPosition == RetCoreSnackBarPosition.top
          ? MediaQuery.of(context).padding.top + 10
          : null,
      left: 10,
      right: 10,
      bottom: snackBarPosition == RetCoreSnackBarPosition.bottom
          ? MediaQuery.of(context).padding.bottom + 10
          : null,
      child: RetCoreFadeAnimation(
        autoReverse: true,
        onDismiss: onDismiss,
        customAnimationTransition: snackBarPosition == RetCoreSnackBarPosition.top
            ? RetCoreAnimationStyle.top
            : RetCoreAnimationStyle.bottom,
        curves: Curves.fastOutSlowIn,
        child: Material(
          color: tTransparent,
          child: RetCoreGlassmorphism(
            blur: 7,
            child: Container(
              padding: EdgeInsets.all(snackBarPadding!),
              width: RetCore.width(),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(snackBarRadius!),
                ),
                border: Border.all(
                  color: backgroundColor == tTransparent
                      ? tGrey.withOpacity(0.3)
                      : tTransparent,
                ),
              ),
              child: Row(
                children: [
                  prefixIconWidget ??
                      (prefixIcon != null
                          ? Icon(prefixIcon, color: iconColor, size: iconSize)
                          : const SizedBox()),
                  prefixIconWidget != null ? SizedBox(width: leftIconSpace) : const SizedBox(),
                  prefixIcon != null ? SizedBox(width: leftIconSpace) : const SizedBox(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: titleFontSize,
                              color: titleColor,
                              fontWeight: FontWeight.bold),
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
                  suffixIconWidget != null ? SizedBox(width: rightIconSpace) : const SizedBox(),
                  suffixIcon != null ? SizedBox(width: rightIconSpace) : const SizedBox(),
                  suffixIconWidget ??
                      (suffixIcon != null
                          ? Icon(suffixIcon, color: iconColor, size: iconSize)
                          : const SizedBox()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

