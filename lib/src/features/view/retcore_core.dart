import 'package:intl/intl.dart';
import 'package:retcore/src/config/imports.dart';


class RetCore{

  static RetCore? _instance;
  RetCore._internal();
  factory RetCore(){
    _instance ??= RetCore._internal();
    return _instance!;
  }

  static void to(Widget page){
    RetCorePageRoute.to(page);
  }
  static void back({dynamic result}){
    RetCorePageRoute.back(result);
  }
  static double width(){
    double size = RetCorePageRoute.width();
    return size;
  }
  static double height(){
    double size = RetCorePageRoute.height();
    return size;
  }
  static double infinity(){
    double size = RetCorePageRoute.infinity();
    return size;
  }
  static String now(){
    String isoFormattedDateTime = RetCoreDateTimeParse.CurrentTime();
    return isoFormattedDateTime;
  }
  static Widget space(double size){
    return RetcoreSpace(space: size);
  }
  static int parseInt({required dynamic number, required int defaultValue}){
    int value = RetCoreParse.parseInt(number: number, defaultValue: defaultValue);
    return value;
  }
  static double parseDouble({required dynamic number, required double defaultValue}){
    double value = RetCoreParse.parseDouble(number: number, defaultValue: defaultValue);
    return value;
  }
  static String parseString({required dynamic value, required String defaultValue}){
    String response = RetCoreParse.parseString(value: value, defaultValue: defaultValue);
    return response;
  }
  static bool parseBool({required dynamic value, required bool defaultValue}){
    bool response = RetCoreParse.parseBool(value: value, defaultValue: defaultValue);
    return response;
  }
  static String parseDateTime({required dynamic value, required DateTime defaultValue}){
    String? response = RetCoreDateTimeParse().parseDateTime(input: value);
    return response ?? defaultValue.toString();
  }
  static List<T> parseList<T>({required dynamic value, required List<T> defaultValue}){
    List<T> response = RetCoreParse.parseList(value: value, defaultValue: defaultValue);
    return response;
  }
  static Color parseColor({required String colorCode}){
    Color value = RetCoreParseColor.RetCoreColor(colorCode: colorCode);
    return value;
  }
  static TextInputFormatter parseInputType({required RetCoreInputType? type}){
    TextInputFormatter value = RetCoreInputTypeParse.InputType(type: type);
    return value;
  }
  static TextInputType parseKeyboardType({required RetCoreKeyboardType? type}){
    TextInputType value = RetCoreKeyboardTypeParse.InputType(type: type);
    return value;
  }
  static void showSnackbar({
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
        }){
          RetCoreSnackBar.show(
              content : content,
              title : title,
              mode : mode,
              contentFontSize : contentFontSize,
              snackBarPadding : snackBarPadding,
              snackBarHight : snackBarHight,
              snackBarRadius : snackBarRadius,
              leftSpacing : leftSpacing,
              titleFontSize : titleFontSize,
              spaceing : spaceing,
              bubbleIconHeight : bubbleIconHeight,
              bubbleIconWeight : bubbleIconWeight,
              crossIconSize : crossIconSize,
              iconSize : iconSize,
              titleColor : titleColor,
              contentColor : contentColor,
              contentMaxLine : contentMaxLine,
          );
  }

  static void snackbar({
    required String content,
    required String title,
    double? contentFontSize,
    double? snackBarPadding = tSnackBarPaddingSize,
    double? snackBarHeight = tSnackBarHightSize,
    double? snackBarRadius = tSnackBarRadiusSize,
    double? titleFontSize = tSnackBarTitleSize,
    double? spaceing = tSnackBarSpaceSize2,
    Color? titleColor = tBlack,
    Color? contentColor = tBlack,
    Color? backgroundColor = tTransparent,
    int? contentMaxLine = tSnackBarMaxLine,
    Duration? duration = const Duration(seconds: 3),
    IconData? prefixIcon,
    IconData? suffixIcon,
    Widget? suffixIconWidget,
    Widget? prefixIconWidget,
    Color? iconColor = tBlack,
    double? iconSize,
    double? leftIconSpace = tSnackbarleftIconSpace,
    double? rightIconSpace = tSnackbarrightIconSpace,
    RetCoreSnackBarPosition? snackBarPosition = RetCoreSnackBarPosition.top,
  }){
    RetCoreShowSnackBar.show(
      content : content,
      title : title,
      contentFontSize : contentFontSize,
      snackBarPadding : snackBarPadding,
      snackBarHeight : snackBarHeight,
      snackBarRadius : snackBarRadius,
      titleFontSize : titleFontSize,
      spacing : spaceing,
      titleColor : titleColor,
      contentColor : contentColor,
      contentMaxLine : contentMaxLine,
      backgroundColor: backgroundColor,
      duration: duration,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      suffixIconWidget: suffixIconWidget,
      prefixIconWidget: prefixIconWidget,
      iconColor: iconColor,
      iconSize: iconSize,
      rightIconSpace: rightIconSpace,
      leftIconSpace: leftIconSpace,
      snackBarPosition: snackBarPosition,
    );
  }

  static Future<bool> bottomDialogBox({
    required String content,
    RetCoreBottomDialogBoxButtonStyle? confirmButtonStyle,
    RetCoreBottomDialogBoxButtonStyle? cancelButtonStyle,
    String? title,
    double? boxRadius = tBottomDialogRadius,
    Color? backgroundColor = tBlueGrey,
    double padding = tBottomDialogPadding,
    double? titleSize = tBottomDialogTitleSize,
    double? bottomSpace = tBottomDialogBottomSpace,
    Color? titleColor = tWhite,
    Color? contentFontColor = tWhite,
    Color? confirmButtonFontColor = tBlack,
    Color? cancelButtonFontColor = tWhite,
    double? buttonFontSize = tBottomDialogButtonFontSize,
    double? contentFontSize = tBottomDialogContentFontSize,
    FontWeight? titleFontWeight = FontWeight.bold,
    FontWeight? contentFontWeight = FontWeight.normal,
    FontWeight? confirmButtonFontWeight = FontWeight.normal,
    FontWeight? cancelButtonFontWeight = FontWeight.normal,
    String? dialogBoxConfirmButton = tdialogBox_ConfirmButton,
    String? dialogBoxCancelButton = tdialogBox_CancelButton,
    double? topBarSpace = tBottomDialogTopBarSpace,
    double? bottomBarSpace = tBottomDialogBottomBarSpace,
    double? bottomTitleSpace = tBottomDialogBottomTitleSpace,
    double? bottomContentSpace = tBottomDialogBottomContentSpace,
    double? barHeight = tBottomDialogBarHeight,
    double? barWidth = tBottomDialogBarWidth,
    double? barRadius = tBottomDialogBarRadius,
    double? buttonRadius = tBottomDialogButtonRadius,
    Color? barColor = tWhite,
    Color? buttonColor = tWhite,
  }) async{
    bool? response = await RetCoreBottomDialogBox.confirm(
      content : content,
      confirmButtonStyle : confirmButtonStyle,
      cancelButtonStyle: cancelButtonStyle,
      title: title,
      boxRadius : boxRadius,
      backgroundColor : backgroundColor,
      padding : padding ?? tBottomDialogPadding,
      titleSize : titleSize,
      bottomSpace : bottomSpace,
      titleColor : titleColor,
      contentFontColor : contentFontColor,
      confirmButtonFontColor : confirmButtonFontColor,
      cancelButtonFontColor : cancelButtonFontColor,
      buttonFontSize : buttonFontSize,
      contentFontSize : contentFontSize,
      titleFontWeight : titleFontWeight,
      contentFontWeight : contentFontWeight,
      confirmButtonFontWeight : confirmButtonFontWeight,
      cancelButtonFontWeight : cancelButtonFontWeight,
      dialogBoxConfirmButton : dialogBoxConfirmButton,
      dialogBoxCancelButton : dialogBoxCancelButton,
      topBarSpace : topBarSpace,
      bottomBarSpace : bottomBarSpace,
      bottomTitleSpace : bottomTitleSpace,
      bottomContentSpace : bottomContentSpace,
      barHeight : barHeight,
      barWidth : barHeight,
      barRadius : barRadius,
      buttonRadius : buttonRadius,
      barColor : barColor,
      buttonColor : buttonColor,
    );
    return response ?? false;
  }

  static String getOS() {
    String value = RetCoreOS.getOS();
    return value;
  }
  static Future<bool> getRootDeviceStatus() async{
    bool value = await RetCoreRootDeviceChecker().getDetails();
    return value;
  }
  static void debounce({required VoidCallback process,int? milliseconds = 500}) async{
    RetCoreDebouncer.run(action: process,milliseconds: milliseconds);
  }
  static String getDayNameEnglish({required DateTime date}){
    String day = RetCoreDayMonthName.getDayName(date: date);
    return day;
  }
  static String getMonthNameEnglish({required DateTime date}){
    String month = RetCoreDayMonthName.getMonthName(date: date);
    return month;
  }
  static String getDayNameBangla({required String isoDateString}){
    String day = RetCoreDayMonthName().getBanglaDayName(isoDateString);
    return day;
  }
  static String getDayBangla({required String isoDateString}){
    String day = RetCoreDayMonthName().getBanglaDay(isoDateString);
    return day;
  }
  static String getDayEnglish({required String isoDateString}){
    String day = RetCoreDayMonthName().getEnglishDay(isoDateString);
    return day;
  }
  static String getMonthNameBangla({required String isoDateString}){
    String month = RetCoreDayMonthName().getBanglaFullMonthName(isoDateString);
    return month;
  }
  static String getMonthNumberBangla({required String isoDateString}){
    String banglaDate = RetCoreDayMonthName().getBanglaMonthNumber(isoDateString);
    return banglaDate;
  }
  static String getMonthNumberEnglish({required String isoDateString}){
    String englishDate = RetCoreDayMonthName().getEnglishMonthNumber(isoDateString);
    return englishDate;
  }
  static String getYearEnglish({required String isoDateString}){
    String englishYear = RetCoreDayMonthName().getEnglishYear(isoDateString);
    return englishYear;
  }
  static String getYearBangla({required String isoDateString}){
    String BanglaYear = RetCoreDayMonthName().getBanglaYear(isoDateString);
    return BanglaYear;
  }
  static String convertIntoBanglaDigit({required dynamic value}){
    String response = RetCoreDayMonthName().getBanglaDigit(value);
    return response;
  }
  static Map<String , dynamic> getTimeBangla({required String time,bool? isSecond}){
    Map<String , dynamic> response = RetCoreDayMonthName().getBanglaTime(isoDateString: time,isSecond: isSecond);
    return response;
  }
  static Map<String , dynamic> getDateBangla({required String isoDateString}){
    Map<String , dynamic> response = RetCoreDayMonthName().getBanglaDate(isoDateString: isoDateString);
    return response;
  }
  static Map<String , dynamic> getDateEnglish({required String isoDateString}){
    Map<String , dynamic> response = RetCoreDayMonthName().getEnglishDate(isoDateString: isoDateString);
    return response;
  }

  static Future<bool> dialogBox({
    required String title,
    required String content,
    required RetCoreDialogBoxMode mode,
    required RetCoreDialogBoxStyle style,
    String buttonText = tdialogBox_backButton,
    Color buttonColor = tFocusedColor,
    VoidCallback? onTap,
    double? dialogBoxContainerHeight = tDialogBoxContainerHeightSize,
    double? dialogBoxContainerRadius = tDialogBoxRadiusSize,
    double? dialogBoxIconWidthSize = tDialogBoxIconWidthSize,
    double? dialogBoxIconHeightSize = tDialogBoxIconHeightSize,
    String? dialogBoxConfirmButton = tdialogBox_ConfirmButton,
    String? dialogBoxCancelButton = tdialogBox_CancelButton,
    double? buttonFontSize = tDialogBoxButtonFontSize,
    Color? cancelButtonColor = tRedAccent,
    Color? confirmButtonColor = tGreen,
    Color? buttonTextColor = tWhite,
    double? dialogBoxContantTopHeightSize = tDialogBoxTopHeightSpace,
    double? dialogBoxContantBottomHeightSize = tDialogBoxBottomHeightSpace,
    double? dialogBoxTitleHeightSize = tDialogBoxTitleHeightSpace,
    double? titleFontSize = tDialogBoxTitleFontSize,
    double? dialogBoxContentPadding = tDialogBoxContentPadding,
    double? contentFontSize = tDialogBoxContentFontSize,
    double? tButtonSpace = tDialogBoxButtonSpace,
    Color? titleFontColor = tBlack,
    Color? contentFontColor = tBlack,
    FontWeight? titleFontWeight = FontWeight.w500,
})async{
    bool? response = await RetCoreDialogBox.dialogBox(
        title: title,
        content: content,
        mode: mode,
        style: style,
        buttonText: buttonText,
        buttonColor: buttonColor,
        onTap: onTap,
        dialogBoxContainerHeight: dialogBoxContainerHeight,
        dialogBoxContainerRadius: dialogBoxContainerRadius,
        dialogBoxIconWidthSize: dialogBoxIconWidthSize,
        dialogBoxIconHeightSize: dialogBoxIconHeightSize,
        dialogBoxConfirmButton: dialogBoxConfirmButton,
        dialogBoxCancelButton: dialogBoxCancelButton,
        buttonFontSize: buttonFontSize,
        cancelButtonColor: cancelButtonColor,
        confirmButtonColor: confirmButtonColor,
        buttonTextColor: buttonTextColor,
        dialogBoxContantTopHeightSize: dialogBoxContantTopHeightSize,
        dialogBoxContantBottomHeightSize: dialogBoxContantBottomHeightSize,
        dialogBoxTitleHeightSize: dialogBoxTitleHeightSize,
        titleFontSize: titleFontSize,
        dialogBoxContentPadding: dialogBoxContentPadding,
        contentFontSize: contentFontSize,
        tButtonSpace: tButtonSpace,
        titleFontColor: titleFontColor,
        contentFontColor: contentFontColor,
        titleFontWeight: titleFontWeight
    );
    return response ?? false;
  }

  static void bottomsheet({
    required Widget child,
    double? boxRadius = tBottomDialogRadius,
    Color? backgroundColor = tGrey,
    double? padding = tBottomDialogPadding,
}){
    RetCoreBottomSheet.bottomSheet(
      child: child,
        boxRadius:boxRadius,
      padding: padding,
      backgroundColor: backgroundColor
    );
  }

  static void setData({
    required RetCoreLocalStorageType type,
    required String key,
    required dynamic value
  })async{
    await SharedServices.setData(type: type, key: key, value: value);
  }

  static dynamic getData({
    required RetCoreLocalStorageType type,
    required String key,
  })async{
    dynamic response = await SharedServices.getData(type: type, key: key);
    return response;
  }

  static void removeData({
    required String key
  })async{
    await SharedServices.removeData(key: key);
  }

  static void startTouchDetection({
    Duration? time = const Duration(minutes: 5), void Function()? afterTimeout
  }){
    RetCoreActivityDetectorController().startTouchDetection(time: time,afterTimeout: afterTimeout);
  }

  static void startAutoSession({
    Duration? time = const Duration(minutes: 4),void Function()? process
  }){
    RetCoreActivityDetectorController().startAutoSession(time: time,process: process);
  }

  static void stopTouchDetectionAndAutoSession()async{
    RetCoreActivityDetectorController().stopEverything();
  }

  static bool isMobile(){
    bool response = RetCoreResponsive.isMobile();
    return response;
  }

  static bool isTablet(){
    bool response = RetCoreResponsive.isTablet();
    return response;
  }

  static bool isDesktop(){
    bool response = RetCoreResponsive.isDesktop();
    return response;
  }

}