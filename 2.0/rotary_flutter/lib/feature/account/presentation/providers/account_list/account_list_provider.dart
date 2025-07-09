import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:function_system/di/favorite/use_case/favorite_use_case_provider.dart';
import 'package:function_system/domain/favorite/use_case/delete_favorite_use_case.dart';
import 'package:function_system/domain/favorite/use_case/set_favorite_use_case.dart';
import 'package:function_system/utilities/log.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rotary_flutter/core/provider/accountlist/account_list_provider.dart';

part 'account_list_provider.g.dart';

@riverpod
void switchFavoriteAccount(Ref ref, int id) {
  try {
    final SetFavoriteUseCase setFavoriteUseCase = ref.read(
      setFavoriteUseCaseProvider,
    );
    final DeleteFavoriteUseCase deleteFavoriteUseCase = ref.read(
      deleteFavoriteUseCaseProvider,
    );

    final accountListState = ref.watch(accountListProvider);
    final accountListNotifier = ref.read(accountListProvider.notifier);

    final currentAccount = accountListState.accountList.firstWhere(
      (e) => e.id == id,
    );

    if (currentAccount.isFavorite) {
      deleteFavoriteUseCase.execute(currentAccount.id);
    } else {
      setFavoriteUseCase.execute(currentAccount.id);
    }
    Future.microtask(() {
      accountListNotifier.setData(
        accountListState.accountList.map((e) {
          if (e.id == currentAccount.id) {
            return e.copyWith(isFavorite: !e.isFavorite);
          }
          return e;
        }).toList(),
      );
    });
  } catch (e) {
    Log.d(e);
  }
}
