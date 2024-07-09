import 'package:flutter/material.dart';
import 'package:retcore/retcore.dart';

class SearchBoxWidget extends StatelessWidget {
  SearchBoxWidget(
      {
        super.key,
        this.isPrefixIcon,
        this.iconColor,
        this.iconSize,
        this.icon,
        required this.itemList
      });

  final List<String> itemList;
  final bool? isPrefixIcon;
  final Color? iconColor;
  final double? iconSize;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsViewOpenDirection: OptionsViewOpenDirection.down,
      optionsBuilder: (textEditingValue) {
        return itemList
            .where((String country) => country
            .toLowerCase().contains(textEditingValue.text.toLowerCase())).toList();
      },
      displayStringForOption: (String country) => country,
      fieldViewBuilder: (context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted) {
        return /*TextField(
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          decoration: InputDecoration(
            prefixIcon: isPrefixIcon == true
                ? Icon(icon, size: iconSize, color: iconColor)
                : null,
            //border: OutlineInputBorder(),
            hintText: 'Select Country',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.green)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.yellow)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.red)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.red)),
          ),
          controller: fieldTextEditingController,
          focusNode: fieldFocusNode,
          style: const TextStyle(fontWeight: FontWeight.bold),
        )*/RetCoreTextField(
          controller: fieldTextEditingController,
          isBorder: true,

        );
      },
      onSelected: (String selection) {
        print('Selected: $selection');
      },
    );
  }
}