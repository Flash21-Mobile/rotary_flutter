import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../model/monthly_letter/monthly_letter_ui_model.dart';

part 'monthly_letter_state.freezed.dart';

@freezed
abstract class MonthlyLetterState with _$MonthlyLetterState {
  const factory MonthlyLetterState({
    @Default(false) bool isLoading,
    @Default(null) String? error,
    @Default([]) List<MonthlyLetterUiModel> monthlyLetters,
  }) = _MonthlyLetterState;
}