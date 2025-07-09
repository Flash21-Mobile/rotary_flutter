import 'package:core_system/app/style/app_style.dart';
import 'package:design_system/image/image.dart';
import 'package:design_system/text/text_interface.dart';
import 'package:design_system/utilities/config.dart';
import 'package:flutter/material.dart';
import 'package:function_system/utilities/format/date_time_format.dart';
import 'package:function_system/utilities/imagebuilder/image_builder.dart';
import 'package:rotary_flutter/util/hero_key.dart';

import '../../../../core/feature/model/account_thumb/account_detail_ui_model.dart';
import '../../../../util/image_api/image_api.dart';
import 'account_list_item_index.dart';

class AccountDetailMySection extends StatelessWidget {
  final AccountDetailUiModel data;

  const AccountDetailMySection(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final imageWidth = constraints.maxWidth;
        final imageHeight = imageWidth / 3 * 4;

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: MediaQuery.of(context).padding.top),
            ),
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              scrolledUnderElevation: 0,
              expandedHeight: imageHeight - MediaQuery.of(context).padding.top,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,

              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 1,
                titlePadding: EdgeInsets.zero,
                title: Container(
                  height: kToolbarHeight,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  alignment: Alignment.center,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(width: sp16),
                      IndexTextThumb(data.name, fontWeight: FontWeight.w600),
                      SizedBox(width: sp5),
                      IndexTextMin(data.grade),
                    ],
                  ),
                ),
                background: MMateImageBuilder(
                  data.id,
                  ImageApi.account,
                  builder: (_, isLoading, data) {
                    if (isLoading) {
                      return SizedBox(width: imageWidth, height: imageHeight);
                    }

                    if (data == null) {
                      return Container(
                        width: imageWidth,
                        height: imageHeight,
                        padding: IndexPadding(bottom: kToolbarHeight),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Icon(
                          Icons.image_rounded,
                          size: imageWidth / 3,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      );
                    }
                    return Padding(
                      padding: IndexPadding(bottom: kToolbarHeight),
                      child: MMateImage(
                        data,
                        width: imageWidth,
                        height: imageHeight,
                        alignment: Alignment.topCenter,
                        fit: BoxFit.cover,
                        enableToDetail: true,
                        heroTag: HeroKey.accountDetail,
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                padding: sp16.toPadding(),
                child: Column(
                  children: [
                    AccountListItemIndex('아호', data.nickname),
                    SizedBox(height: sp16),
                    AccountListItemIndex('직책', data.secondGrade),
                    SizedBox(height: sp16),
                    AccountListItemIndex('입회일', data.time?.toFeatureDate()),
                  ],
                ),
              ),
            ),
            SliverList.separated(
              itemCount: data.advertises.length,
              itemBuilder: (_, index) {
                return Container(
                  margin: AppStyle.padding(horizontal: sp16),
                  padding: sp16.toPadding(),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: sp16.toBorderRadius(),
                  ),
                  child: Row(
                    children: [
                      MMateImageBuilder(
                        data.advertises[index].id,
                        ImageApi.advertise,
                        builder: (_, isLoading, data) {
                          if (isLoading || data == null) {
                            return SizedBox();
                          }
                          return MMateImage(
                            data,
                            width: imageWidth / 4,
                            height: imageWidth / 4,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      IndexText(data.advertises[index].title),
                    ],
                  ),
                );
              },
              separatorBuilder: (_, __) => SizedBox(height: sp16),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 200)),
          ],
        );
      },
    );
  }
}
