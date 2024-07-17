import 'package:retcore/src/config/imports.dart';

class PasswordValidation extends StatelessWidget {
  const PasswordValidation({
    super.key,
    required ValueNotifier<bool> isPasswordEightCharacters,
    required this.passwordCheckListTextSize,
    required this.passwordCheckListTextFontWeight,
    required this.passwordCheckListIconWidth,
    required this.passwordCheckListIconHeight,
    required this.passwordCheckListRadius,
    required this.passwordCheckListIconSize,
    required this.passwordCheckListValidColor,
    required this.passwordCheckListInvalidColor,
    required this.passwordCheckListValidBorderColor,
    required this.passwordCheckListInvalidBorderColor,
    required this.passwordCheckListIconColor,
    required this.passwordCheckListTextColor,
    required this.passwordCheckListValidIcon,
    required this.passwordCheckListInvalidIcon,
    required ValueNotifier<bool> hasUpperCase,
    required ValueNotifier<bool> hasLowerCase,
    required ValueNotifier<bool> hasPasswordOneNumber,
    required ValueNotifier<bool> hasSpecialCharacter,
  }) : _isPasswordEightCharacters = isPasswordEightCharacters,
        _hasUpperCase = hasUpperCase,
        _hasLowerCase = hasLowerCase,
        _hasPasswordOneNumber = hasPasswordOneNumber,
        _hasSpecialCharacter = hasSpecialCharacter;

  final ValueNotifier<bool> _isPasswordEightCharacters;
  final double? passwordCheckListTextSize;
  final FontWeight? passwordCheckListTextFontWeight;
  final double? passwordCheckListIconWidth;
  final double? passwordCheckListIconHeight;
  final double? passwordCheckListRadius;
  final double? passwordCheckListIconSize;
  final Color? passwordCheckListValidColor;
  final Color? passwordCheckListInvalidColor;
  final Color? passwordCheckListValidBorderColor;
  final Color? passwordCheckListInvalidBorderColor;
  final Color? passwordCheckListIconColor;
  final Color? passwordCheckListTextColor;
  final IconData? passwordCheckListValidIcon;
  final IconData? passwordCheckListInvalidIcon;
  final ValueNotifier<bool> _hasUpperCase;
  final ValueNotifier<bool> _hasLowerCase;
  final ValueNotifier<bool> _hasPasswordOneNumber;
  final ValueNotifier<bool> _hasSpecialCharacter;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: RetCore.width(),
      child: Column(
        children: [
          RetCore.space(25),
          ValueListenableBuilder(
            valueListenable: _isPasswordEightCharacters,
            builder: (BuildContext context, value, Widget? child) {
              return ValidationCheckList(
                text: 'At least 8 Characters',
                isValid: _isPasswordEightCharacters.value,
                textSize: passwordCheckListTextSize,
                textFontWeight: passwordCheckListTextFontWeight,
                width: passwordCheckListIconWidth,
                height: passwordCheckListIconHeight,
                radius: passwordCheckListRadius,
                iconSize: passwordCheckListIconSize,
                validColor: passwordCheckListValidColor,
                invalidColor: passwordCheckListInvalidColor,
                validBorderColor: passwordCheckListValidBorderColor,
                invalidBorderColor: passwordCheckListInvalidBorderColor,
                iconColor: passwordCheckListIconColor,
                textColor: passwordCheckListTextColor,
                validIcon: passwordCheckListValidIcon,
                invalidIcon: passwordCheckListInvalidIcon,
              );
            },
          ),
          RetCore.space(10),
          ValueListenableBuilder(
            valueListenable: _hasUpperCase,
            builder: (BuildContext context, value, Widget? child) {
              return ValidationCheckList(
                text: 'Upper case letters (A-Z)',
                isValid: _hasUpperCase.value,
                textSize: passwordCheckListTextSize,
                textFontWeight: passwordCheckListTextFontWeight,
                width: passwordCheckListIconWidth,
                height: passwordCheckListIconHeight,
                radius: passwordCheckListRadius,
                iconSize: passwordCheckListIconSize,
                validColor: passwordCheckListValidColor,
                invalidColor: passwordCheckListInvalidColor,
                validBorderColor: passwordCheckListValidBorderColor,
                invalidBorderColor: passwordCheckListInvalidBorderColor,
                iconColor: passwordCheckListIconColor,
                textColor: passwordCheckListTextColor,
                validIcon: passwordCheckListValidIcon,
                invalidIcon: passwordCheckListInvalidIcon,
              );
            },
          ),
          RetCore.space(10),
          ValueListenableBuilder(
            valueListenable: _hasLowerCase,
            builder: (BuildContext context, value, Widget? child) {
              return ValidationCheckList(
                text: 'Lower case letters (a-z)',
                isValid: _hasLowerCase.value,
                textSize: passwordCheckListTextSize,
                textFontWeight: passwordCheckListTextFontWeight,
                width: passwordCheckListIconWidth,
                height: passwordCheckListIconHeight,
                radius: passwordCheckListRadius,
                iconSize: passwordCheckListIconSize,
                validColor: passwordCheckListValidColor,
                invalidColor: passwordCheckListInvalidColor,
                validBorderColor: passwordCheckListValidBorderColor,
                invalidBorderColor: passwordCheckListInvalidBorderColor,
                iconColor: passwordCheckListIconColor,
                textColor: passwordCheckListTextColor,
                validIcon: passwordCheckListValidIcon,
                invalidIcon: passwordCheckListInvalidIcon,
              );
            },
          ),
          RetCore.space(10),
          ValueListenableBuilder(
            valueListenable: _hasPasswordOneNumber,
            builder: (BuildContext context, value, Widget? child) {
              return ValidationCheckList(
                text: 'At least one numbers (0-9)',
                isValid: _hasPasswordOneNumber.value,
                textSize: passwordCheckListTextSize,
                textFontWeight: passwordCheckListTextFontWeight,
                width: passwordCheckListIconWidth,
                height: passwordCheckListIconHeight,
                radius: passwordCheckListRadius,
                iconSize: passwordCheckListIconSize,
                validColor: passwordCheckListValidColor,
                invalidColor: passwordCheckListInvalidColor,
                validBorderColor: passwordCheckListValidBorderColor,
                invalidBorderColor: passwordCheckListInvalidBorderColor,
                iconColor: passwordCheckListIconColor,
                textColor: passwordCheckListTextColor,
                validIcon: passwordCheckListValidIcon,
                invalidIcon: passwordCheckListInvalidIcon,
              );
            },
          ),
          RetCore.space(10),
          ValueListenableBuilder(
            valueListenable: _hasSpecialCharacter,
            builder: (BuildContext context, value, Widget? child) {
              return ValidationCheckList(
                text: 'Special characters (ex. !@#\$%^&*)',
                isValid: _hasSpecialCharacter.value,
                textSize: passwordCheckListTextSize,
                textFontWeight: passwordCheckListTextFontWeight,
                width: passwordCheckListIconWidth,
                height: passwordCheckListIconHeight,
                radius: passwordCheckListRadius,
                iconSize: passwordCheckListIconSize,
                validColor: passwordCheckListValidColor,
                invalidColor: passwordCheckListInvalidColor,
                validBorderColor: passwordCheckListValidBorderColor,
                invalidBorderColor: passwordCheckListInvalidBorderColor,
                iconColor: passwordCheckListIconColor,
                textColor: passwordCheckListTextColor,
                validIcon: passwordCheckListValidIcon,
                invalidIcon: passwordCheckListInvalidIcon,
              );
            },
          ),
        ],
      ),
    );
  }
}