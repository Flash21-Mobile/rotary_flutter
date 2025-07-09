import '../account_detail/account_thumb_ui_model.dart';

class AccountSearchUiModel {
  final int id;
  final String name;
  final String grade;
  final List<String> contents;

  const AccountSearchUiModel({
    required this.id,
    required this.name,
    required this.grade,
    required this.contents,
  });

  @override
  String toString() {
    return '$name$grade${contents.join()}';
  }
}
