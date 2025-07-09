import 'package:core_system/app/style/app_style.dart';
import 'package:design_system/animate/ink_well.dart';
import 'package:design_system/appbar/app_bar.dart';
import 'package:design_system/appbar/app_bar_bottom.dart';
import 'package:design_system/dropdown/dropdown.dart';
import 'package:design_system/listview/list_view.dart';
import 'package:design_system/scaffold/scaffold.dart';
import 'package:design_system/text/text_interface.dart';
import 'package:design_system/textfield/index_search_box.dart';
import 'package:design_system/textfield/index_text_filed.dart';
import 'package:design_system/utilities/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:function_system/utilities/navigation/navigation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rotary_flutter/feature/account/presentation/screens/account_detail_screen.dart';
import 'package:rotary_flutter/feature/account/presentation/widgets/account_search_item.dart';
import 'package:rotary_flutter/util/hero_key.dart';

import '../../../../core/feature/mapper/account_ui_mapper.dart';
import '../../../../core/feature/model/account_search/account_search_ui_model.dart';
import '../../../../core/provider/accountlist/account_list_provider.dart';

class AccountSearchScreen extends HookConsumerWidget {
  const AccountSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountSearchList =
        ref
            .watch(accountListProvider)
            .accountList
            .map((e) => AccountUiMapper.toSearchFromThumb(e))
            .toList();

    final focusNode = useFocusNode();

    final queriedList = useState<List<AccountSearchUiModel>>(accountSearchList);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(Duration(milliseconds: 300), () {
          focusNode.requestFocus();
        });
      });

      return null;
    }, []);

    return MMateScaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context,
      appBar: BlurAppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        context,

        bottom: AppBarBottom(
          context,
          height: kToolbarHeight + sp16,
          child: Padding(
            padding: IndexPadding(horizontal: sp16,bottom: sp16),
            child: Hero(
              tag: HeroKey.searchBox,
              child: IndexSearchBox(
                items: accountSearchList,
                onChanged: (items) {
                  queriedList.value = items;
                },
                searchItem: (value) {
                  return [value.name, value.grade, ...value.contents];
                },
              ),
            ),
          ),
        ),
        child: IndexTextMax('검색', fontWeight: FontWeight.w700),
      ),
      body: MMateListView.separated(
        padding: IndexPadding(horizontal: sp16),
        itemCount: queriedList.value.length,
        itemBuilder: (_, index) {
          return AccountSearchItem(
            queriedList.value[index],
            onTap: () {
              context.push(AccountDetailScreen(queriedList.value[index].id));
            },
          );
        },
        separatorBuilder: (_, __) => SizedBox(height: sp16),
      ),
    );
  }
}
