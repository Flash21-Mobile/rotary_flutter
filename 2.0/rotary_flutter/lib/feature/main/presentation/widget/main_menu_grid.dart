import 'package:core_system/app/style/app_style.dart';
import 'package:design_system/animate/ink_well.dart';
import 'package:design_system/config.dart';
import 'package:design_system/image/image.dart';
import 'package:design_system/text/text_interface.dart';
import 'package:design_system/utilities/config.dart';
import 'package:flutter/material.dart';
import 'package:rotary_flutter/feature/main/presentation/constatns/main_menu_item.dart';

typedef HighlightMenu = (MainMenuItem item, String name);

class MainMenuGrid extends StatelessWidget {
  final List<MainMenuItem> menuItemList;
  final HighlightMenu? highlightMenu;

  const MainMenuGrid(this.menuItemList, {super.key, this.highlightMenu});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final itemSize = (constraints.maxWidth / 3) - 2;
        return ClipRRect(
          borderRadius: AppConfig.borderRadius,
          child: Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Column(
              children: [
                SizedBox(
                  height: itemSize,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: IndexPadding(),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: menuItemList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = menuItemList[index];
                      return Container(
                        width: itemSize,
                        padding: sp5.toPadding(),
                        child: MMateInkWell(
                          enableSplash: true,
                          borderRadius: sp16.toBorderRadius(),
                          onTap: () => item.onTap(context),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MMateImage(
                                width: itemSize / 4,
                                height: itemSize / 4,
                                item.image,
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.onPrimaryContainer,
                              ),
                              SizedBox(height: AppConfig.paddingIndex / 2),
                              IndexTextMin(
                                item.label,
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.onPrimaryContainer,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                        height: double.infinity,
                        width: 1,
                        margin: AppConfig.paddingVertical,
                        color: Theme.of(context).colorScheme.tertiary,
                      );
                    },
                  ),
                ),
                if (highlightMenu != null) ...[
                  Container(
                    width: double.infinity,
                    height: 1,
                    margin: AppConfig.paddingHorizontal,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  Container(
                    padding: AppStyle.padding(vertical: sp5),
                    child: MMateInkWell(
                      enableSplash: true,
                      borderRadius: sp16.toBorderRadius(),
                      onTap: () => highlightMenu!.$1.onTap(context),
                      child: Container(
                        padding: AppConfig.padding,
                        child: Row(
                          children: [
                            MMateImage(
                              width: 30,
                              height: 30,
                              highlightMenu!.$1.image,
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.onPrimaryContainer,
                            ),
                            SizedBox(width: AppConfig.paddingIndex),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IndexTextMin(
                                  highlightMenu!.$2,
                                  color:
                                      Theme.of(context).colorScheme.onTertiary,
                                ),
                                IndexTextMax(
                                  highlightMenu!.$1.label,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
