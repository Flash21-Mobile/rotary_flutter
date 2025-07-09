import 'package:core_system/app/style/app_style.dart';
import 'package:design_system/animate/ink_well.dart';
import 'package:design_system/appbar/app_bar.dart';
import 'package:design_system/appbar/app_bar_bottom.dart';
import 'package:design_system/listview/list_view.dart';
import 'package:design_system/scaffold/scaffold.dart';
import 'package:design_system/state_builder/state_builder.dart';
import 'package:design_system/text/text_interface.dart';
import 'package:design_system/textfield/index_search_box.dart';
import 'package:design_system/utilities/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:function_system/utilities/navigation/navigation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rotary_flutter/feature/monthly_letter/presentation/model/monthly_letter/monthly_letter_ui_model.dart';
import 'package:rotary_flutter/feature/monthly_letter/presentation/screens/monthly_letter_detail_screen.dart';

import '../providers/monthly_letter/monthly_letter_provider.dart';
import '../widget/monthly_letter_item.dart';

class MonthlyLetterScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(monthlyLetterProvider);

    final queriedList = useState<List<MonthlyLetterUiModel>>([]);

    useEffect(() {
      if (state.isLoading == false && state.error == null) {
        queriedList.value = state.monthlyLetters;
      }
      return null;
    }, [state]);

    return MMateScaffold(
      context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: BlurAppBar(
        context,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        bottom: AppBarBottom(
          context,
          height: kToolbarHeight+ sp16,
          child: Padding(
            padding: IndexPadding(horizontal: sp16, bottom: sp16),
            child: IndexSearchBox(
              items: state.monthlyLetters,
              onChanged: (items) {
                queriedList.value = items;
              },
              searchItem: (value) {
                return [value.title];
              },
            ),
          ),
        ),
        child: IndexTextMax('총재월신', fontWeight: FontWeight.w500),
      ),
      body: StateBuilder(
        isLoading: state.isLoading,
        error: state.error,
        data: queriedList.value,
        builder: (_, data) {
          return MMateListView.separated(
            padding: AppStyle.padding(horizontal: sp16),
            itemCount: data.length,
            itemBuilder: (_, index) {
              return MMateInkWell(
                child: MonthlyLetterItem(data[index]),
                onTap: () =>context.push(MonthlyLetterDetailScreen(data[index].id)),
              );
            },
            separatorBuilder: (_, __) => SizedBox(height: sp16),
          );
        },
      ),
    );
  }
}
