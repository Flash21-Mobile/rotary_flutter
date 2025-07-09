import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../feature/model/account_detail/account_thumb_ui_model.dart';

part 'account_list_state.freezed.dart';

@freezed
abstract class AccountListState with _$AccountListState {
  const factory AccountListState({
    @Default(false) bool isLoading,
    @Default(null) String? error,
    @Default([]) List<AccountThumbUiModel> accountList,
  }) = _AccountListState;
}