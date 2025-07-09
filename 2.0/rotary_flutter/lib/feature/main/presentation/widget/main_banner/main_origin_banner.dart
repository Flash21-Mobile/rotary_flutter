import 'package:design_system/animate/ink_well.dart';
import 'package:design_system/config.dart';
import 'package:design_system/image/image.dart';
import 'package:design_system/text/text_interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../util/logo/logo.dart';

class MainBanner extends StatelessWidget {
  final int accountsLength;
  final VoidCallback? onTap;
  final VoidCallback onTapAllButton;

  const MainBanner({
    super.key,
    required this.accountsLength,
    this.onTap,
    required this.onTapAllButton,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
          borderRadius: AppConfig.borderRadius,
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 3,
              color: Theme.of(context).colorScheme.tertiary,
            ),
            borderRadius: AppConfig.borderRadius,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primary.withAlpha(1750),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            // color: Theme.of(context).colorScheme.primary,
          ),
          padding: AppConfig.padding,
          width: screenWidth,
          height: (screenWidth * 6) / 16,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: MMateImage(
                  // height: (screenWidth * 6) / 24,
                  // width: (screenWidth * 6) / 24,
                  MMateLogo.appBanner,
                ),
              ),
              SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IndexTextMax(
                    '로타리 3700지구',
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  IndexText(
                    '전체인원 ${accountsLength}',
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 16),
                  MMateInkWell(
                    onTap: onTapAllButton,
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 5,
                        top: 5,
                        bottom: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: Row(
                        children: [
                          IndexText(
                            '전체보기',
                            color:
                                Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                          ),
                          Icon(Icons.arrow_right_rounded),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
