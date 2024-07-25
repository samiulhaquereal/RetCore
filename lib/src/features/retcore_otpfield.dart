import 'package:retcore/src/config/imports.dart';

class RetCoreOTPField extends StatelessWidget {

  RetCoreOTPField({
    required this.length,
    required this.onCompleted,
    this.isBorder,
    this.borderRadius = tBorderRadiusSize,
    this.focusedColor = tFocusedColor,
    this.borderColor = tGrey,
  })
      : _inputValues = List.generate(length, (_) => '') {
    for (int i = 0; i < length; i++) {
      _controllers.add(TextEditingController());
      _focusNodes.add(FocusNode());
    }
  }

  final int length;
  final ValueChanged<String> onCompleted;
  final List<TextEditingController> _controllers = [];
  final List<FocusNode> _focusNodes = [];
  final List<String> _inputValues;
  final bool? isBorder;
  final double? borderRadius;
  final Color? borderColor;
  final Color? focusedColor;

  void _onChanged(BuildContext context, int index, String value) {
    if (value.isNotEmpty) {
      _inputValues[index] = value;
      if (index + 1 < length) {
        _focusNodes[index + 1].requestFocus();
      } else {
        onCompleted(_inputValues.join());
      }
    } else {
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
        _controllers[index - 1].clear();
      }
    }
  }

  void _onBackspace(int index) {
    if (index > 0) {
      _focusNodes[index - 1].requestFocus();
      _controllers[index - 1].clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(length, (index) {
        return SizedBox(
          width: 40,
          child: TextField(
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            focusNode: _focusNodes[index],
            controller: _controllers[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            onChanged: (value) => _onChanged(context, index, value),
            onSubmitted: (_) {
              if (index + 1 < length) {
                _focusNodes[index + 1].requestFocus();
              }
            },
            decoration: InputDecoration(
              counterText: '',
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
            ),
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
