import 'package:core_system/app/style/app_style.dart';
import 'package:design_system/animate/ink_well.dart';
import 'package:design_system/config.dart';
import 'package:design_system/image/image.dart';
import 'package:design_system/text/text_interface.dart';
import 'package:design_system/utilities/config.dart';
import 'package:flutter/material.dart';
import 'package:rotary_flutter/feature/main/presentation/constatns/main_menu_item.dart';

class MainMenuList extends StatelessWidget {
  final List<MainMenuItem> menuItemList;

  const MainMenuList(this.menuItemList, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: AppConfig.borderRadius,
      ),
      child: ListView.separated(
        padding: IndexPadding(vertical: sp16 / 2),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: menuItemList.length,
        itemBuilder: (BuildContext context, int index) {
          final item = menuItemList[index];

          return MMateInkWell(
            borderRadius: sp16.toBorderRadius(),
            enableSplash: true,
            onTap: () {},
            child: Padding(
              padding: AppStyle.padding(horizontal: sp16, vertical: sp16 / 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    padding: AppConfig.padding / 2,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: 8.0.toBorderRadius(),
                    ),
                    child: MMateImage(
                      item.image,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  SizedBox(width: AppConfig.paddingIndex),
                  IndexTextMin(
                    item.label,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (_, index) {
          return SizedBox(height: sp5);
        },
      ),
    );
  }
}
