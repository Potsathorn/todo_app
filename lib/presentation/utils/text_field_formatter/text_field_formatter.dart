import 'package:flutter/services.dart';

class LengthLimitingTextFieldFormatterFixed
    extends LengthLimitingTextInputFormatter {
  LengthLimitingTextFieldFormatterFixed({required int maxLength})
      : super(maxLength);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newValueClean = newValue.text.replaceAll(',', '');

    if (maxLength == null || maxLength! == 0) return newValue;

    if (newValueClean.length > maxLength!) {
      return oldValue;
    }

    return newValue;
  }
}
