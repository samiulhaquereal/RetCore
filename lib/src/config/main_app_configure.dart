import 'package:retcore/src/config/imports.dart';

class MyDataProvider extends InheritedWidget {
  final BuildContext context;

  MyDataProvider({Key? key, required this.context, required Widget child})
      : super(key: key, child: child);

  static MyDataProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyDataProvider>();
  }

  @override
  bool updateShouldNotify(MyDataProvider oldWidget) {
    return false;
  }
}