import 'package:core_system/app/style/app_style.dart';
import 'package:design_system/text/text_interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountListItemIndex extends StatelessWidget {
  final String label;
  final String? value;

  const AccountListItemIndex(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final itemWidth = constraints.maxWidth / 3;

        return Row(
          children: [
            SizedBox(
              width: itemWidth,
              child: IndexText(
                label,
                color: Theme.of(context).colorScheme.onTertiary,
              ),
            ),
            SizedBox(
              width: constraints.maxWidth - itemWidth-sp16,
              child: IndexText(
                value ?? '',
                fontWeight: FontWeight.w600,
                overFlowFade: true,
              ),
            ),
          ],
        );
      },
    );
  }
}
