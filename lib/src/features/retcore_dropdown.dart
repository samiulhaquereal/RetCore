import 'package:retcore/src/config/imports.dart';

class RetCoreDropdownField extends StatelessWidget {
  const RetCoreDropdownField({
    super.key,
    required this.itemList,
    required this.retCoreDropdownFieldStyle,
    required this.selectedValueNotifier,
    this.isBorder = true,
    this.dropIcon = Icons.arrow_drop_down_circle,
    this.backgroundColor = tWhite,
    this.itemFontColor = tBlack,
    this.dropIconColor = tGrey,
    this.hint = tHintDropDown,
    this.icon,
    this.isPrefixIcon,
    this.isSuffixIcon,
    this.iconSize,
    this.iconColor,
    this.isRequired = false,
    this.labelColor = tBlack,
    this.labelSize = tLabelSize,
    this.borderColor = tGrey,
    this.focusedColor = tFocusedColor,
    this.borderRadius = tBorderRadiusSize,
    this.validator,
    this.onChanged,
    this.isCompact = true,
    this.label,
    this.hintFontColor = tGrey,
    this.hintFontSize = tHintFontSize,
    this.iconWidget ,
    this.itemFontSize = tDropdownItemFontSize ,
    this.itemAlignment = Alignment.centerLeft,
    this.suffixItemIcon,
    this.prefixItemIcon,
    this.suffixItemIconWidget,
    this.prefixItemIconWidget,
    this.itemLeadingSpace = tDropdownItemLeadingSpace,
  });

  final String? hint;
  final String? label;
  final double? iconSize;
  final double? labelSize;
  final double? hintFontSize;
  final double? borderRadius;
  final double? itemFontSize;
  final double? itemLeadingSpace;
  final Color? iconColor;
  final Color? borderColor;
  final Color? labelColor ;
  final Color? focusedColor;
  final Color? hintFontColor;
  final Color? dropIconColor;
  final Color? backgroundColor;
  final Color? itemFontColor;
  final bool? isBorder;
  final bool? isPrefixIcon;
  final bool? isSuffixIcon;
  final bool? isRequired;
  final bool? isCompact;
  final IconData? icon;
  final IconData? dropIcon;
  final IconData? prefixItemIcon;
  final IconData? suffixItemIcon;
  final Widget? iconWidget;
  final Widget? prefixItemIconWidget;
  final Widget? suffixItemIconWidget;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final List<String> itemList;
  final Alignment itemAlignment;
  final RetCoreDropdownFieldStyle retCoreDropdownFieldStyle;
  final ValueNotifier<String?> selectedValueNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedValueNotifier,
      builder: (context, selectedValue, child){
        return DropdownButtonFormField(
          isExpanded: true,
          value: selectedValue,
          items: itemList.map((item) => DropdownMenuItem(
            value: item,
            alignment: itemAlignment,
            child: retCoreDropdownFieldStyle == RetCoreDropdownFieldStyle.normal ? Text(item,style: TextStyle(fontSize: itemFontSize,color: itemFontColor)) :
            retCoreDropdownFieldStyle == RetCoreDropdownFieldStyle.style1 ?
            DropdownStyle1(
                prefixItemIconWidget: prefixItemIconWidget,
                prefixItemIcon: prefixItemIcon,
                dropIconColor: dropIconColor,
                iconSize: iconSize,
                itemLeadingSpace: itemLeadingSpace,
                itemFontSize: itemFontSize,
                itemFontColor: itemFontColor,
                suffixItemIconWidget: suffixItemIconWidget,
                suffixItemIcon: suffixItemIcon, item: item) : const SizedBox(),
          )).toList(),
          icon: Icon(dropIcon, color: dropIconColor,size: iconSize),
          dropdownColor: backgroundColor,
          decoration: InputDecoration(
            isDense: isCompact,
            suffixIcon: isSuffixIcon == true ? iconWidget ?? Icon(icon, size: iconSize, color: iconColor) :  null,
            prefixIcon: isPrefixIcon == true ? iconWidget ?? Icon(icon, size: iconSize, color: iconColor) : null,
            enabledBorder: isBorder == true ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius!),
                borderSide: BorderSide(color: borderColor!))
                : UnderlineInputBorder(
                borderSide: BorderSide(color: borderColor!)),
            focusedBorder: isBorder == true ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius!),
                borderSide: BorderSide(color: focusedColor!))
                : UnderlineInputBorder(
                borderSide: BorderSide(color: focusedColor!)),
            errorBorder: isBorder == true ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius!),
                borderSide: const BorderSide(color: tRed))
                : const UnderlineInputBorder(borderSide: BorderSide(color: tRed)),
            focusedErrorBorder: isBorder == true ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius!),
                borderSide: const BorderSide(color: tRed))
                : const UnderlineInputBorder(borderSide: BorderSide(color: tRed)),
            hintText: hint,
            hintStyle: TextStyle(fontSize: hintFontSize,color: hintFontColor),
            label: label == null ? null : RichText(
              text: TextSpan(
                text: '$label ',
                style: TextStyle(fontSize: labelSize, color: labelColor),
                children: [
                  TextSpan(
                    text: isRequired == true ? '*' : '',
                    style: TextStyle(fontSize: labelSize!+3,color: tRed),
                  ),
                ],
              ),
            ),
          ),
          validator: isRequired == true ? validator : null,
          onChanged: (value) {
            selectedValueNotifier.value = value;
            if (onChanged != null) {
              onChanged!(value);
            }
          },
          selectedItemBuilder: (_) {
            return itemList.map((item) {
              return Text(
                  selectedValue ?? tHintDropDown,
                  style: TextStyle(fontSize: itemFontSize,color: itemFontColor)
              );
            }).toList();
          },
        );
      }
    );
  }
}
