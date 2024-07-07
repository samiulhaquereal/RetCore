import 'package:retcore/src/config/imports.dart';

class RetCoreShowSnackBar {

  static RetCoreShowSnackBar? _instance;
  RetCoreShowSnackBar._internal();
  factory RetCoreShowSnackBar(){
    _instance ??= RetCoreShowSnackBar._internal();
    return _instance!;
  }

  static show({
    required String content,
    required String title,
    double? contentFontSize,
    double? snackBarPadding,
    double? snackBarHight,
    double? snackBarRadius,
    double? titleFontSize,
    double? spacing,
    Color? titleColor,
    Color? contentColor,
    Color? backgroundColor,
    int? contentMaxLine,
    Duration duration = const Duration(seconds: 3),

  }) {
    BuildContext? context = FindContext.getContext();
    final overlay = Overlay.of(context!, rootOverlay: true);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 10, // Adjust the padding as needed
        left: 10,
        right: 10,
        child: _RetCoreNormalSnackBarContent(
          content: content,
          title: title,
          contentFontSize: contentFontSize,
          snackBarPadding: snackBarPadding,
          snackBarHight: snackBarHight,
          snackBarRadius: snackBarRadius,
          titleFontSize: titleFontSize,
          spacing: spacing,
          titleColor: titleColor,
          contentColor: contentColor,
          contentMaxLine: contentMaxLine,
          backgroundColor: backgroundColor,
        ),
      ),
    );

    overlay?.insert(overlayEntry);

    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }
}


class _RetCoreNormalSnackBarContent extends StatelessWidget {

  const _RetCoreNormalSnackBarContent(
      { super.key,
        required this.content,
        required this.title,
        this.contentFontSize,
        this.snackBarPadding ,
        this.snackBarHight ,
        this.snackBarRadius,
        this.titleFontSize,
        this.titleColor,
        this.spacing,
        this.contentColor,
        this.contentMaxLine,
        this.backgroundColor,
      });

  final String content;
  final String title;
  final double? contentFontSize;
  final double? snackBarPadding;
  final double? snackBarHight;
  final double? snackBarRadius;
  final double? titleFontSize;
  final double? spacing;
  final Color? titleColor;
  final Color? contentColor;
  final Color? backgroundColor;
  final int? contentMaxLine;

  @override
  Widget build(BuildContext context) {
    return /*SlideTransition(
      position: Tween<Offset>(
        begin: Offset(0, -1),
        end: Offset(0, 0),
      ).animate(CurvedAnimation(
        parent: ModalRoute.of(context)!.animation!,
        curve: Curves.fastOutSlowIn,
      )),
      child:*/ RetCoreFadeAnimation(
        customAnimationTransition: RetCoreAnimationStyle.top,
        curves: Curves.fastOutSlowIn,
        child: RetCoreGlassmorphism(
          child: Container(
            padding: EdgeInsets.all(snackBarPadding!),
            height: snackBarHight,
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
      );
  }
}