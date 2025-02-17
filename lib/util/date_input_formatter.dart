import 'package:flutter/services.dart';

class DateTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    // 숫자와 `-`만 허용
    newText = newText.replaceAll(RegExp(r'[^0-9-]'), '');

    // yyyy-MM-dd 형식 유지 (8자리 이상 입력 방지)
    if (newText.length > 10) {
      newText = newText.substring(0, 10);
    }

    // 자동으로 `-` 삽입
    if (newText.length >= 5 && newText[4] != '. ') {
      newText = newText.substring(0, 4) + '-' + newText.substring(4);
    }
    if (newText.length >= 8 && newText[7] != '. ') {
      newText = newText.substring(0, 7) + '-' + newText.substring(7);
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}