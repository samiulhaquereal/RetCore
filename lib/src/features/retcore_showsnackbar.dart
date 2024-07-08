import 'package:retcore/src/config/imports.dart';

/*
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
    double contentFontSize = 14.0,
    double snackBarPadding = 16.0,
    double snackBarHeight = 60.0,
    double snackBarRadius = 8.0,
    double titleFontSize = 16.0,
    double spacing = 4.0,
    Color titleColor = Colors.white,
    Color contentColor = Colors.white70,
    Color backgroundColor = Colors.black,
    int contentMaxLine = 2,
    Duration duration = const Duration(seconds: 3),
  }) {
    final BuildContext? context = RetCoreNavigatorKey.currentState?.overlay?.context;

    if (context == null) {
      return;
    }

    final overlay = Overlay.of(context);
    if (overlay == null) {
      return;
    }

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 10,
        left: 10,
        right: 10,
        child: _RetCoreNormalSnackBarContent(
          content: content,
          title: title,
          contentFontSize: contentFontSize,
          snackBarPadding: snackBarPadding,
          snackBarHight: snackBarHeight,
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

    overlay.insert(overlayEntry);

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
    return Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: RetCoreFadeAnimation(
          customAnimationTransition: RetCoreAnimationStyle.top,
          curves: Curves.fastOutSlowIn,
          child: Material(
            color: Colors.transparent,
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
          ),
        ),
      );
  }
}
*/

class RetCoreShowSnackBar {

  static void showCustomSnackbar({
    required String message,
    Duration duration = const Duration(seconds: 3),
    Color backgroundColor = Colors.red,
    TextStyle textStyle = const TextStyle(color: Colors.white, fontSize: 16.0),
  }) {
    OverlayState? overlayState = RetCoreNavigatorKey.currentState?.overlay;
    if (overlayState == null) {
      print('No overlay found. Make sure the MaterialApp uses CustomSnackbarManager.navigatorKey.');
      return;
    }
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => CustomSnackbar(
        message: message,
        onDismiss: () {
          overlayEntry.remove();
        },
        backgroundColor: backgroundColor,
        textStyle: textStyle,
      ),
    );

    overlayState.insert(overlayEntry);

    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }
}

class CustomSnackbar extends StatefulWidget {
  final String message;
  final VoidCallback onDismiss;
  final Color backgroundColor;
  final TextStyle textStyle;

  const CustomSnackbar({
    Key? key,
    required this.message,
    required this.onDismiss,
    required this.backgroundColor,
    required this.textStyle,
  }) : super(key: key);

  @override
  _CustomSnackbarState createState() => _CustomSnackbarState();
}

class _CustomSnackbarState extends State<CustomSnackbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, -1.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();

    Future.delayed(Duration(seconds: 3), () {
      _controller.reverse().then((value) => widget.onDismiss());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Material(
          color: widget.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.message,
              style: widget.textStyle,
            ),
          ),
        ),
      ),
    );
  }
}


