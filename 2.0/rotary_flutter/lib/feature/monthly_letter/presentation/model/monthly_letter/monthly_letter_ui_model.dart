import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'monthly_letter_ui_model.freezed.dart';

@freezed
abstract class MonthlyLetterUiModel with _$MonthlyLetterUiModel {
  const factory MonthlyLetterUiModel({
    required int id,
    required String title,
    required DateTime? date,
  }) = _MonthlyLetterUiModel;
}
