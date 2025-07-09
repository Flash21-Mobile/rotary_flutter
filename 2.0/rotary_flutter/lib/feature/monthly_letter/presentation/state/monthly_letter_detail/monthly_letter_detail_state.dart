import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'monthly_letter_detail_state.freezed.dart';

@freezed
sealed class MonthlyLetterDetailState with _$MonthlyLetterDetailState {
  const factory MonthlyLetterDetailState.initial() = MonthlyLetterDetailInitial;
  const factory MonthlyLetterDetailState.loading() = MonthlyLetterDetailLoading;
  const factory MonthlyLetterDetailState.success(List<Uint8List> imageList) = MonthlyLetterDetailSuccess;
  const factory MonthlyLetterDetailState.error(String message) = MonthlyLetterDetailError;
}