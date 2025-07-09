import 'package:core_system/app/style/app_style.dart';
import 'package:design_system/animate/ink_well.dart';
import 'package:design_system/config.dart';
import 'package:design_system/image/image.dart';
import 'package:design_system/text/text_interface.dart';
import 'package:design_system/textfield/index_text_filed.dart';
import 'package:design_system/utilities/config.dart';
import 'package:flutter/material.dart';
import 'package:rotary_flutter/feature/main/presentation/constatns/main_menu_item.dart';

class MainMenuDouble extends StatelessWidget {
  final MainMenuItem leftMenu;
  final MainMenuItem rightMenu;
  final EdgeInsets? padding;

  const MainMenuDouble({
    super.key,
    required this.leftMenu,
    required this.rightMenu,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: padding,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: AppConfig.borderRadius,
                      child: Container(
                        padding: sp5.toPadding(),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                        child: MMateInkWell(
                          enableSplash: true,
                          borderRadius: sp16.toBorderRadius(),
                          onTap: () => leftMenu.onTap(context),
                          child: Container(
                            padding: 10.0.toPadding(),

                            child: Row(
                              children: [
                                Container(
                                  width: 35,
                                  height: 35,
                                  padding: AppConfig.padding / 2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  child: MMateImage(
                                    width: 25,
                                    height: 25,
                                    leftMenu.image,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                SizedBox(width: AppConfig.paddingIndex),
                                IndexTextMin(
                                  leftMenu.label,
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.onPrimaryContainer,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: AppConfig.paddingIndex / 2),

                  Expanded(
                    child: ClipRRect(
                      borderRadius: AppConfig.borderRadius,
                      child: Container(
                        padding: sp5.toPadding(),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                        child: MMateInkWell(
                          enableSplash: true,
                          borderRadius: sp16.toBorderRadius(),
                          onTap: () => rightMenu.onTap(context),
                          child: Padding(
                              padding: 10.0.toPadding(),
                              child: Row(
                            children: [
                              Container(
                                width: 35,
                                height: 35,
                                padding: AppConfig.padding / 2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                child: MMateImage(
                                  width: 25,
                                  height: 25,
                                  rightMenu.image,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              SizedBox(width: AppConfig.paddingIndex),
                              IndexTextMin(
                                rightMenu.label,
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.onPrimaryContainer,
                              ),
                            ],)
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
