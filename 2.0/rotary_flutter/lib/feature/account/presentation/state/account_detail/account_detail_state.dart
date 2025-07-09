import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/feature/model/account_thumb/account_detail_ui_model.dart';

part 'account_detail_state.freezed.dart';

@freezed
abstract class AccountDetailState with _$AccountDetailState {
  const factory AccountDetailState({
    @Default(false) bool isLoading,
    @Default(null) String? error,
    @Default(null) AccountDetailUiModel? data,
  }) = _AccountDetailState;
}