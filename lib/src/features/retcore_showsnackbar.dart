/*
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
    OverlayState? overlayState = RetCoreNavigatorKey.currentState?.overlay;
    if (overlayState == null) {
      dev.log(tSnackBarContextNotFoundHint);
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
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        suffixIconWidget: suffixIconWidget,
        prefixIconWidget: prefixIconWidget,
        iconColor: iconColor,
        iconSize: iconSize,
        rightIconSpace: rightIconSpace,
        leftIconSpace: leftIconSpace,
        snackBarPosition: snackBarPosition,
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
        top: snackBarPosition == RetCoreSnackBarPosition.top ? MediaQuery.of(context).padding.top + 10 : null,
        left: 10,
        right: 10,
        bottom: snackBarPosition == RetCoreSnackBarPosition.bottom ? MediaQuery.of(context).padding.bottom + 10 : null,
        child: RetCoreFadeAnimation(
          autoReverse: true,
          onDismiss: onDismiss,
          customAnimationTransition: snackBarPosition == RetCoreSnackBarPosition.top ? RetCoreAnimationStyle.top : RetCoreAnimationStyle.bottom ,
          curves: Curves.fastOutSlowIn,
          child: Material(
            color: tTransparent,
            child: RetCoreGlassmorphism(
              blur: 7,
              child: Container(
                padding: EdgeInsets.all(snackBarPadding!),
                //height: snackBarHeight,
                width: RetCore.width(),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.all(
                      Radius.circular(snackBarRadius!),
                  ),
                  border: Border.all(
                    color: backgroundColor == tTransparent ? tGrey.withOpacity(0.3) : tTransparent
                  )

                ),
                child: Row(
                  children: [
                    prefixIconWidget ?? (prefixIcon != null ? Icon(prefixIcon, color: iconColor,size: iconSize) : SizedBox()),
                    prefixIconWidget != null ? SizedBox(width: leftIconSpace) : SizedBox(),
                    prefixIcon != null ? SizedBox(width: leftIconSpace) : SizedBox(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: titleFontSize,
                              color: titleColor,
                              fontWeight: FontWeight.bold
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
                    suffixIconWidget != null ? SizedBox(width: rightIconSpace) : SizedBox(),
                    suffixIcon != null ? SizedBox(width: rightIconSpace) : SizedBox(),
                    suffixIconWidget ?? (suffixIcon != null ? Icon(suffixIcon, color: iconColor,size: iconSize) : SizedBox()),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }
}*/
import 'package:retcore/src/config/imports.dart';
import 'dart:developer' as dev;
import 'dart:collection';

class RetCoreShowSnackBar {

  static RetCoreShowSnackBar? _instance;
  final Queue<Map<String, dynamic>> _snackBarQueue = Queue();
  bool _isShowing = false;

  RetCoreShowSnackBar._internal();
  factory RetCoreShowSnackBar() {
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
    _instance!._snackBarQueue.add({
      'content': content,
      'title': title,
      'contentFontSize': contentFontSize,
      'snackBarPadding': snackBarPadding,
      'snackBarHeight': snackBarHeight,
      'snackBarRadius': snackBarRadius,
      'titleFontSize': titleFontSize,
      'spacing': spacing,
      'titleColor': titleColor,
      'contentColor': contentColor,
      'backgroundColor': backgroundColor,
      'contentMaxLine': contentMaxLine,
      'duration': duration,
      'prefixIcon': prefixIcon,
      'suffixIcon': suffixIcon,
      'suffixIconWidget': suffixIconWidget,
      'prefixIconWidget': prefixIconWidget,
      'iconColor': iconColor,
      'iconSize': iconSize,
      'leftIconSpace': leftIconSpace,
      'rightIconSpace': rightIconSpace,
      'snackBarPosition': snackBarPosition,
    });
    _instance!._showNextSnackBar();
  }

  void _showNextSnackBar() {
    if (_isShowing || _snackBarQueue.isEmpty) {
      return;
    }
    _isShowing = true;

    final snackBarDetails = _snackBarQueue.removeFirst();

    OverlayState? overlayState = RetCoreNavigatorKey.currentState?.overlay;
    if (overlayState == null) {
      dev.log(tSnackBarContextNotFoundHint);
      _isShowing = false;
      return;
    }
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _RetCoreNormalSnackBarContent(
        content: snackBarDetails['content'],
        title: snackBarDetails['title'],
        contentFontSize: snackBarDetails['contentFontSize'],
        snackBarPadding: snackBarDetails['snackBarPadding'],
        snackBarHeight: snackBarDetails['snackBarHeight'],
        snackBarRadius: snackBarDetails['snackBarRadius'],
        titleFontSize: snackBarDetails['titleFontSize'],
        spacing: snackBarDetails['spacing'],
        titleColor: snackBarDetails['titleColor'],
        contentColor: snackBarDetails['contentColor'],
        contentMaxLine: snackBarDetails['contentMaxLine'],
        backgroundColor: snackBarDetails['backgroundColor'],
        prefixIcon: snackBarDetails['prefixIcon'],
        suffixIcon: snackBarDetails['suffixIcon'],
        suffixIconWidget: snackBarDetails['suffixIconWidget'],
        prefixIconWidget: snackBarDetails['prefixIconWidget'],
        iconColor: snackBarDetails['iconColor'],
        iconSize: snackBarDetails['iconSize'],
        rightIconSpace: snackBarDetails['rightIconSpace'],
        leftIconSpace: snackBarDetails['leftIconSpace'],
        snackBarPosition: snackBarDetails['snackBarPosition'],
        onDismiss: () {
          overlayEntry.remove();
          _isShowing = false;
          _showNextSnackBar();
        },
      ),
    );
    overlayState.insert(overlayEntry);
  }
}

class _RetCoreNormalSnackBarContent extends StatelessWidget {

  const _RetCoreNormalSnackBarContent({
    super.key,
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
      top: snackBarPosition == RetCoreSnackBarPosition.top ? MediaQuery.of(context).padding.top + 10 : null,
      left: 10,
      right: 10,
      bottom: snackBarPosition == RetCoreSnackBarPosition.bottom ? MediaQuery.of(context).padding.bottom + 10 : null,
      child: RetCoreFadeAnimation(
        autoReverse: true,
        onDismiss: onDismiss,
        customAnimationTransition: snackBarPosition == RetCoreSnackBarPosition.top ? RetCoreAnimationStyle.top : RetCoreAnimationStyle.bottom,
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
                  color: backgroundColor == tTransparent ? tGrey.withOpacity(0.3) : tTransparent,
                ),
              ),
              child: Row(
                children: [
                  prefixIconWidget ?? (prefixIcon != null ? Icon(prefixIcon, color: iconColor, size: iconSize) : SizedBox()),
                  prefixIconWidget != null ? SizedBox(width: leftIconSpace) : SizedBox(),
                  prefixIcon != null ? SizedBox(width: leftIconSpace) : SizedBox(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: titleFontSize,
                            color: titleColor,
                            fontWeight: FontWeight.bold,
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
                  suffixIconWidget != null ? SizedBox(width: rightIconSpace) : SizedBox(),
                  suffixIcon != null ? SizedBox(width: rightIconSpace) : SizedBox(),
                  suffixIconWidget ?? (suffixIcon != null ? Icon(suffixIcon, color: iconColor, size: iconSize) : SizedBox()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
