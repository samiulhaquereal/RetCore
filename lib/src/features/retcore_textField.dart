import 'package:retcore/src/config/imports.dart';

class RetCoreTextField extends StatelessWidget {
  RetCoreTextField({
    super.key,
    required this.controller,
    required this.isBorder,
    this.hint = tHint,
    this.icon,
    this.isPrefixIcon,
    this.isSuffixIcon,
    this.inputFontSize = tInputFontSize,
    this.isPasswordField = false,
    this.isDatePicker = false,
    this.iconSize,
    this.iconColor,
    this.isRequired = false,
    this.isEnabled  = true,
    this.labelColor = tBlack,
    this.labelSize = tLabelSize,
    this.keyboardType = TextInputType.text,
    this.borderColor = tGrey,
    this.inputFontColor = tBlack,
    this.focusedColor = tFocusedColor,
    this.borderRadius = tBorderRadiusSize,
    this.validator,
    this.onChanged,
    this.maxLength,
    this.maxLine,
    this.isMaxLines,
    this.isMaxLength,
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
    this.iconWidget ,
    this.inputFormatters ,
    this.liveErrorMessage = tWrong,
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
  final bool isBorder;
  final bool? isPrefixIcon;
  final bool? isSuffixIcon;
  final bool? isPasswordField;
  final bool? isRequired;
  final bool? isEnabled;
  final bool? isCompact;
  final bool? isError;
  final bool? isLiveErrorTrack;
  final bool? isMaxLength;
  final bool? isMaxLines;
  final bool? isDatePicker;
  final bool? isReadOnly;
  final IconData? icon;
  final Widget? iconWidget;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final ValueNotifier<bool> _obscureText = ValueNotifier<bool>(true);
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final DateTime? inititalDate;
  final DateTime? startingDate;
  final DateTime? endingDate;
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
          keyboardType: keyboardType,
          enabled: isEnabled,
          readOnly: isReadOnly!,
          maxLength: isMaxLength == true ? maxLength : null,
          maxLines: isMaxLines == true ? maxLine : 1,
          decoration: InputDecoration(
            isDense: isCompact,
            errorText: isLiveErrorTrack == true ? isError == true ? liveErrorMessage : null : null,
            suffixIcon: isSuffixIcon == true ? iconWidget ?? Icon(icon, size: iconSize, color: iconColor) : isPasswordField == true ? IconButton(
              color: iconColor,
              onPressed: () {
                _obscureText.value == true ? _obscureText.value = false : _obscureText.value = true ;
              },
              icon: Icon(_obscureText.value == true ? Icons.visibility_off : Icons.visibility),
            ) : isDatePicker == true ? IconButton(onPressed: ()async{
              final DateTime? datetime = await showDatePicker(
                  context: context,
                  initialDate: inititalDate ?? DateTime.now(),
                  firstDate: startingDate ?? DateTime(1500),
                  lastDate: endingDate ?? DateTime(3000)
              );
              if (datetime != null){
                controller.text = "${datetime.toLocal()}".split(' ')[0].toString();
              }
            }, icon: const Icon(Icons.calendar_month)) : null,
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
          onChanged: onChanged,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
        ) ;
      },
    );
  }
}