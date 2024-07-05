import 'package:retcore/src/config/imports.dart';

class DropdownStyle1 extends StatelessWidget {
  const DropdownStyle1({
    super.key,
    required this.prefixItemIconWidget,
    required this.prefixItemIcon,
    required this.dropIconColor,
    required this.iconSize,
    required this.itemLeadingSpace,
    required this.itemFontSize,
    required this.itemFontColor,
    required this.suffixItemIconWidget,
    required this.suffixItemIcon,
    required this.item,
  });

  final Widget? prefixItemIconWidget;
  final IconData? prefixItemIcon;
  final Color? dropIconColor;
  final double? iconSize;
  final double? itemLeadingSpace;
  final double? itemFontSize;
  final Color? itemFontColor;
  final Widget? suffixItemIconWidget;
  final IconData? suffixItemIcon;
  final String? item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        prefixItemIconWidget ?? Icon(prefixItemIcon, color: dropIconColor,size: iconSize),
        SizedBox(width: itemLeadingSpace),
        Text(item!,style: TextStyle(fontSize: itemFontSize,color: itemFontColor)),
        Flexible(
          fit: FlexFit.loose,
          child: Container(),
        ),
        suffixItemIconWidget ?? Icon(suffixItemIcon, color: dropIconColor,size: iconSize)
      ],
    );
  }
}