import 'package:core_system/app/style/app_style.dart';
import 'package:design_system/animate/ink_well.dart';
import 'package:design_system/config.dart';
import 'package:design_system/image/image.dart';
import 'package:design_system/text/text_interface.dart';
import 'package:flutter/material.dart';
import 'package:function_system/utilities/imagebuilder/image_builder.dart';
import 'package:rotary_flutter/util/image_api/image_api.dart';

import '../../../../core/feature/model/account_search/account_search_ui_model.dart';

class AccountSearchItem extends StatelessWidget {
  final AccountSearchUiModel data;
  final VoidCallback onTap;

  const AccountSearchItem(this.data, {super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final currentContent = data.contents.where((e) => e.isNotEmpty);

    return MMateInkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppConfig.borderRadius,
          color: theme.colorScheme.primaryContainer,
        ),
        padding: AppConfig.padding,
        child: LayoutBuilder(
          builder: (_, constraints) {
            final imageSize = constraints.maxWidth / 8;

            return Row(
              children: [
                ClipRRect(
                  borderRadius: 100.0.toBorderRadius(),
                  child: MMateImageBuilder(
                    data.id,
                    ImageApi.account,
                    builder: (_, isLoading, data) {
                      if (isLoading) {
                        return SizedBox(width: imageSize, height: imageSize);
                      }

                      if (data == null) {
                        return Container(
                          width: imageSize,
                          height: imageSize,
                          color: theme.scaffoldBackgroundColor,
                          child: Icon(
                            Icons.image_rounded,
                            size: imageSize / 3,
                            color: theme.colorScheme.tertiary,
                          ),
                        );
                      }
                      return MMateImage(
                        data,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        width: imageSize,
                        height: imageSize,
                      );
                    },
                  ),
                ),
                SizedBox(width: sp16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IndexTextThumb(data.name, fontWeight: FontWeight.w600),
                        SizedBox(width: AppConfig.paddingIndex / 3),
                        IndexTextMin(data.grade),
                      ],
                    ),
                    if (currentContent.isNotEmpty)
                      IndexTextMin(
                        currentContent.join(' · '),
                        color: Theme.of(context).colorScheme.onTertiary,
                      ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
