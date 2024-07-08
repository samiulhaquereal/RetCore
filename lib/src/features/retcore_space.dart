import 'package:retcore/src/config/imports.dart';

class RetcoreSpace extends StatelessWidget {
  final double space;

  const RetcoreSpace({Key? key, required this.space}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Flex? parent = context.findAncestorWidgetOfExactType<Flex>();
    Row? parent2 = context.findAncestorWidgetOfExactType<Row>();
    Column? parent3 = context.findAncestorWidgetOfExactType<Column>();
    Wrap? parent4 = context.findAncestorWidgetOfExactType<Wrap>();
    if (parent != null) {
      Axis direction = parent.direction;
      if (direction == Axis.horizontal) {
        return SizedBox(width: space);
      } else if (direction == Axis.vertical) {
        return SizedBox(height: space);
      }
    }else if(parent2?.direction == Axis.horizontal){
      return SizedBox(width: space);
    }else if(parent3?.direction == Axis.vertical){
      return SizedBox(height: space);
    }else if (parent4 is Wrap) {
      if (parent4.direction == Axis.horizontal) {
        return SizedBox(width: space);
      } else if (parent4.direction == Axis.vertical) {
        return SizedBox(height: space);
      }
    }
    // If the AutoSpace widget is used outside of Flex (Row or Column),
    // you might want to handle this case or provide a default behavior.
    return SizedBox();
  }
}