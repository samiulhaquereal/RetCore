import 'package:retcore/src/config/imports.dart';

class RetCoreDialogBox{

  static RetCoreDialogBox? _instance;
  RetCoreDialogBox._internal();
  factory RetCoreDialogBox(){
    _instance ??= RetCoreDialogBox._internal();
    return _instance!;
  }

  final List<String> _iconData = [
    dialogBox_icon1,
    dialogBox_icon2,
    dialogBox_icon3,
    dialogBox_icon4,
    dialogBox_icon5,
  ];

  final List<String> _dialogTitle = [
    dialogBox_title1,
    dialogBox_title2,
    dialogBox_title3,
    dialogBox_title4,
  ];

  Future<void> show({
    required String content,
    required RetCoreSnackBarMode mode,
    String buttonText = dialogBox_backButton,
    Color buttonColor = tFocusedColor,
    Color buttonTextColor = tWhite,
    VoidCallback? onTap,
    double? dialogBoxContainerHeight = tDialogBoxContainerHeightSize,
    double? dialogBoxContainerRadius = tDialogBoxRadiusSize,
    double? dialogBoxIconWidthSize = tDialogBoxIconWidthSize,
    double? dialogBoxIconHeightSize = tDialogBoxIconHeightSize,
    double? dialogBoxTopHeightSize = tDialogBoxTopHeightSpace,
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
                                color: mode == RetCoreSnackBarMode.success ? tDialogSuccessContainerColor : mode == RetCoreSnackBarMode.error ? tDialogErrorContainerColor : mode == RetCoreSnackBarMode.alert ? tDialogAlertContainerColor : mode == RetCoreSnackBarMode.info ? tDialogInfoContainerColor : null,
                                borderRadius: BorderRadius.only(topRight: Radius.circular(dialogBoxContainerRadius),topLeft: Radius.circular(dialogBoxContainerRadius))
                            ),

                            child: Center(
                              child: Lottie.asset(
                                  mode == RetCoreSnackBarMode.success ?_iconData[0] : mode == RetCoreSnackBarMode.error ?_iconData[1] : mode == RetCoreSnackBarMode.alert ?_iconData[2] : mode == RetCoreSnackBarMode.info ?_iconData[3] : '',
                                  repeat: false,
                                  width: dialogBoxIconWidthSize,
                                  height: dialogBoxIconHeightSize,
                              ),
                            ),
                          )
                      ),
                      Expanded(child: Column(
                        children: [
                          SizedBox(height: dialogBoxTopHeightSize),
                          Text(
                            mode == RetCoreSnackBarMode.success ? _dialogTitle[0] : mode == RetCoreSnackBarMode.error ? _dialogTitle[1] : mode == RetCoreSnackBarMode.alert ? _dialogTitle[2] : mode == RetCoreSnackBarMode.info ? _dialogTitle[3] : ''
                            ,style: TextStyle(fontSize:titleFontSize , color: titleFontColor,fontWeight: titleFontWeight),),
                          SizedBox(height:dialogBoxTitleHeightSize),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: dialogBoxContentPadding!),
                            child: Text(content,style: TextStyle(fontSize:contentFontSize , color: contentFontColor)),
                          ),
                          SizedBox(height:dialogBoxTopHeightSize),
                          ElevatedButton(
                            onPressed: (){
                              if(onTap != null){
                                onTap!();
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
  }

  Future<bool> confirm({
    required String title,
    required String subtitle,
  }) async {
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
                child: Container(
                  height: subtitle.length > 35 ? 350 : 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    children: [
                      Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Color(0xFF1CAFA2),
                                borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                            ),

                            child: Center(
                              child: Lottie.asset(_iconData[4],
                                  repeat: false,
                                  width: 100,
                                  height: 100
                              ),
                            ),
                          )
                      ),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height:10),
                              Text(title,style: const TextStyle(fontSize:16,color: tBlack,fontWeight: FontWeight.w500),),
                              const SizedBox(height:7),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(subtitle),
                              ),
                              const SizedBox(height:10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                        completer.complete(false);
                                      },
                                      child: const Text('No',style: TextStyle(color: tWhite)),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: tRedAccent, // Set the primary color to blue
                                      )),
                                  const SizedBox(width: 20),
                                  ElevatedButton(
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                        completer.complete(true);
                                      },
                                      child: const Text('Yes',style: TextStyle(color: tWhite)),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: tDialogConfirmButtonColor, // Set the primary color to blue
                                      )),
                                ],
                              )
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
    return completer.future;
  }

}