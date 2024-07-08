import 'package:retcore/src/config/imports.dart';

class RetcoreSpace{

  static RetcoreSpace? _instance;
  RetcoreSpace._internal();
  factory RetcoreSpace(){
    _instance ??= RetcoreSpace._internal();
    return _instance!;
  }

  static Widget retcoreSpace(double? size) {

    BuildContext? context = RetCoreNavigatorKey.currentContext;
    if(context == null){
      print('DOOM');
    }

    Flex? parent = context?.findAncestorWidgetOfExactType<Flex>();
    Row? parent2 = context?.findAncestorWidgetOfExactType<Row>();
    Column? parent3 = context?.findAncestorWidgetOfExactType<Column>();
    Wrap? parent4 = context?.findAncestorWidgetOfExactType<Wrap>();

    if (parent != null && parent is Flex) {
      Axis direction = parent.direction;
      if (direction == Axis.horizontal) {
        return SizedBox(width: size);
      } else if (direction == Axis.vertical) {
        return SizedBox(height: size);
      }
    }else if(parent2 != null && parent2 is Row){
      return SizedBox(width: size);
    }else if(parent3 != null && parent3 is Column){
      return SizedBox(height: size);
    }else if (parent4 != null && parent4 is Wrap) {
      if (parent4.direction == Axis.horizontal) {
        return SizedBox(width: size);
      } else if (parent4.direction == Axis.vertical) {
        return SizedBox(height: size);
      }
    }else{
      print('Wrong');
    }
    // If the AutoSpace widget is used outside of Flex (Row or Column),
    // you might want to handle this case or provide a default behavior.
    return SizedBox();
  }
}


