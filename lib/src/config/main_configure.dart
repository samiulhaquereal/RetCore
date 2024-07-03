import 'package:retcore/src/config/imports.dart';

MaterialApp RetCoreApp({required Widget home}) {
  return MaterialApp(
    navigatorKey: navigatorKey,
    home: home,
  );
}

/*class RetCoreApp extends InheritedWidget {
  final BuildContext context;

  RetCoreApp({
    required this.context,
    required Widget child,
  }) : super(child: child);

  static RetCoreApp? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RetCoreApp>();
  }

  @override
  bool updateShouldNotify(RetCoreApp oldWidget) {
    return oldWidget.context != context;
  }
}*/
