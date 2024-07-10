import 'package:retcore/src/config/imports.dart';

class RetCoreChipInputField extends StatefulWidget {
  RetCoreChipInputField({
    super.key,
    required this.chipsList,
    this.title,
    this.hint = tHint,
    this.keyboardType = RetCoreKeyboardType.text,
    this.isRequired = false,
    this.onDeleted,
    this.onFieldSubmitted,
    this.isCompact = true,
    this.label,
    this.liveErrorMessage = tWrong,
    this.labelSize = tLabelSize,
    this.hintFontSize = tHintFontSize,
    this.borderRadius = tBorderRadiusSize,
    this.borderColor = tGrey,
    this.labelColor = tBlack,
    this.focusedColor = tFocusedColor,
    this.hintFontColor = tGrey,
    this.isBorder = false,
    this.isEnabled = true,
    this.isError = false,
    this.isLiveErrorTrack = false,
    this.validator,
    this.onChanged,
    this.inputFormatters,
    this.chipBorderColor = tBlack,
    this.chipDeleteIconColor = tRed,
    this.chipTitleFontColor = tBlack,
    this.inputChipFontColor = tBlack,
    this.chipBorderRadius = tChipBorderRadius,
    this.chipTitleFontSize = tChipTitleFontSize,
    this.inputChipFontSize = tInputFontSize,
    this.chipSize = tChipSize,
  });

  final String? title;
  final String? hint;
  final RetCoreKeyboardType? keyboardType;
  final bool? isRequired;
  final List<dynamic> chipsList;
  final void Function(String)? onDeleted;
  final void Function(String)? onFieldSubmitted;
  final String? label;
  final String? liveErrorMessage;
  final double? labelSize;
  final double? hintFontSize;
  final double? borderRadius;
  final Color? borderColor;
  final Color? labelColor ;
  final Color? focusedColor;
  final Color? hintFontColor;
  final bool? isBorder;
  final bool? isEnabled;
  final bool? isCompact;
  final bool? isError;
  final bool? isLiveErrorTrack;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final Color? chipBorderColor;
  final Color? chipDeleteIconColor;
  final Color? chipTitleFontColor;
  final Color? inputChipFontColor;
  final double? chipBorderRadius;
  final double? chipTitleFontSize;
  final double? inputChipFontSize;
  final double? chipSize;

  @override
  _ChipInputFieldState createState() => _ChipInputFieldState();
}

class _ChipInputFieldState extends State<RetCoreChipInputField> {
  final TextEditingController inputChipText = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return InputDecorator(
      decoration: InputDecoration(
        enabled: widget.isEnabled!,
        hintText: widget.hint,
        hintStyle: TextStyle(fontSize: widget.hintFontSize,color: widget.hintFontColor),
        isDense: widget.isCompact,
        //errorText: isValid == false ? '*Required' : null,
        errorText: widget.isLiveErrorTrack == true ? widget.isError == true ? widget.liveErrorMessage : null : null,
        label: widget.label == null ? null : RichText(
          text: TextSpan(
            text: '${widget.label} ',
            style: TextStyle(fontSize: widget.labelSize, color: widget.labelColor),
            children: [
              TextSpan(
                text: widget.isRequired == true ? '*' : '',
                style: TextStyle(fontSize: widget.labelSize!+3,color: tRed),
              ),
            ],
          ),
        ),
        //labelStyle: TextStyle(fontSize: 7, color: tBlack),
        enabledBorder: widget.isBorder == true ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius!),
            borderSide: BorderSide(color: widget.borderColor!))
            : UnderlineInputBorder(
            borderSide: BorderSide(color: widget.borderColor!)),
        focusedBorder: widget.isBorder == true ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius!),
            borderSide: BorderSide(color: widget.focusedColor!))
            : UnderlineInputBorder(
            borderSide: BorderSide(color: widget.focusedColor!)),
        errorBorder: widget.isBorder == true ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius!),
            borderSide: const BorderSide(color: tRed))
            : const UnderlineInputBorder(borderSide: BorderSide(color: tRed)),
        focusedErrorBorder: widget.isBorder == true ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius!),
            borderSide: const BorderSide(color: tRed))
            : const UnderlineInputBorder(borderSide: BorderSide(color: tRed)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: widget.chipsList.map((chip) {
                return SizedBox(
                  height: widget.chipSize!,
                  child: Chip(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: widget.chipBorderColor!), // Set border color to red
                      borderRadius: BorderRadius.circular(widget.chipBorderRadius!),
                    ),
                    deleteIconColor: widget.chipDeleteIconColor!,
                    padding: EdgeInsets.zero,
                    label: Text(chip),
                    labelStyle: TextStyle(fontSize: widget.chipTitleFontSize,color: widget.chipTitleFontColor),
                    onDeleted: () {
                      setState(() {
                        widget.chipsList.remove(chip);
                        if (widget.onDeleted != null) {
                          widget.onDeleted!(chip);
                        }
                      });
                    },
                  ),
                );
              }).toList(),
            ),
            RetCore.space(7),
            SizedBox(
              width: RetCore.width(),
              child: TextFormField(
                keyboardType: RetCore.parseKeyboardType(type: widget.keyboardType),
                inputFormatters: widget.inputFormatters,
                controller: inputChipText,
                style: TextStyle(fontSize: widget.inputChipFontSize,color: widget.inputChipFontColor),
                enabled: widget.isEnabled,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                validator: widget.isRequired == true ? widget.validator : null,
                onChanged: widget.onChanged,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                onFieldSubmitted: (value) {
                  _addChip(value);
                  if (widget.onFieldSubmitted != null) {
                    widget.onFieldSubmitted!(value);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addChip(String chip) {
    if (chip.isNotEmpty && !widget.chipsList.contains(chip)) {
      setState(() {
        widget.chipsList.add(chip);
        inputChipText.clear();
      });
    }
  }
}