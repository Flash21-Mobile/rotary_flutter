import 'package:function_system/di/account/account_use_case_provider.dart';
import 'package:function_system/di/article/article_use_case_provider.dart';
import 'package:function_system/domain/account/usecase/account_use_case.dart';
import 'package:function_system/domain/aricle/article_use_case.dart';
import 'package:function_system/domain/board/board_type.dart';
import 'package:function_system/utilities/log.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rotary_flutter/util/board_pk.dart';

import '../../../../../core/feature/mapper/account_ui_mapper.dart';
import '../../state/account_detail/account_detail_state.dart';

part 'account_detail_provider.g.dart';

@riverpod
class AccountDetail extends _$AccountDetail {
  late GetAccountDetailUseCase _getAccountDetailUseCase;
  late GetArticlesUseCase _getArticlesUseCase;

  @override
  AccountDetailState build(int id) {
    _getAccountDetailUseCase = ref.watch(getAccountDetailUseCaseProvider);
    _getArticlesUseCase = ref.watch(getArticlesUseCaseProvider);

    Future.microtask(() {
      fetchData();
    });
    return AccountDetailState();
  }

  Future<void> fetchData() async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final account = await _getAccountDetailUseCase.execute(id);
      final advertises = await _getArticlesUseCase.execute(
        accountPk: id,
        boardPk: BoardPk.advertise,
      );

      state = state.copyWith(
        data: AccountUiMapper.toDetail(account, advertises),
      );
    } catch (e) {
      Log.d(e.toString());
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
