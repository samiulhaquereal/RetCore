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
    required BuildContext context ,
    required String title,
    required String buttonText,
    required Color buttonColor,
    required Color buttonTextColor,
    required VoidCallback onTap,
    required RetCoreSnackBarMode mode,
    bool? barrierDismissible,
  }) async{
    showGeneralDialog(
        context: context,
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
                  height: title.length > 35 ? 350 : 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    children: [
                      Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: mode == RetCoreSnackBarMode.success ? const Color(0xFF12C069) : mode == RetCoreSnackBarMode.error ? const Color(0xFF91011E) : mode == RetCoreSnackBarMode.alert ? const Color(0xFF29363F) : mode == RetCoreSnackBarMode.info ? const Color(0xFFC99207) : null,
                                borderRadius: const BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                            ),

                            child: Center(
                              child: Lottie.asset(
                                  mode == RetCoreSnackBarMode.success ?_iconData[0] : mode == RetCoreSnackBarMode.error ?_iconData[1] : mode == RetCoreSnackBarMode.alert ?_iconData[2] : mode == RetCoreSnackBarMode.info ?_iconData[3] : '',
                                  repeat: false,
                                  width: 100,
                                  height: 100
                              ),
                            ),
                          )
                      ),
                      Expanded(child: Column(
                        children: [
                          const SizedBox(height:15),
                          Text(
                            mode == RetCoreSnackBarMode.success ? _dialogTitle[0] : mode == RetCoreSnackBarMode.error ? _dialogTitle[1] : mode == RetCoreSnackBarMode.alert ? _dialogTitle[2] : mode == RetCoreSnackBarMode.info ? _dialogTitle[3] : ''
                            ,style: const TextStyle(fontSize:16,color: tBlack,fontWeight: FontWeight.w500),),
                          const SizedBox(height:7),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(title),
                          ),
                          const SizedBox(height:15),
                          ElevatedButton(
                            onPressed: onTap,
                            style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor, // Set the primary color to blue
                          ), child: Text(buttonText,style: TextStyle(color: buttonTextColor)))
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
    required BuildContext context ,
    required String title,
    required String subtitle,
  }) async {
    Completer<bool> completer = Completer<bool>();
    showGeneralDialog(
        context: context,
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
                                        backgroundColor: Colors.redAccent, // Set the primary color to blue
                                      )),
                                  const SizedBox(width: 20),
                                  ElevatedButton(
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                        completer.complete(true);
                                      },
                                      child: const Text('Yes',style: TextStyle(color: tWhite)),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF4CB050), // Set the primary color to blue
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