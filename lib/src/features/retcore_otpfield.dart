import 'package:retcore/src/config/imports.dart';


class RetCoreOTPField extends StatelessWidget {
  final int length;
  final ValueChanged<String> onCompleted;
  final bool? isBorder;
  final double? borderRadius;
  final Color? borderColor;
  final Color? focusedColor;
  final Color? inputFontColor;
  final double? width;
  final double? inputFontSize;
  final String? hint;

  RetCoreOTPField({
    super.key,
    required this.length,
    required this.onCompleted,
    this.hint = '',
    this.isBorder = true,
    this.width = tOTPWidthSize,
    this.inputFontSize = tOTPFontSize,
    this.borderRadius = tBorderRadiusSize,
    this.inputFontColor = tBlack,
    this.borderColor = tGrey,
    this.focusedColor = tFocusedColor,
  }) : _inputValues = List.generate(length, (_) => ''),
        _controllers = List.generate(length, (_) => TextEditingController()),
        _focusNodes = List.generate(length, (_) => FocusNode());

  final List<TextEditingController> _controllers;
  final List<FocusNode> _focusNodes;
  final List<String> _inputValues;

  void _onChanged(BuildContext context, int index, String value) {
    if (value.isEmpty && _inputValues[index].isNotEmpty) {
      _onBackspace(index);
    } else {
      _inputValues[index] = value;
      if (value.isNotEmpty && index + 1 < length) {
        _focusNodes[index + 1].requestFocus();
      }
      if (_inputValues.every((element) => element.isNotEmpty)) {
        onCompleted(_inputValues.join());
      }
    }
  }

  void _onBackspace(int index) {
    if (index > 0) {
      _controllers[index].clear();
      _inputValues[index] = '';
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(length, (index) {
        return SizedBox(
          width: width,
          child: RetCoreTextField(
            fieldFocusNode: _focusNodes[index],
            controller: _controllers[index],
            keyboardType: RetCoreKeyboardType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            inputFontSize: inputFontSize,
            hint: hint,
            inputFontColor: inputFontColor,
            isBorder: isBorder,
            borderColor: borderColor,
            focusedColor: focusedColor,
            borderRadius: borderRadius,
            onChanged: (value) => _onChanged(context, index, value!),
            onFieldSubmitted: (_) {
              if (index + 1 < length) {
                _focusNodes[index + 1].requestFocus();
              }
            },
            onEditingComplete: () {
              if (_controllers[index].text.isEmpty) {
                _onBackspace(index);
              }
            },
          ),
        );
      }),
    );
  }
}