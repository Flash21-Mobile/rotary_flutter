import 'package:core_system/app/style/app_style.dart';
import 'package:design_system/animate/ink_well.dart';
import 'package:design_system/config.dart';
import 'package:design_system/text/text_interface.dart';
import 'package:design_system/textfield/index_text_filed.dart';
import 'package:design_system/utilities/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:function_system/utilities/navigation/navigation.dart';

import 'feature/account/presentation/screens/account_list_screen.dart';
import 'feature/account/presentation/screens/account_screen.dart';
import 'feature/main/domain/enums/ui_type.dart';
import 'feature/main/presentation/constatns/main_menu_item.dart';
import 'feature/main/presentation/widget/main_banner/main_origin_banner.dart';
import 'feature/main/presentation/widget/main_foot_section.dart';
import 'feature/main/presentation/widget/main_menu_double.dart';
import 'feature/main/presentation/widget/main_menu_grid.dart';
import 'feature/main/presentation/widget/main_menu_list.dart';
import 'feature/main/presentation/widget/main_top_space.dart';
import 'feature/you/presentation/you_screen.dart';

class NewMain extends StatelessWidget {
  final int accountsLength;
  final void Function(UiType uiType)? onTapUiType;

  const NewMain(this.accountsLength, {super.key, this.onTapUiType});

  @override
  Widget build(BuildContext context) {
    final myMenuList = MainMenuItem.my;
    final monthlyMenuList = MainMenuItem.monthly;
    final monthlyHighlightMenu = MainMenuItem.monthlyHighlight;

    final accountMenuList = MainMenuItem.account;
    final etcMenuList = MainMenuItem.etc;

    return ListView(
      padding: IndexPadding(horizontal: AppConfig.paddingIndex),
      children: [
        MainTopSpace(),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IndexTextUltra('회원 검색', fontWeight: FontWeight.w500),
                IndexText(
                  '이혜성 - 국제RC',
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ],
            ),
            Spacer(),
            MMateInkWell(
              onTap: () => context.push(YouScreen()),
              child: Container(
                width: kToolbarHeight,
                height: kToolbarHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Icon(
                  Icons.person_rounded,
                  color: Theme.of(context).colorScheme.tertiary,
                  size: kToolbarHeight - AppConfig.paddingIndex * 2,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: AppConfig.paddingIndex / 2),
        MainBanner(
          accountsLength: accountsLength,
          onTap: () => context.push(AccountScreen()),
          onTapAllButton: () => context.push(AccountListScreen()),
        ),
        SizedBox(height: AppConfig.paddingIndex / 2),
        MainMenuDouble(leftMenu: myMenuList[0], rightMenu: myMenuList[1]),
        SizedBox(height: AppConfig.paddingIndex),
        IndexTextMin('월간'),
        MainMenuGrid(
          monthlyMenuList,
          highlightMenu: (monthlyHighlightMenu, '월간'),
        ),
        SizedBox(height: AppConfig.paddingIndex),
        IndexTextMin('회원'),
        IgnorePointer(
          child: IndexTextField(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            padding: IndexPadding(left: AppConfig.paddingIndex),
            hintText: '회원 검색..',
          ),
        ),
        SizedBox(height: AppConfig.paddingIndex / 2),
        MainMenuGrid(accountMenuList),
        SizedBox(height: AppConfig.paddingIndex),
        IndexTextMin('기타'),
        MainMenuList(etcMenuList),

        SizedBox(height: AppConfig.paddingIndex),

        Container(
          padding: 3.0.toPadding(),
          decoration: BoxDecoration(
            borderRadius: 100.0.toBorderRadius(),
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          child: Row(
            children: [
              Expanded(
                child: MMateInkWell(
                  onTap: () => onTapUiType?.call(UiType.origin),
                  child: Center(
                    child: IndexText(
                      'GRID',
                      color: Theme.of(context).colorScheme.tertiary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: 100.0.toBorderRadius(),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  padding: 10.0.toPadding(),
                  child: IndexText(
                    'LIST',
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        MainFootSection(color: Theme.of(context).colorScheme.onTertiary),
      ],
    );
  }
}
