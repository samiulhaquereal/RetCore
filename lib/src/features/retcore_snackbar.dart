import 'package:retcore/src/config/imports.dart';

class RetCoreSnackBar {

  static RetCoreSnackBar? _instance;
  RetCoreSnackBar._internal();
  factory RetCoreSnackBar(){
    _instance ??= RetCoreSnackBar._internal();
    return _instance!;
  }

  static show({
    required String content,
    required String title,
    required RetCoreSnackBarMode mode,
    double? contentFontSize,
    double? snackBarPadding = tSnackBarPaddingSize,
    double? snackBarHight = tSnackBarHightSize,
    double? snackBarRadius = tSnackBarRadiusSize,
    double? leftSpacing = tSnackBarSpaceSize1,
    double? titleFontSize = tSnackBarTitleSize,
    double? spaceing = tSnackBarSpaceSize2,
    double? bubbleIconHeight = tSnackBarBubbleIconHightSize,
    double? bubbleIconWeight = tSnackBarBubbleIconWidthSize,
    double? crossIconSize = tSnackBarFailIconHightSize,
    double? iconSize = tSnackBarLeftIconHightSize,
    Color? titleColor = tWhite,
    Color? contentColor = tWhite,
    int? contentMaxLine = tSnackBarMaxLine,

  }) {
    BuildContext? context = FindContext.getContext();
    if (context != null) {
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
            snackBarPadding:snackBarPadding,
              snackBarHight:snackBarHight,
              snackBarRadius:snackBarRadius,
              leftSpacing:leftSpacing,
              titleFontSize:titleFontSize,
              spaceing:spaceing,
              bubbleIconHeight:bubbleIconHeight,
              bubbleIconWeight:bubbleIconWeight,
              crossIconSize:crossIconSize,
              iconSize:iconSize,
              titleColor:titleColor,
              contentColor:contentColor,
              contentMaxLine:contentMaxLine
          ),
        ),
      );
    }
  }
}

class _RetCoreSnackBarContent extends StatelessWidget {

  const _RetCoreSnackBarContent(
      { super.key,
        required this.content,
        required this.title,
        required this.mode,
        this.contentFontSize,
        this.snackBarPadding ,
        this.snackBarHight ,
        this.snackBarRadius,
        this.leftSpacing ,
        this.titleFontSize,
        this.titleColor,
        this.spaceing,
        this.contentColor,
        this.contentMaxLine,
        this.bubbleIconHeight,
        this.bubbleIconWeight,
        this.crossIconSize,
        this.iconSize,
      });

  final String content;
  final String title;
  final RetCoreSnackBarMode mode;
  final double? contentFontSize;
  final double? snackBarPadding;
  final double? snackBarHight;
  final double? snackBarRadius;
  final double? leftSpacing;
  final double? titleFontSize;
  final double? spaceing;
  final double? bubbleIconHeight;
  final double? bubbleIconWeight;
  final double? crossIconSize;
  final double? iconSize;
  final Color? titleColor;
  final Color? contentColor;
  final int? contentMaxLine;

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
          padding: EdgeInsets.all(snackBarPadding!),
          height: snackBarHight,
          decoration: BoxDecoration(
            color: mode == RetCoreSnackBarMode.success ? tSnackBarSuccessContainerColor : mode == RetCoreSnackBarMode.error ? tSnackBarErrorContainerColor : mode == RetCoreSnackBarMode.alert ? tSnackBarAlertContainerColor : mode == RetCoreSnackBarMode.info ? tSnackBarInfoContainerColor : null,
            borderRadius: BorderRadius.all(Radius.circular(snackBarRadius!)),
          ),
          child: Row(
            children: [
              SizedBox(width: leftSpacing),
              Expanded(
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
                    SizedBox(height: spaceing),
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
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(snackBarRadius!)),
            child: SvgPicture.asset(
              iconData[0],
              height: bubbleIconHeight,
              width: bubbleIconWeight,
              color: mode == RetCoreSnackBarMode.success ? tSnackBarSuccessColor : mode == RetCoreSnackBarMode.error ? tSnackBarErrorColor : mode == RetCoreSnackBarMode.alert ? tSnackBarAlertColor : mode == RetCoreSnackBarMode.info ? tSnackBarInfoColor : null,
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
                height: crossIconSize,
                color: mode == RetCoreSnackBarMode.success ? tSnackBarSuccessColor : mode == RetCoreSnackBarMode.error ? tSnackBarErrorColor : mode == RetCoreSnackBarMode.alert ? tSnackBarAlertColor : mode == RetCoreSnackBarMode.info ? tSnackBarInfoColor : null,
              ),
              Positioned(
                top: 10,
                child: SvgPicture.asset(
                  mode == RetCoreSnackBarMode.success ? iconData[1] : mode == RetCoreSnackBarMode.error ? iconData[2] : mode == RetCoreSnackBarMode.alert ? iconData[3] : mode == RetCoreSnackBarMode.info ? iconData[5] : '',
                  height: iconSize,
                  color: tWhite,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}