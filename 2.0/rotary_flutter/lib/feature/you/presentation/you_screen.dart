import 'package:core_system/app/style/app_style.dart';
import 'package:core_system/splash/provider/login_viewmodel.dart';
import 'package:design_system/animate/ink_well.dart';
import 'package:design_system/image/image.dart';
import 'package:design_system/text/text_interface.dart';
import 'package:flutter/material.dart';
import 'package:function_system/di/utilities/base_url_provider.dart';
import 'package:function_system/utilities/imagebuilder/image_builder.dart';
import 'package:function_system/utilities/navigation/navigation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rotary_flutter/feature/account/presentation/screens/account_detail_screen.dart';
import 'package:rotary_flutter/util/image_api/image_api.dart';

class YouScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myAccount = ref.watch(loginViewmodelProvider);
    final baseUrl = ref.watch(baseUrlProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          MMateInkWell(
            child: IndexText(
              '수정하기',
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: sp16),
        ],
      ),
      body: Padding(
        padding: AppStyle.padding(horizontal: sp16),
        child: LayoutBuilder(
          builder: (_, constraints) {
            final innerWidth = constraints.maxWidth - sp16 - sp16;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: sp16.toBorderRadius(),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  padding: sp16.toPadding(),
                  child: Column(
                    children: [
                      IndexTextMax('회원 QR코드', fontWeight: FontWeight.w500),
                      SizedBox(height: sp16),
                      Container(
                        padding: AppStyle.padding(vertical: sp16),
                        decoration: BoxDecoration(
                          borderRadius: sp16.toBorderRadius(),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IndexText(
                                    'RI 번호',
                                    color:
                                        Theme.of(
                                          context,
                                        ).colorScheme.primaryContainer,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: sp24,
                              width: 0.5,
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IndexText(
                                    '전화번호',
                                    color:
                                        Theme.of(
                                          context,
                                        ).colorScheme.primaryContainer,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: sp5),
                      Container(
                        width: innerWidth,
                        height: innerWidth,
                        padding: sp16.toPadding(),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: sp16.toBorderRadius(),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IndexText(
                              myAccount.data?.cellphone,
                              color: Colors.transparent,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: sp16.toBorderRadius(),
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer,
                              ),
                              padding: sp16.toPadding(),
                              child: Image.network(
                                '$baseUrl/api/qr?size=10&data=tel:+${myAccount.data?.cellphone}',
                                width: constraints.maxWidth / 2,
                                height: constraints.maxWidth / 2,
                              ),
                            ),
                            IndexText(
                              myAccount.data?.cellphone,
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: sp16),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: sp16.toBorderRadius(),
                  ),
                  padding: AppStyle.padding(vertical: sp5),
                  child: MMateInkWell(
                    enableSplash: true,
                    borderRadius: sp16.toBorderRadius(),
                    onTap:
                        () => context.push(
                          AccountDetailScreen(myAccount.data!.id),
                        ),
                    child: Container(
                      width: constraints.maxWidth,
                      padding: 10.0.toPadding(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: 100.0.toBorderRadius(),
                                child: MMateImageBuilder(
                                  myAccount.data!.id,
                                  ImageApi.account,
                                  builder: (_, isLoading, imageData) {
                                    final imageSize = constraints.maxWidth / 7;

                                    if (isLoading || imageData == null) {
                                      return SizedBox(
                                        width: imageSize,
                                        height: imageSize,
                                      );
                                    }

                                    return MMateImage(
                                      imageData,
                                      fit: BoxFit.cover,
                                      width: imageSize,
                                      height: imageSize,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(width: sp16),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IndexTextMax(
                                    myAccount.data?.name,
                                    fontWeight: FontWeight.w600,
                                    height: 1,
                                  ),
                                  IndexTextMin(
                                    myAccount.data?.grade?.name,
                                    height: 1,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
