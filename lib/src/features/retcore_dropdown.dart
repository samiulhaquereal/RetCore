import 'package:retcore/src/config/imports.dart';
import 'package:retcore/src/widgets/dropdown_style3.dart';

class RetCoreDropdownField extends StatelessWidget {
  const RetCoreDropdownField({
    super.key,
    required this.itemList,
    required this.retCoreDropdownFieldStyle,
    required this.selectedItem,
    required this.fieldFocusNode,
    this.isBorder = true,
    this.dropIcon = Icons.arrow_drop_down_circle,
    this.backgroundColor = tWhite,
    this.itemFontColor = tBlack,
    this.dropIconColor = tGrey,
    this.hint = tHintDropDown,
    this.iconSize,
    this.suffixIcon,
    this.suffixIconWidget,
    this.prefixIcon,
    this.prefixIconWidget,
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
    this.isEnabled = true,
    this.inputFontSize = tInputFontSize,
    this.inputFontColor = tBlack,
    this.keyboardType = RetCoreKeyboardType.text,
    this.selectedItemList,
    this.onDeleted,
    this.chipSize,
    this.chipBorderColor,
    this.chipDeleteIconColor,
    this.chipTitleFontColor,
    this.chipBorderRadius,
    this.chipTitleFontSize,
    this.height,
    this.contentPadding,
  });

  final String? hint;
  final String? label;
  final double? iconSize;
  final double? labelSize;
  final double? hintFontSize;
  final double? borderRadius;
  final double? itemFontSize;
  final double? itemLeadingSpace;
  final double? inputFontSize;
  final Color? inputFontColor;
  final Color? iconColor;
  final Color? borderColor;
  final Color? labelColor ;
  final Color? focusedColor;
  final Color? hintFontColor;
  final Color? dropIconColor;
  final Color? backgroundColor;
  final Color? itemFontColor;
  final bool? isBorder;
  final bool? isRequired;
  final bool? isCompact;
  final bool? isEnabled;
  final Widget? suffixIconWidget;
  final Widget? prefixIconWidget;
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
  final ValueNotifier<String?> selectedItem;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final FocusNode fieldFocusNode;
  final RetCoreKeyboardType? keyboardType;

  final ValueNotifier<List<String>>? selectedItemList;
  final void Function(String)? onDeleted;
  final double? chipSize;
  final Color? chipBorderColor;
  final Color? chipDeleteIconColor;
  final Color? chipTitleFontColor;
  final double? chipBorderRadius;
  final double? chipTitleFontSize;
  final double? height;
  final double? contentPadding;

  @override
  Widget build(BuildContext context) {
    return retCoreDropdownFieldStyle == RetCoreDropdownFieldStyle.searchable ? DropdownStyle2(
    selectedItem: selectedItem,
    fieldFocusNode: fieldFocusNode,
    hint: hint,
    label: label,
    iconSize: iconSize,
    labelSize: labelSize,
    hintFontSize: hintFontSize,
    borderRadius: borderRadius,
    iconColor: iconColor,
    borderColor: borderColor,
    labelColor : labelColor,
    focusedColor: focusedColor,
    hintFontColor: hintFontColor,
    dropIconColor:dropIconColor,
    backgroundColor:backgroundColor,
    isBorder:isBorder,
    isRequired: isRequired,
    isEnabled: isEnabled,
    isCompact: isCompact,
    suffixIconWidget: suffixIconWidget,
    prefixIconWidget: prefixIconWidget,
    validator: validator,
    onChanged: onChanged,
    itemList: itemList,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    inputFontSize: inputFontSize,
    inputFontColor: inputFontColor,
    keyboardType:keyboardType,
    ) :
    retCoreDropdownFieldStyle == RetCoreDropdownFieldStyle.multiple ? DropdownStyle3(
        list: itemList,
        chipsNotifier: selectedItemList!,
        label:label,
        onDeleted: onDeleted,
        onChanged: onChanged,
       isEnable: isEnabled,
       isRequired: isRequired,
       backgroundColor: backgroundColor ?? tWhite,
       suffixIconWidget: suffixIconWidget,
       suffixIcon: suffixIcon,
       iconColor: iconColor,
       iconSize: iconSize,
       labelSize: labelSize ?? tLabelSize,
       chipSize: chipSize ?? tDropDownChipSize,
       labelColor : labelColor ?? tBlack,
       isBorder: isBorder ?? true,
       borderRadius: borderRadius ?? tBorderRadiusSize,
       borderColor: borderColor ?? tGrey,
       focusedColor: focusedColor ?? tFocusedColor,
       hint: hint ?? tHintDropDown,
       chipBorderColor: chipBorderColor ?? tBlack,
       chipDeleteIconColor: chipDeleteIconColor ?? tRed,
       chipTitleFontColor: chipTitleFontColor ?? tBlack,
       chipBorderRadius: chipBorderRadius ?? tChipBorderRadius,
       chipTitleFontSize: chipTitleFontSize ?? tChipTitleFontSize,
       height: height ?? tDropDownHeightSize,
       hintFontSize: hintFontSize ?? tHintFontSize,
       contentPadding: contentPadding ?? tDropDownContentPaddingSize,
    ):
    ValueListenableBuilder(
      valueListenable: selectedItem,
      builder: (context, selectedValue, child){
        return DropdownButtonFormField(
          isExpanded: true,
          focusNode: fieldFocusNode,
          isDense: isCompact!,
          value: selectedValue,
          items: itemList.map((item) => DropdownMenuItem(
            value: item,
            alignment: itemAlignment,
            child: retCoreDropdownFieldStyle == RetCoreDropdownFieldStyle.normal ? Text(item,style: TextStyle(fontSize: itemFontSize,color: itemFontColor)) :
            retCoreDropdownFieldStyle == RetCoreDropdownFieldStyle.advanced ? DropdownStyle1(
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
          icon: suffixIconWidget ?? (suffixIcon != null ? Icon(suffixIcon, color: iconColor,size: iconSize) : null),
          dropdownColor: backgroundColor,
          decoration: InputDecoration(
            isDense: isCompact,
            prefixIcon: prefixIconWidget ?? (prefixIcon != null ? Icon(prefixIcon, color: iconColor,size: iconSize) : null),
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
            selectedItem.value = value;
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
