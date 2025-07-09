import 'package:core_system/app/style/app_style.dart';
import 'package:design_system/image/image.dart';
import 'package:design_system/listview/list_view.dart';
import 'package:design_system/text/text_interface.dart';
import 'package:flutter/material.dart';
import 'package:function_system/utilities/imagebuilder/image_builder.dart';

import '../../../../core/feature/model/account_thumb/account_detail_ui_model.dart';
import '../../../../util/image_api/image_api.dart';
import 'account_list_item_index.dart';

class AccountDetailWorkSection extends StatelessWidget {
  final AccountDetailUiModel data;

  const AccountDetailWorkSection(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final imageWidth = constraints.maxWidth;
        final imageHeight = imageWidth / 3 * 4;

        return MMateListView(
          padding: sp16.toPadding(),
          children: [
            AccountListItemIndex('상호', data.workName),
            SizedBox(height: sp16),
            AccountListItemIndex('직책', data.workPositionName),
            SizedBox(height: sp16),
            AccountListItemIndex('전화', data.telephone),
            SizedBox(height: sp16),
            AccountListItemIndex('팩스', data.faxNumber),
            SizedBox(height: sp16),
            AccountListItemIndex(
              '주소',
              [data.workAddress, data.workAddressSub].join(' '),
            ),
            SizedBox(height: sp16),
            AccountListItemIndex('이메일', data.email),
            // SizedBox(height: sp16),
            // ListView.separated(
            //   padding: EdgeInsets.zero,
            //   physics: NeverScrollableScrollPhysics(),
            //   shrinkWrap: true,
            //   itemCount: data.advertises.length,
            //   itemBuilder: (_, index) {
            //     return Container(
            //       padding: sp16.toPadding(),
            //       decoration: BoxDecoration(
            //         color: Theme.of(context).scaffoldBackgroundColor,
            //         borderRadius: sp16.toBorderRadius(),
            //       ),
            //       child: Row(
            //         children: [
            //           MMateImageBuilder(
            //             data.advertises[index].id,
            //             ImageApi.advertise,
            //             builder: (_, isLoading, data) {
            //               if (isLoading || data == null) {
            //                 return SizedBox();
            //               }
            //               return MMateImage(
            //                 data,
            //                 width: imageWidth / 4,
            //                 height: imageWidth / 4,
            //                 fit: BoxFit.cover,
            //               );
            //             },
            //           ),
            //           IndexText(data.advertises[index].title),
            //         ],
            //       ),
            //     );
            //   },
            //   separatorBuilder: (_, __) => SizedBox(height: sp16),
            // ),
            SizedBox(height: 200,),
          ],
        );

      },
    );
  }
}
