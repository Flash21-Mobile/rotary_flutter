import 'package:core_system/app/style/app_style.dart';
import 'package:design_system/animate/ink_well.dart';
import 'package:design_system/appbar/app_bar.dart';
import 'package:design_system/appbar/app_bar_bottom.dart';
import 'package:design_system/config.dart';
import 'package:design_system/dropdown/dropdown.dart';
import 'package:design_system/listview/list_view.dart';
import 'package:design_system/refreshindicator/refresh_indicator.dart';
import 'package:design_system/scaffold/scaffold.dart';
import 'package:design_system/text/text_interface.dart';
import 'package:design_system/textfield/index_text_filed.dart';
import 'package:design_system/utilities/config.dart';
import 'package:flutter/material.dart';
import 'package:function_system/utilities/navigation/navigation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rotary_flutter/core/provider/accountlist/account_list_provider.dart';
import 'package:rotary_flutter/feature/account/presentation/screens/account_detail_screen.dart';
import 'package:rotary_flutter/feature/account/presentation/screens/account_search_screen.dart';

import '../../../../util/hero_key.dart';
import '../providers/account_list/account_list_provider.dart';
import '../widgets/account_list_item.dart';

class AccountListScreen extends HookConsumerWidget {
  const AccountListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountListState = ref.watch(accountListProvider);

    final bottomInnerItemHeight = kToolbarHeight - sp16;
    return MMateScaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context,
      appBar: BlurAppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        context,
        bottom: AppBarBottom(
          context,
          height: kToolbarHeight,
          child: Padding(
            padding: IndexPadding(horizontal: sp16, bottom: sp16),
            child: Row(
              children: [
                IndexDropdown(
                  items: ['a'],
                  selectedValue: 0,
                  height: bottomInnerItemHeight,
                ),
                SizedBox(width: sp16),
                IndexDropdown(
                  items: ['a'],
                  selectedValue: 0,
                  height: bottomInnerItemHeight,
                ),
                SizedBox(width: sp16),
                Expanded(
                  child: MMateInkWell(
                    onTap: () => context.push(AccountSearchScreen()),
                    child: IgnorePointer(
                      child: Hero(
                        tag: HeroKey.searchBox,
                        child: IndexTextField(
                          hintText: '검색..',
                          height: bottomInnerItemHeight,
                          padding: IndexPadding(left: sp16),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: 100.0.toBorderRadius(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        child: IndexTextMax('회원검색', fontWeight: FontWeight.w500),
      ),
      body: MMateRefreshIndicator(
        context,
        displacementIndex:  120,
        onRefresh: () async {
          await ref.watch(accountListProvider.notifier).fetchData();
        },
        child: MMateListView.separated(
          padding: AppConfig.paddingHorizontal,
          itemCount: accountListState.accountList.length,
          itemBuilder: (_, index) {
            final currentAccount = accountListState.accountList[index];
            return AccountListItem(
              currentAccount,
              onTap: () => context.push(AccountDetailScreen(currentAccount.id)),
              onTapFavorite: () {
                ref.read(switchFavoriteAccountProvider(currentAccount.id));
              },
            );
          },
          separatorBuilder: (_, __) => SizedBox(height: AppConfig.paddingIndex),
        ),
      ),
    );
  }
}
