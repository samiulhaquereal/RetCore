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

    Flex? parent = context?.findAncestorWidgetOfExactType<Flex>();
    Row? parent2 = context?.findAncestorWidgetOfExactType<Row>();
    Column? parent3 = context?.findAncestorWidgetOfExactType<Column>();
    Wrap? parent4 = context?.findAncestorWidgetOfExactType<Wrap>();

    if (parent != null) {
      Axis direction = parent.direction;
      if (direction == Axis.horizontal) {
        return SizedBox(width: size);
      } else if (direction == Axis.vertical) {
        return SizedBox(height: size);
      }
    }else if(parent2?.direction == Axis.horizontal){
      return SizedBox(width: size);
    }else if(parent3?.direction == Axis.vertical){
      return SizedBox(height: size);
    }else if (parent4 is Wrap) {
      if (parent4.direction == Axis.horizontal) {
        return SizedBox(width: size);
      } else if (parent4.direction == Axis.vertical) {
        return SizedBox(height: size);
      }
    }
    // If the AutoSpace widget is used outside of Flex (Row or Column),
    // you might want to handle this case or provide a default behavior.
    return SizedBox();
  }
}


