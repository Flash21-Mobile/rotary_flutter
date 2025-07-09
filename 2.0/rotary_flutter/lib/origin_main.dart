import 'package:core_system/app/style/app_style.dart';
import 'package:design_system/animate/ink_well.dart';
import 'package:design_system/image/image.dart';
import 'package:design_system/listview/list_view.dart';
import 'package:design_system/scaffold/scaffold.dart';
import 'package:design_system/text/text_interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:function_system/utilities/navigation/navigation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rotary_flutter/feature/main/domain/enums/ui_type.dart';
import 'package:rotary_flutter/feature/main/presentation/constatns/main_menu_item.dart';
import 'package:rotary_flutter/feature/main/presentation/widget/main_banner/main_origin_banner.dart';
import 'package:rotary_flutter/feature/main/presentation/widget/main_foot_section.dart';
import 'package:rotary_flutter/feature/main/presentation/widget/main_menu_list.dart';

import 'feature/account/presentation/screens/account_list_screen.dart';
import 'feature/account/presentation/screens/account_screen.dart';

class OriginMain extends StatelessWidget {
  final int accountsLength;
  final void Function(UiType uiType)? onTapUiType;

  const OriginMain(this.accountsLength, {super.key, this.onTapUiType});

  @override
  Widget build(BuildContext context) {
    final mainMenuItems = MainMenuItem.origin;

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          Padding(
            padding: sp5.toPadding(),
            child: MainBanner(
              accountsLength: accountsLength,
              onTap: () => context.push(AccountScreen()),
              onTapAllButton: () => context.push(AccountListScreen()),
            ),
          ),
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: mainMenuItems.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 4 / 3,
              mainAxisSpacing: 0.5,
              crossAxisSpacing: 0.5,
            ),
            itemBuilder: (_, index) {
              final currentItem = mainMenuItems[index];
              if (currentItem == null) {
                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                );
              }

              return LayoutBuilder(
                builder: (_, constraints) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: MMateInkWell(
                      enableSplash: true,
                      onTap: () => currentItem.onTap(context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MMateImage(
                            currentItem.image,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          SizedBox(height: sp5),
                          IndexText(
                            currentItem.label,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          Container(
            height: 0.5,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          Container(
            padding: AppStyle.padding(horizontal: sp16,top: sp16),
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: 3.0.toPadding(),
                  decoration: BoxDecoration(
                    borderRadius: 100.0.toBorderRadius(),
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: 100.0.toBorderRadius(),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          padding: 10.0.toPadding(),
                          child: IndexText(
                            'GRID',
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: MMateInkWell(
                          onTap: () => onTapUiType?.call(UiType.origin),
                          child: Center(
                            child: IndexText(
                              'LIST',
                              color: Theme.of(context).colorScheme.tertiary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                MainFootSection(color: Theme.of(context).colorScheme.onPrimary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
