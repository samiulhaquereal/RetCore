import 'package:retcore/src/config/imports.dart';

class RetCore{

  static void to(Widget page){
    BuildContext? context = FindContext.getContext();
    Navigator.push(context!,MaterialPageRoute(builder: (context) => page));
}

}