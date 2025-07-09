import 'package:function_system/di/article/article_use_case_provider.dart';
import 'package:function_system/domain/aricle/article_use_case.dart';
import 'package:function_system/utilities/log.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rotary_flutter/feature/monthly_letter/presentation/mapper/monthly_letter_ui_mapper.dart';
import 'package:rotary_flutter/util/board_pk.dart';

import '../../state/monthly_letter/monthly_letter_state.dart';

part 'monthly_letter_provider.g.dart';

@riverpod
class MonthlyLetter extends _$MonthlyLetter {
  late final GetArticlesUseCase _getArticlesUseCase;

  @override
  MonthlyLetterState build() {
    _getArticlesUseCase = ref.watch(getArticlesUseCaseProvider);

    Future.microtask(() => fetchData());

    return MonthlyLetterState();
  }

  Future<void> fetchData() async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final articles = await _getArticlesUseCase.execute(
        boardPk: BoardPk.monthlyLetter,
      );

      state = state.copyWith(
        monthlyLetters:
            articles.map((e) => MonthlyLetterUiMapper.toThumb(e)).toList(),
      );
    } catch (e) {
      Log.d(e.toString());
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
