import 'package:retcore/src/config/imports.dart';

class RetCoreTextField extends StatelessWidget {
  RetCoreTextField({
    super.key,
    required this.controller,
    this.isBorder = false ,
    this.hint = tHint,
    this.inputFontSize = tInputFontSize,
    this.isPasswordField = false,
    this.isDatePicker = false,
    this.iconSize,
    this.iconColor,
    this.isRequired = false,
    this.isEnabled  = true,
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
    this.inititalDate ,
    this.startingDate ,
    this.endingDate ,
    this.inputFormatters ,
    this.liveErrorMessage = tWrong,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconWidget,
    this.prefixIconWidget,
    this.fieldFocusNode,
  }){
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
  final Color? labelColor ;
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
    return ValueListenableBuilder(
      valueListenable: _obscureText,
      builder: (BuildContext context, value, Widget? child) {
        return TextFormField(
          textInputAction: TextInputAction.next,
          inputFormatters: inputFormatters,
          style: TextStyle(fontSize: inputFontSize,color: inputFontColor),
          controller: controller,
          obscureText: isPasswordField == true ? _obscureText.value : false,
          keyboardType: RetCore.parseKeyboardType(type: keyboardType),
          enabled: isEnabled,
          readOnly: isReadOnly!,
          maxLength: maxLength,
          maxLines: maxLine ?? tMaxLine,
          decoration: InputDecoration(
            isDense: isCompact,
            errorText: isLiveErrorTrack == true ? isError == true ? liveErrorMessage : null : null,
            suffixIcon: isDatePicker == true || isPasswordField == true ? null : suffixIconWidget ?? (suffixIcon != null ? Icon(suffixIcon, size: iconSize, color: iconColor) :
            isPasswordField == true ? IconButton(
              color: iconColor,
              onPressed: () {
                _obscureText.value == true ? _obscureText.value = false : _obscureText.value = true ;
              },
              icon: suffixIcon != null ? Icon(suffixIcon, size: iconSize, color: iconColor) : Icon(_obscureText.value == true ? Icons.visibility_off : Icons.visibility , size: iconSize, color: iconColor),
            ) : isDatePicker == true ? IconButton(
                onPressed: ()async{
              final DateTime? datetime = await showDatePicker(
                  context: context,
                  initialDate: inititalDate ?? DateTime.now(),
                  firstDate: startingDate ?? DateTime(1500),
                  lastDate: endingDate ?? DateTime(3000)
              );
              if (datetime != null){
                controller.text = "${datetime.toLocal()}".split(' ')[0].toString();
              }
            }, icon: suffixIconWidget ?? (suffixIcon != null ? Icon(suffixIcon, size: iconSize, color: iconColor) : Icon(Icons.calendar_month, size: iconSize, color: iconColor))) : null),
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
          onChanged: onChanged,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          focusNode: fieldFocusNode,
        ) ;
      },
    );
  }
}