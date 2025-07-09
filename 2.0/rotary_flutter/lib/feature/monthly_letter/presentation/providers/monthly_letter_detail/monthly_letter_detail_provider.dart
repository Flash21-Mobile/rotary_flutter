import 'package:function_system/di/file/file_use_case_provider.dart';
import 'package:function_system/domain/file/file_use_case.dart';
import 'package:function_system/utilities/log.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rotary_flutter/util/image_api/image_api.dart';

import '../../state/monthly_letter_detail/monthly_letter_detail_state.dart';

part 'monthly_letter_detail_provider.g.dart';

@riverpod
class MonthlyLetterDetail extends _$MonthlyLetterDetail {
    late GetUintListUseCase _getUintListUseCase;
  @override
  MonthlyLetterDetailState build(int id) {
    _getUintListUseCase = ref.watch(getUintListUseCaseProvider);
    Future.microtask(() => fetchData());

    return MonthlyLetterDetailState.initial();
  }

  Future<void> fetchData() async {
    try {
        state = MonthlyLetterDetailState.loading();

        final result = await _getUintListUseCase.execute(api: ImageApi.monthlyLetter, id: id);

        state = MonthlyLetterDetailState.success(result.map((e) => e.data).toList());
        Log.d('success');
    } catch (e) {
      Log.d(e.toString());
      state = MonthlyLetterDetailState.error(e.toString());
    }
  }
}
