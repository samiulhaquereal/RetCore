import 'package:retcore/src/config/imports.dart';

enum RetCoreSnackBarMode {
  success,
  error,
  alert,
  info,
}

class RetCoreSnackBar {

  static show(BuildContext context, {required String content, required String title,required RetCoreSnackBarMode mode,double? contentFontSize}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: _RetCoreSnackBarContent(
          content: content,
          title: title,
          mode: mode,
          contentFontSize: contentFontSize,
        ),
      ),
    );
  }
}

class _RetCoreSnackBarContent extends StatelessWidget {

  _RetCoreSnackBarContent(
      { super.key,
        required this.content,
        required this.title,
        required this.mode,
        this.contentFontSize = 12,
      });

  final String content;
  final String title;
  final RetCoreSnackBarMode mode;
  final double? contentFontSize;

  @override
  Widget build(BuildContext context) {
    List<String> iconData = [
      snackbar_icon1,
      snackbar_icon2,
      snackbar_icon3,
      snackbar_icon4,
      snackbar_icon5,
      snackbar_icon6,
    ];
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.all(tSnackBarPaddingSize),
          height: tSnackBarHightSize,
          decoration: BoxDecoration(
            color: mode == RetCoreSnackBarMode.success ? Color(0xFF2D6A4F) : mode == RetCoreSnackBarMode.error ? Color(0xFFC72C41) : mode == RetCoreSnackBarMode.alert ? Color(0xFFFCA652) : mode == RetCoreSnackBarMode.info ? Color(0xFF3282B8) : null,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            children: [
              const SizedBox(width: 48,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        color: tWhite,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      content,
                      style: TextStyle(
                        fontSize: contentFontSize,
                        color: tWhite,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20)),
            child: SvgPicture.asset(
              iconData[0],
              height: 48,
              width: 40,
              color: mode == RetCoreSnackBarMode.success ? Color(0xFF1E4634) : mode == RetCoreSnackBarMode.error ? Color(0xFF801336) : mode == RetCoreSnackBarMode.alert ? Color(0xFFFB8C20) : mode == RetCoreSnackBarMode.info ? Color(0xFF276690) : null,
            ),
          ),
        ),
        Positioned(
          top: -13,
          left: 0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                iconData[4],
                height: 40,
                color: mode == RetCoreSnackBarMode.success ? Color(0xFF1E4634) : mode == RetCoreSnackBarMode.error ? Color(0xFF801336) : mode == RetCoreSnackBarMode.alert ? Color(0xFFFB8C20) : mode == RetCoreSnackBarMode.info ? Color(0xFF276690) : null,
              ),
              Positioned(
                top: 10,
                child: SvgPicture.asset(
                  mode == RetCoreSnackBarMode.success ? iconData[1] : mode == RetCoreSnackBarMode.error ? iconData[2] : mode == RetCoreSnackBarMode.alert ? iconData[3] : mode == RetCoreSnackBarMode.info ? iconData[5] : '',
                  height: 16,
                  color: tWhite,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
