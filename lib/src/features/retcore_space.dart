import 'package:flutter/material.dart';
import 'package:retcore/src/config/imports.dart';

class RetcoreSpace{

  static RetcoreSpace? _instance;
  RetcoreSpace._internal();
  factory RetcoreSpace(){
    _instance ??= RetcoreSpace._internal();
    return _instance!;
  }

  static Widget retcoreSpace(double size) {
    BuildContext? context = FindContext.getContext();
    final direction = _getParentDirection(context!);

    if (direction == Axis.vertical) {
      return SizedBox(height: size);
    } else if (direction == Axis.horizontal) {
      return SizedBox(width: size);
    } else {
      // Default to vertical if the direction couldn't be determined
      return SizedBox(height: size);
    }
  }

  static Axis _getParentDirection(BuildContext context) {
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

