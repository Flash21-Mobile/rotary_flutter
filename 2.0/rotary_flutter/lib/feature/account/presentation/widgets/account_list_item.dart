import 'package:core_system/app/style/app_style.dart';
import 'package:design_system/animate/ink_well.dart';
import 'package:design_system/config.dart';
import 'package:design_system/gradient_border.dart';
import 'package:design_system/image/image.dart';
import 'package:design_system/text/text_interface.dart';
import 'package:flutter/material.dart';
import 'package:function_system/utilities/format/date_time_format.dart';
import 'package:function_system/utilities/imagebuilder/image_builder.dart';

import '../../../../core/feature/model/account_detail/account_thumb_ui_model.dart';
import '../../../../util/image_api/image_api.dart';
import 'account_list_item_index.dart';

class AccountListItem extends StatelessWidget {
  final AccountThumbUiModel data;
  final VoidCallback onTap;
  final VoidCallback onTapFavorite;

  const AccountListItem(
    this.data, {
    super.key,
    required this.onTap,
    required this.onTapFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Material(
        color: theme.colorScheme.primaryContainer,
        borderRadius: sp16.toBorderRadius(),
        child: CustomPaint(
          painter:
              data.isFavorite
                  ? GradientBorderPainter(
                    borderWidth: 2,
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.tertiary,
                    ],
                    borderRadius: Radius.circular(sp16),
                  )
                  : null,
          child: LayoutBuilder(
            builder: (_, constraints) {
              final imageWidth = constraints.maxWidth / 3.5;
              final imageHeight = (imageWidth / 3) * 4;

              final contentSectionWidth =
                  constraints.maxWidth - imageWidth - sp16 - sp16;

              return Row(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Padding(
                        padding: sp16.toPadding(),
                        child: ClipRRect(
                          borderRadius: AppConfig.borderRadius,
                          child: MMateImageBuilder(
                            data.id,
                            ImageApi.account,
                            builder: (_, isLoading, data) {
                              if (isLoading) {
                                return SizedBox(
                                  width: imageWidth,
                                  height: imageHeight,
                                );
                              }

                              if (data == null) {
                                return Container(
                                  width: imageWidth,
                                  height: imageHeight,
                                  color: theme.scaffoldBackgroundColor,
                                  child: Icon(
                                    Icons.image_rounded,
                                    size: imageWidth / 3,
                                    color: theme.colorScheme.tertiary,
                                  ),
                                );
                              }
                              return MMateImage(
                                data,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                                width: imageWidth,
                                height: imageHeight,
                              );
                            },
                          ),
                        ),
                      ),
                      MMateInkWell(
                        onTap: onTapFavorite,
                        child: Container(
                          padding: 1.0.toPadding(),
                          margin: 9.0.toPadding(),
                          decoration: BoxDecoration(
                            color:
                                data.isFavorite
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.tertiary,
                            borderRadius: 100.0.toBorderRadius(),
                          ),
                          child: Icon(
                            Icons.star_rounded,
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            size: imageWidth / 4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: contentSectionWidth,
                    height: imageHeight,
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IndexTextMax(
                                data.name,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(width: AppConfig.paddingIndex / 3),
                              IndexTextMin(data.grade),
                            ],
                          ),
                          SizedBox(height: AppConfig.paddingIndex / 3),
                          AccountListItemIndex('아호', data.nickname),
                          AccountListItemIndex('구분', data.firstGrade),
                          AccountListItemIndex('직책', data.secondGrade),
                          AccountListItemIndex(
                            '입회일',
                            data.time?.toFeatureDate(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
