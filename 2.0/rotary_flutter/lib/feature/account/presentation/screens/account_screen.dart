import 'package:core_system/app/style/app_style.dart';
import 'package:design_system/appbar/app_bar.dart';
import 'package:design_system/config.dart';
import 'package:design_system/image/image.dart';
import 'package:design_system/listview/list_view.dart';
import 'package:design_system/scaffold/scaffold.dart';
import 'package:design_system/text/text_interface.dart';
import 'package:flutter/material.dart';
import 'package:function_system/utilities/navigation/navigation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rotary_flutter/core/provider/accountlist/account_list_provider.dart';
import 'package:rotary_flutter/feature/account/presentation/screens/account_list_screen.dart';
import 'package:rotary_flutter/feature/main/presentation/widget/main_banner/main_origin_banner.dart';

class AccountScreen extends HookConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountListState = ref.watch(accountListProvider);

    final maxGrid = 13;

    return MMateScaffold(
      context,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: BlurAppBar(
        context,
        child: IndexTextMax('회원검색', fontWeight: FontWeight.w500),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: MMateListView(
        padding: AppStyle.padding(horizontal: sp16),
        children: [
          MainBanner(
            accountsLength: accountListState.accountList.length,
            onTapAllButton: () => context.push(AccountListScreen()),
          ),
          SizedBox(height: sp16),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: maxGrid,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.3,
              mainAxisSpacing: sp16,
              crossAxisSpacing: sp16,
            ),
            itemBuilder: (_, index) {
              return LayoutBuilder(
                builder: (_, constraints) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: sp16.toBorderRadius(),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MMateImage(
                          'assets/logo/logo_compact.svg',
                          width: constraints.maxWidth / 3,
                        ),
                        SizedBox(height: sp5),
                        if (index == maxGrid - 1)
                          IndexTextMax('사무장', fontWeight: FontWeight.w500)
                        else
                          IndexTextMax('${index + 1}지역'),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
