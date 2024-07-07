import 'package:retcore/src/config/imports.dart';

class RetCoreDialogBox{

  static RetCoreDialogBox? _instance;
  RetCoreDialogBox._internal();
  factory RetCoreDialogBox(){
    _instance ??= RetCoreDialogBox._internal();
    return _instance!;
  }

  /*static Future<void> show({
    required String content,
    required RetCoreDialogBoxMode mode,
    String buttonText = tdialogBox_backButton,
    Color buttonColor = tFocusedColor,
    VoidCallback? onTap,
    Color buttonTextColor = tWhite,
    double? dialogBoxContainerHeight = tDialogBoxContainerHeightSize,
    double? dialogBoxContainerRadius = tDialogBoxRadiusSize,
    double? dialogBoxIconWidthSize = tDialogBoxIconWidthSize,
    double? dialogBoxIconHeightSize = tDialogBoxIconHeightSize,
    double? dialogBoxContantTopHeightSize = tDialogBoxTopHeightSpace,
    double? dialogBoxContantBottomHeightSize = tDialogBoxBottomHeightSpace,
    double? dialogBoxTitleHeightSize = tDialogBoxTitleHeightSpace,
    double? titleFontSize = tDialogBoxTitleFontSize,
    double? dialogBoxContentPadding = tDialogBoxContentPadding,
    double? contentFontSize = tDialogBoxContentFontSize,
    double? buttonFontSize = tDialogBoxButtonFontSize,
    Color? titleFontColor = tBlack,
    Color? contentFontColor = tBlack,
    FontWeight? titleFontWeight = FontWeight.w500,
    bool? barrierDismissible,
  }) async{
    final List<String> _iconData = [
      dialogBox_icon1,
      dialogBox_icon2,
      dialogBox_icon3,
      dialogBox_icon4
    ];
    final List<String> _dialogTitle = [
      tdialogBox_title1,
      tdialogBox_title2,
      tdialogBox_title3,
      tdialogBox_title4,
    ];
    BuildContext? context = FindContext.getContext();
    showGeneralDialog(
        context: context!,
        barrierLabel: '',
        barrierDismissible: barrierDismissible ?? true,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (context,animation1,animation2){
          return Container();
        },
        transitionBuilder: (context,a1,a2,widget){
          return ScaleTransition(
            scale:Tween<double>(begin: 0.5,end: 1.0).animate(a1),
            child: FadeTransition(
              opacity:Tween<double>(begin: 0.5,end: 1.0).animate(a1),
              child: Dialog(
                child: Container(
                  height: content.length > tDialogBoxTitleLengthSize ? dialogBoxContainerHeight! + 50 : dialogBoxContainerHeight,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(dialogBoxContainerRadius!)
                  ),
                  child: Column(
                    children: [
                      Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: mode == RetCoreDialogBoxMode.success ? tDialogSuccessContainerColor : mode == RetCoreDialogBoxMode.error ? tDialogErrorContainerColor : mode == RetCoreDialogBoxMode.alert ? tDialogAlertContainerColor : mode == RetCoreDialogBoxMode.info ? tDialogInfoContainerColor : null,
                                borderRadius: BorderRadius.only(topRight: Radius.circular(dialogBoxContainerRadius),topLeft: Radius.circular(dialogBoxContainerRadius))
                            ),

                            child: Center(
                              child: Lottie.asset(
                                  mode == RetCoreDialogBoxMode.success ? _iconData[0] : mode == RetCoreDialogBoxMode.error ? _iconData[1] : mode == RetCoreDialogBoxMode.alert ?_iconData[2] : mode == RetCoreDialogBoxMode.info ?_iconData[3] : '',
                                  repeat: false,
                                  width: dialogBoxIconWidthSize,
                                  height: dialogBoxIconHeightSize,
                              ),
                            )
                          )
                      ),
                      Expanded(child: Column(
                        children: [
                          SizedBox(height: dialogBoxContantTopHeightSize),
                          Text(
                            mode == RetCoreDialogBoxMode.success ? _dialogTitle[0] : mode == RetCoreDialogBoxMode.error ? _dialogTitle[1] : mode == RetCoreDialogBoxMode.alert ? _dialogTitle[2] : mode == RetCoreDialogBoxMode.info ? _dialogTitle[3] : ''
                            ,style: TextStyle(fontSize:titleFontSize , color: titleFontColor,fontWeight: titleFontWeight),),
                          SizedBox(height:dialogBoxTitleHeightSize),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: dialogBoxContentPadding!),
                            child: Text(content,style: TextStyle(fontSize:contentFontSize , color: contentFontColor)),
                          ),
                          SizedBox(height:dialogBoxContantBottomHeightSize),
                          ElevatedButton(
                            onPressed: (){
                              if(onTap != null){
                                onTap();
                              }else{
                                Navigator.of(context).pop();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor, // Set the primary color to blue
                          ), child: Text(buttonText,style: TextStyle(fontSize: buttonFontSize ,color: buttonTextColor)))
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }*/


  static Future<bool> dialogBox({
    required String title,
    required String content,
    required RetCoreDialogBoxMode mode,
    required RetCoreDialogBoxStyle style,
    String? buttonText,
    Color? buttonColor,
    VoidCallback? onTap,
    double? dialogBoxContainerHeight,
    double? dialogBoxContainerRadius,
    double? dialogBoxIconWidthSize,
    double? dialogBoxIconHeightSize ,
    String? dialogBoxConfirmButton,
    String? dialogBoxCancelButton,
    double? buttonFontSize,
    Color? cancelButtonColor,
    Color? confirmButtonColor,
    Color? buttonTextColor,
    double? dialogBoxContantTopHeightSize,
    double? dialogBoxContantBottomHeightSize,
    double? dialogBoxTitleHeightSize,
    double? titleFontSize,
    double? dialogBoxContentPadding,
    double? contentFontSize,
    double? tButtonSpace,
    Color? titleFontColor,
    Color? contentFontColor,
    FontWeight? titleFontWeight,

  }) async {
    final String _iconDataa = dialogBox_icon5;
    final List<String> _iconData = [
      dialogBox_icon1,
      dialogBox_icon2,
      dialogBox_icon3,
      dialogBox_icon4
    ];
    final List<String> _dialogTitle = [
      tdialogBox_title1,
      tdialogBox_title2,
      tdialogBox_title3,
      tdialogBox_title4,
    ];
    BuildContext? context = FindContext.getContext();
    Completer<bool> completer = Completer<bool>();
    showGeneralDialog(
        context: context!,
        barrierLabel: '',
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (context,animation1,animation2){
          return Container();
        },
        transitionBuilder: (context,a1,a2,widget){
          return ScaleTransition(
            scale:Tween<double>(begin: 0.5,end: 1.0).animate(a1),
            child: FadeTransition(
              opacity:Tween<double>(begin: 0.5,end: 1.0).animate(a1),
              child: Dialog(
                child: style == RetCoreDialogBoxStyle.confirm && mode == RetCoreDialogBoxMode.confirm ? Container(
                  height: content.length > tDialogBoxTitleLengthSize ? dialogBoxContainerHeight! + 50 : dialogBoxContainerHeight,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(dialogBoxContainerRadius!)
                  ),
                  child: Column(
                    children: [
                      Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: tDialogConfirmContainerColor,
                                borderRadius: BorderRadius.only(topRight: Radius.circular(dialogBoxContainerRadius),topLeft: Radius.circular(dialogBoxContainerRadius))
                            ),

                            child: Center(
                              child: Lottie.asset(
                                  _iconDataa,
                                  repeat: false,
                                  width: dialogBoxIconWidthSize,
                                  height: dialogBoxIconHeightSize,
                              ),
                            ),
                          )
                      ),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: dialogBoxContantTopHeightSize),
                              Text(title,style: TextStyle(fontSize:titleFontSize , color: titleFontColor,fontWeight: titleFontWeight)),
                              SizedBox(height:dialogBoxTitleHeightSize),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: dialogBoxContentPadding!),
                                child: Text(content,style: TextStyle(fontSize:contentFontSize , color: contentFontColor)),
                              ),
                              SizedBox(height: dialogBoxContantBottomHeightSize),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                        completer.complete(false);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: cancelButtonColor, // Set the primary color to blue
                                      ),
                                      child: Text(dialogBoxCancelButton!,style: TextStyle(fontSize: buttonFontSize ,color: buttonTextColor))),
                                  SizedBox(width: tButtonSpace),
                                  ElevatedButton(
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                        completer.complete(true);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: confirmButtonColor, // Set the primary color to blue
                                      ),
                                      child: Text(dialogBoxConfirmButton!,style: TextStyle(fontSize: buttonFontSize ,color: buttonTextColor))),
                                ],
                              )
                            ],
                          ))
                    ],
                  ),
                ) : Container(
                  height: content.length > tDialogBoxTitleLengthSize ? dialogBoxContainerHeight! + 50 : dialogBoxContainerHeight,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(dialogBoxContainerRadius!)
                  ),
                  child: Column(
                    children: [
                      Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: mode == RetCoreDialogBoxMode.success ? tDialogSuccessContainerColor : mode == RetCoreDialogBoxMode.error ? tDialogErrorContainerColor : mode == RetCoreDialogBoxMode.alert ? tDialogAlertContainerColor : mode == RetCoreDialogBoxMode.info ? tDialogInfoContainerColor : null,
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(dialogBoxContainerRadius),topLeft: Radius.circular(dialogBoxContainerRadius))
                              ),

                              child: Center(
                                child: Lottie.asset(
                                  mode == RetCoreDialogBoxMode.success ? _iconData[0] : mode == RetCoreDialogBoxMode.error ? _iconData[1] : mode == RetCoreDialogBoxMode.alert ?_iconData[2] : mode == RetCoreDialogBoxMode.info ?_iconData[3] : '',
                                  repeat: false,
                                  width: dialogBoxIconWidthSize,
                                  height: dialogBoxIconHeightSize,
                                ),
                              )
                          )
                      ),
                      Expanded(child: Column(
                        children: [
                          SizedBox(height: dialogBoxContantTopHeightSize),
                          Text(
                            mode == RetCoreDialogBoxMode.success ? _dialogTitle[0] : mode == RetCoreDialogBoxMode.error ? _dialogTitle[1] : mode == RetCoreDialogBoxMode.alert ? _dialogTitle[2] : mode == RetCoreDialogBoxMode.info ? _dialogTitle[3] : ''
                            ,style: TextStyle(fontSize:titleFontSize , color: titleFontColor,fontWeight: titleFontWeight),),
                          SizedBox(height:dialogBoxTitleHeightSize),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: dialogBoxContentPadding!),
                            child: Text(content,style: TextStyle(fontSize:contentFontSize , color: contentFontColor)),
                          ),
                          SizedBox(height:dialogBoxContantBottomHeightSize),
                          ElevatedButton(
                              onPressed: (){
                                if(onTap != null){
                                  onTap();
                                }else{
                                  Navigator.of(context).pop();
                                }
                                completer.complete(false);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: buttonColor, // Set the primary color to blue
                              ), child: Text(buttonText!,style: TextStyle(fontSize: buttonFontSize ,color: buttonTextColor)))
                        ],
                      ))
                    ],
                  ),
                ) ,
              ),
            ),
          );
        }
    );
    return completer.future;
  }

}