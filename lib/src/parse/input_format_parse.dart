import 'package:retcore/src/config/imports.dart';

class RetCoreInputTypeParse {
  static RetCoreInputTypeParse? _instance;

  RetCoreInputTypeParse._internal();

  factory RetCoreInputTypeParse() {
    _instance ??= RetCoreInputTypeParse._internal();
    return _instance!;
  }

  static TextInputFormatter InputType({RetCoreInputType? type, int? wordLimit}) {
    final formatters = {
      RetCoreInputType.text:
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
      RetCoreInputType.double:
          FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]')),
      RetCoreInputType.int: FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      RetCoreInputType.email: FilteringTextInputFormatter.allow(
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'),
      ),
      RetCoreInputType.password: FilteringTextInputFormatter.allow(
        RegExp(
            r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>]).+$'),
      ),
      RetCoreInputType.word: WordInputFormatter(maxWords: wordLimit ?? 10),
    };

    return formatters[type] ?? FilteringTextInputFormatter.deny(RegExp(r'.'));
  }
}

class WordInputFormatter extends TextInputFormatter {
  final int maxWords;

  WordInputFormatter({this.maxWords = 10});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newWords = newValue.text
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .toList();
    if (newWords.length > maxWords) {
      return oldValue;
    }
    return newValue;
  }
}
