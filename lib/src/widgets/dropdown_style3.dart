import 'package:retcore/src/config/imports.dart';

class DropdownStyle3 extends StatelessWidget {
  const DropdownStyle3({
    super.key,
    required this.list,
    required this.chipsNotifier,
    this.label,
    this.onDeleted,
    this.isEnable,
    this.onChanged,
    this.suffixIconWidget,
    this.suffixIcon,
    this.isRequired = false,
    this.backgroundColor = tWhite,
    this.iconColor,
    this.iconSize,
    this.labelSize = tLabelSize,
    this.labelColor = tBlack,
    this.isBorder = true,
    this.borderRadius = tBorderRadiusSize,
    this.borderColor = tGrey,
    this.focusedColor = tFocusedColor,
    this.hint = tHintDropDown,
    this.chipSize = tDropDownChipSize,
    this.chipBorderColor = tBlack,
    this.chipDeleteIconColor = tRed,
    this.chipTitleFontColor = tBlack,
    this.chipBorderRadius = tChipBorderRadius,
    this.chipTitleFontSize = tChipTitleFontSize,
    this.height = tDropDownHeightSize,
    this.hintFontSize = tHintFontSize,
    this.contentPadding = tDropDownContentPaddingSize,
  });

  final String? label;
  final List<String> list;
  final ValueNotifier<List<String>> chipsNotifier;
  final void Function(String)? onDeleted;
  final void Function(String)? onChanged;
  final bool? isEnable;
  final bool? isRequired;
  final Color? backgroundColor;
  final Widget? suffixIconWidget;
  final IconData? suffixIcon;
  final Color? iconColor;
  final double? iconSize;
  final double? labelSize;
  final double? chipSize;
  final Color? labelColor ;
  final bool? isBorder;
  final double? borderRadius;
  final Color? borderColor;
  final Color? focusedColor;
  final String? hint;
  final Color? chipBorderColor;
  final Color? chipDeleteIconColor;
  final Color? chipTitleFontColor;
  final double? chipBorderRadius;
  final double? chipTitleFontSize;
  final double? height;
  final double? hintFontSize;
  final double? contentPadding;


  void _addChip(String chip) {
    if (chip.isNotEmpty && !chipsNotifier.value.contains(chip)) {
      chipsNotifier.value = [...chipsNotifier.value, chip];
    }
  }

  void _deleteChip(String chip) {
    chipsNotifier.value = chipsNotifier.value.where((c) => c != chip).toList();
    if (onDeleted != null) {
      onDeleted!(chip);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<String>>(
      valueListenable: chipsNotifier,
      builder: (context, chipsList, _) {
        return InputDecorator(
          decoration: InputDecoration(
            enabled: isEnable ?? true,
            suffixIcon: suffixIconWidget ?? (suffixIcon != null ? Icon(suffixIcon, color: iconColor,size: iconSize) : null),
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
            ), // labelText: widget.title,
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
            contentPadding: EdgeInsets.symmetric(vertical: contentPadding!, horizontal: contentPadding!),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: chipsList.map((chip) {
                    return SizedBox(
                      height: chipSize,
                      child: Chip(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: chipBorderColor!), // Set border color to red
                          borderRadius: BorderRadius.circular(chipBorderRadius!),
                        ),
                        deleteIconColor: chipDeleteIconColor,
                        padding: EdgeInsets.zero,
                        label: Text(chip),
                        labelStyle: TextStyle(fontSize: chipTitleFontSize,color: chipTitleFontColor),
                        onDeleted: () {
                          _deleteChip(chip);
                        },
                      ),
                    );
                  }).toList(),
                ),
                RetCore.space(7),
                SizedBox(
                    width: RetCore.width(),
                    height: height,
                    child: DropdownButtonFormField(
                      dropdownColor: backgroundColor,
                      icon: const SizedBox.shrink(), // This removes the dropdown icon
                      isExpanded: true,
                      decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: TextStyle(fontSize: hintFontSize),
                        border: InputBorder.none, // This removes the border
                        enabledBorder: InputBorder.none, // This removes the border when enabled
                        focusedBorder: InputBorder.none, // This removes the border when focused
                      ),
                      onChanged: (String? value) {
                        if (value != null) {
                          _addChip(value);
                          if (onChanged != null) {
                            onChanged!(value);
                          }
                        }
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      selectedItemBuilder: (_) {
                        return list.map((item) {return Text(chipsNotifier.value.isEmpty ? hint ?? tHintDropDown : '');}).toList();
                      },
                    )
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}