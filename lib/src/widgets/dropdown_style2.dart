import 'package:retcore/src/config/imports.dart';

class DropdownStyle2 extends StatelessWidget {
  DropdownStyle2(
      {
        required this.fieldFocusNode,
        required this.selectedItem,
        required this.itemList,
        this.iconColor,
        this.iconSize,
        this.hint,
        this.label,
        this.dropIconColor,
        this.backgroundColor,
        this.isBorder = true,
        this.isRequired = false,
        this.isEnabled,
        this.suffixIconWidget,
        this.prefixIconWidget,
        this.validator,
        this.onChanged,
        this.prefixIcon,
        this.suffixIcon,
        this.labelColor,
        this.labelSize,
        this.borderColor,
        this.inputFontSize,
        this.inputFontColor,
        this.keyboardType,
        this.focusedColor,
        this.borderRadius,
        this.isCompact,
        this.hintFontColor,
        this.hintFontSize,
      });

  final ValueNotifier<String?> selectedItem;
  final FocusNode fieldFocusNode;
  final String? hint;
  final String? label;
  final double? iconSize;
  final double? labelSize;
  final double? hintFontSize;
  final double? borderRadius;
  final Color? iconColor;
  final Color? borderColor;
  final Color? labelColor ;
  final Color? focusedColor;
  final Color? hintFontColor;
  final Color? dropIconColor;
  final Color? backgroundColor;
  final bool? isBorder;
  final bool? isRequired;
  final bool? isEnabled;
  final bool? isCompact;
  final Widget? suffixIconWidget;
  final Widget? prefixIconWidget;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final List<String> itemList;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final double? inputFontSize;
  final Color? inputFontColor;
  final RetCoreKeyboardType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsViewOpenDirection: OptionsViewOpenDirection.down,
      optionsBuilder: (item) {
        return itemList
            .where((String value) => value
            .toLowerCase().contains(item.text.toLowerCase())).toList();

      },
      displayStringForOption: (String value) => value,
      fieldViewBuilder: (context, TextEditingController fieldTextEditingController, fieldFocusNode, onFieldSubmitted) {
        return RetCoreTextField(
          controller: fieldTextEditingController,
          fieldFocusNode: fieldFocusNode,
          hint: hint,
          inputFontSize: inputFontSize,
          inputFontColor: inputFontColor,
          label: label,
          iconSize: iconSize,
          labelSize: labelSize,
          hintFontSize : hintFontSize,
          borderRadius: borderRadius,
          iconColor: iconColor,
          borderColor: borderColor,
          labelColor :labelColor,
          focusedColor:focusedColor,
          hintFontColor:hintFontColor,
          isBorder:isBorder,
          isRequired:isRequired,
          isCompact:isCompact,
          suffixIconWidget:suffixIconWidget,
          prefixIconWidget:prefixIconWidget,
          validator:validator,
          onChanged:onChanged,
          prefixIcon:prefixIcon,
          suffixIcon:suffixIcon,
          isEnabled: isEnabled,
          keyboardType: keyboardType,
        );
      },
      onSelected: (String value) {
        selectedItem.value = value;
      },
    );
  }
}