import 'package:function_system/di/account/account_use_case_provider.dart';
import 'package:function_system/utilities/log.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rotary_flutter/core/state/accountlist/account_list_state.dart';

import '../../feature/mapper/account_ui_mapper.dart';
import '../../feature/model/account_detail/account_thumb_ui_model.dart';

part 'account_list_provider.g.dart';

@Riverpod(keepAlive: true)
class AccountList extends _$AccountList {
  @override
  AccountListState build() {
    return AccountListState();
  }

  Future fetchData() async => _fetchData();

  Future _fetchData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final getAccountsUseCase = ref.watch(getAccountsUseCaseProvider);

      final result = await getAccountsUseCase.execute();

      state = state.copyWith(
        isLoading: false,
        accountList: result.map((e) => AccountUiMapper.toThumb(e)).toList(),
      );
    } catch (e) {
      Log.e(e.toString());
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void setData(List<AccountThumbUiModel> data) {
    state = state.copyWith(accountList: data);
  }
}
