import 'package:flutter/material.dart';
import 'package:retcore/retcore.dart';

class RetCoreOTPField extends StatelessWidget {
  final int length;
  final ValueChanged<String> onCompleted;
  final List<TextEditingController> _controllers = [];
  final List<FocusNode> _focusNodes = [];
  final List<String> _inputValues;

  RetCoreOTPField({required this.length, required this.onCompleted})
      : _inputValues = List.generate(length, (_) => '') {
    for (int i = 0; i < length; i++) {
      _controllers.add(TextEditingController());
      _focusNodes.add(FocusNode());
    }
  }

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
          child: RetCoreTextField(
            fieldFocusNode: _focusNodes[index],
            controller: _controllers[index],
            keyboardType: RetCoreKeyboardType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            onChanged: (value) => _onChanged(context, index, value!),
            onFieldSubmitted: (_) {
              if (index + 1 < length) {
                _focusNodes[index + 1].requestFocus();
              }
            },
            isBorder: true,
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
