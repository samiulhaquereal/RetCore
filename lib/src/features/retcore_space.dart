import 'package:retcore/src/config/imports.dart';

class RetcoreSpace extends StatelessWidget {
  final double size;

  const RetcoreSpace({
    super.key,
    required this.size
  });

  @override
  Widget build(BuildContext context) {
    final direction = _getParentDirection(context);

    if (direction == Axis.vertical) {
      return SizedBox(height: size);
    } else if (direction == Axis.horizontal) {
      return SizedBox(width: size);
    } else {
      // Default to vertical if the direction couldn't be determined
      return SizedBox(height: size);
    }
  }

  Axis _getParentDirection(BuildContext context) {
    final parent = context.findAncestorWidgetOfExactType<Flex>();
    if (parent != null) {
      return parent.direction;
    }
    final wrap = context.findAncestorWidgetOfExactType<Wrap>();
    if (wrap != null) {
      return wrap.direction;
    }
    // Default to vertical if no parent direction is found
    return Axis.vertical;
  }
}
