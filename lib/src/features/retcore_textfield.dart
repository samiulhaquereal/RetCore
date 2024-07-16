import 'dart:ffi';

import 'package:retcore/src/config/imports.dart';

class RetCoreTextField extends StatelessWidget {
  RetCoreTextField({
    super.key,
    required this.controller,
    this.isBorder = false,
    this.hint = tHint,
    this.inputFontSize = tInputFontSize,
    this.isPasswordField = false,
    this.isDatePicker = false,
    this.iconSize,
    this.iconColor,
    this.isRequired = false,
    this.isEnabled = true,
    this.labelColor = tBlack,
    this.labelSize = tLabelSize,
    this.keyboardType = RetCoreKeyboardType.text,
    this.borderColor = tGrey,
    this.inputFontColor = tBlack,
    this.focusedColor = tFocusedColor,
    this.borderRadius = tBorderRadiusSize,
    this.validator,
    this.onChanged,
    this.maxLength,
    this.maxLine,
    this.isCompact = true,
    this.label,
    this.hintFontColor = tGrey,
    this.hintFontSize = tHintFontSize,
    this.isLiveErrorTrack = false,
    this.isError = false,
    this.isReadOnly = false,
    this.inititalDate,
    this.startingDate,
    this.endingDate,
    this.inputFormatters,
    this.liveErrorMessage = tWrong,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconWidget,
    this.prefixIconWidget,
    this.fieldFocusNode,
  }) {
    controller.addListener(() {
      if (onChanged != null) {
        onChanged!(controller.text);
      }
    });
  }

  final String? hint;
  final String? label;
  final String? liveErrorMessage;
  final int? maxLength;
  final int? maxLine;
  final double? iconSize;
  final double? labelSize;
  final double? inputFontSize;
  final double? hintFontSize;
  final double? borderRadius;
  final Color? iconColor;
  final Color? borderColor;
  final Color? labelColor;
  final Color? focusedColor;
  final Color? inputFontColor;
  final Color? hintFontColor;
  final bool? isBorder;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool? isPasswordField;
  final bool? isRequired;
  final bool? isEnabled;
  final bool? isCompact;
  final bool? isError;
  final bool? isLiveErrorTrack;
  final bool? isDatePicker;
  final bool? isReadOnly;
  final Widget? suffixIconWidget;
  final Widget? prefixIconWidget;
  final RetCoreKeyboardType? keyboardType;
  final TextEditingController controller;
  final ValueNotifier<bool> _obscureText = ValueNotifier<bool>(true);
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final DateTime? inititalDate;
  final DateTime? startingDate;
  final DateTime? endingDate;
  final FocusNode? fieldFocusNode;
  final List<TextInputFormatter>? inputFormatters;


  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> _isPasswordEightCharacters = ValueNotifier<bool>(false);
    final ValueNotifier<bool> _hasPasswordOneNumber = ValueNotifier<bool>(false);
    final ValueNotifier<bool> _hasUpperCase = ValueNotifier<bool>(false);
    final ValueNotifier<bool> _hasLowerCase = ValueNotifier<bool>(false);
    final ValueNotifier<bool> _hasSpecialCharacter = ValueNotifier<bool>(false);

    return Column(
      children: [
        ValueListenableBuilder(
          valueListenable: _obscureText,
          builder: (BuildContext context, value, Widget? child) {
            return TextFormField(
              textInputAction: TextInputAction.next,
              inputFormatters: inputFormatters,
              style: TextStyle(fontSize: inputFontSize, color: inputFontColor),
              controller: controller,
              obscureText: isPasswordField == true ? _obscureText.value : false,
              keyboardType: RetCore.parseKeyboardType(type: keyboardType),
              enabled: isEnabled,
              readOnly: isReadOnly!,
              maxLength: maxLength,
              maxLines: maxLine ?? tMaxLine,
              decoration: InputDecoration(
                isDense: isCompact,
                errorText: isLiveErrorTrack == true
                    ? isError == true
                        ? liveErrorMessage
                        : null
                    : null,
                suffixIcon: isDatePicker == true
                    ? IconButton(
                        onPressed: () async {
                          final DateTime? datetime = await showDatePicker(
                            context: context,
                            initialDate: inititalDate ?? DateTime.now(),
                            firstDate: startingDate ?? DateTime(1500),
                            lastDate: endingDate ?? DateTime(3000),
                          );
                          if (datetime != null) {
                            controller.text = "${datetime.toLocal()}".split(' ')[0];
                          }
                        },
                        icon: suffixIconWidget ??
                            (suffixIcon != null
                                ? Icon(suffixIcon, size: iconSize, color: iconColor)
                                : Icon(Icons.calendar_month,
                                    size: iconSize, color: iconColor)),
                      )
                    : isPasswordField == true
                        ? IconButton(
                            color: iconColor,
                            onPressed: () {
                              _obscureText.value = !_obscureText.value;
                            },
                            icon: Icon(
                              _obscureText.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: iconSize,
                              color: iconColor,
                            ),
                          )
                        : (suffixIconWidget ??
                            (suffixIcon != null
                                ? Icon(suffixIcon, size: iconSize, color: iconColor) : null)),
                prefixIcon: prefixIconWidget ??
                    (prefixIcon != null
                        ? Icon(prefixIcon, color: iconColor, size: iconSize)
                        : null),
                enabledBorder: isBorder == true
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius!),
                        borderSide: BorderSide(color: borderColor!))
                    : UnderlineInputBorder(
                        borderSide: BorderSide(color: borderColor!)),
                focusedBorder: isBorder == true
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius!),
                        borderSide: BorderSide(color: focusedColor!))
                    : UnderlineInputBorder(
                        borderSide: BorderSide(color: focusedColor!)),
                errorBorder: isBorder == true
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius!),
                        borderSide: const BorderSide(color: tRed))
                    : const UnderlineInputBorder(
                        borderSide: BorderSide(color: tRed)),
                focusedErrorBorder: isBorder == true
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius!),
                        borderSide: const BorderSide(color: tRed))
                    : const UnderlineInputBorder(
                        borderSide: BorderSide(color: tRed)),
                hintText: hint,
                hintStyle: TextStyle(fontSize: hintFontSize, color: hintFontColor),
                label: label == null
                    ? null
                    : RichText(
                        text: TextSpan(
                          text: '$label ',
                          style: TextStyle(fontSize: labelSize, color: labelColor),
                          children: [
                            TextSpan(
                              text: isRequired == true ? '*' : '',
                              style:
                                  TextStyle(fontSize: labelSize! + 3, color: tRed),
                            ),
                          ],
                        ),
                      ),
              ),
              validator: isRequired == true ? validator : null,
              onChanged: isPasswordField == true ? (password){
                _isPasswordEightCharacters.value = password.length >= 8;
                _hasPasswordOneNumber.value = RegExp(r'[0-9]').hasMatch(password);
                _hasUpperCase.value = RegExp(r'[A-Z]').hasMatch(password);
                _hasLowerCase.value = RegExp(r'[a-z]').hasMatch(password);
                _hasSpecialCharacter.value = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
              }: onChanged,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              focusNode: fieldFocusNode,
            );
          },
        ),
        isPasswordField == true ? Column(
         children: [
           RetCore.space(20),
           ValueListenableBuilder(
             valueListenable: _isPasswordEightCharacters,
             builder: (BuildContext context, value, Widget? child) {
               return validation_checkList(
                 text: 'Contains at least 8 characters',
                 isValid: _isPasswordEightCharacters.value,
               );
             },
           ),
           RetCore.space(10),
           ValueListenableBuilder(
             valueListenable: _hasPasswordOneNumber,
             builder: (BuildContext context, value, Widget? child) {
               return validation_checkList(
                 text: 'Contains at least 1 number',
                 isValid: _hasPasswordOneNumber.value,
               );
             },
           ),
           RetCore.space(10),
           ValueListenableBuilder(
             valueListenable: _hasUpperCase,
             builder: (BuildContext context, value, Widget? child) {
               return validation_checkList(
                 text: 'Contains at least 1 uppercase letter',
                 isValid: _hasUpperCase.value,
               );
             },
           ),
           RetCore.space(10),
           ValueListenableBuilder(
             valueListenable: _hasLowerCase,
             builder: (BuildContext context, value, Widget? child) {
               return validation_checkList(
                 text: 'Contains at least 1 lowercase letter',
                 isValid: _hasLowerCase.value,
               );
             },
           ),
         ],
       ) : const SizedBox()
      ],
    );
  }
}

class validation_checkList extends StatelessWidget {
  const validation_checkList({
    super.key,
    required this.text,
    required this.isValid,
  });

  final bool isValid;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: isValid ? Colors.green : Colors.red,
            border: isValid
                ? Border.all(color: Colors.transparent)
                : Border.all(color: Colors.red),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Icon(
              isValid ? Icons.check : Icons.close,
              color: Colors.white,
              size: 15,
            ),
          ),
        ),
        RetCore.space(10),
        Text(text),
      ],
    );
  }
}