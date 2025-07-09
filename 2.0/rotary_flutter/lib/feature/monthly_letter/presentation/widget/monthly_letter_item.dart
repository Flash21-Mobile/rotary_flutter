import 'package:core_system/app/style/app_style.dart';
import 'package:design_system/image/image.dart';
import 'package:design_system/text/text_interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:function_system/utilities/format/date_time_format.dart';
import 'package:function_system/utilities/imagebuilder/image_builder.dart';
import 'package:rotary_flutter/feature/monthly_letter/presentation/model/monthly_letter/monthly_letter_ui_model.dart';
import 'package:rotary_flutter/util/image_api/image_api.dart';

class MonthlyLetterItem extends StatelessWidget {
  final MonthlyLetterUiModel data;

  const MonthlyLetterItem(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: sp16.toBorderRadius(),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      padding: sp16.toPadding(),
      child: LayoutBuilder(
        builder: (_, index) {
          final imageWidth = index.maxWidth / 3;
          final imageHeight = (imageWidth / 3) * 4;
          return Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: sp16.toBorderRadius(),
                  border: Border.all(
                    color: Theme.of(context).dividerColor,
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: sp16.toBorderRadius(),
                  child: MMateImageBuilder(
                    data.id,
                    ImageApi.monthlyLetter,
                    builder: (_, isLoading, data) {
                      if (isLoading) {
                        return SizedBox(width: imageWidth, height: imageHeight);
                      }

                      if (data == null) {
                        return Container(
                          width: imageWidth,
                          height: imageHeight,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: Icon(
                            Icons.image_rounded,
                            size: imageHeight / 3,
                            color: Theme.of(context).colorScheme.tertiary,
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
              SizedBox(width: sp16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IndexTextMax(data.title, fontWeight: FontWeight.w600),
                  IndexText(data.date.toFeatureDate()),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
