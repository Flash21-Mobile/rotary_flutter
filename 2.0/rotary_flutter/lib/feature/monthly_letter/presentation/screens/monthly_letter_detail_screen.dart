import 'package:design_system/listview/scrollable_pinch_view.dart';
import 'package:design_system/state_builder/state_builder.dart';
import 'package:design_system/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:function_system/utilities/navigation/navigation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/monthly_letter_detail/monthly_letter_detail_provider.dart';
import '../state/monthly_letter_detail/monthly_letter_detail_state.dart';

class MonthlyLetterDetailScreen extends HookConsumerWidget {
  final int id;

  const MonthlyLetterDetailScreen(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(monthlyLetterDetailProvider(id));

    final isLoading = state is MonthlyLetterDetailLoading;
    final error = state is MonthlyLetterDetailError ? state.message : null;
    final data = state is MonthlyLetterDetailSuccess ? state.imageList : null;

    print('state vv: $isLoading');

    useEffect(() {
      bool isCancelled = false;

      if (isLoading) {
        Future.delayed(const Duration(milliseconds: 15000), () {
          if (!isCancelled && isLoading) {
            context.pop();
            context.toast('인터넷을 확인해주세요');
          }
        });
      }

      return () {
        isCancelled = true; // 이전 delayed 무효화
      };
    }, [isLoading]);

    return Scaffold(
      appBar: AppBar(),
      body: StateBuilder(
        isLoading: isLoading,
        error: error,
        data: data,
        builder: (_, data) {
          return ScrollablePinchView(images: data);
        },
      ),
    );
  }
}
