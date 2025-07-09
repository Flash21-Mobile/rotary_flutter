import 'package:core_system/app/style/app_style.dart';
import 'package:design_system/config.dart';
import 'package:design_system/image/image.dart';
import 'package:design_system/text/text_interface.dart';
import 'package:design_system/utilities/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rotary_flutter/util/icons/icons.dart';
import 'package:rotary_flutter/util/logo/logo.dart';

class MainFootSection extends StatelessWidget {
  final Color? color;

  const MainFootSection({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: IndexPadding(
        top: 50,
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MMateImage(MMateLogo.appSurface, width: 70, color: color),
          SizedBox(height: sp5),
          IndexTextMin('국제로타리 3700지구', defaultScale: true, color: color),
          IndexTextMicro(
            '대구광역시 중구 동덕로 115 진석타워 5층 501호',
            defaultScale: true,
            color: color,
          ),
          IndexTextMicro(
            'TEL 053-473-3700. FAX 053-429-7901~2',
            defaultScale: true,
            color: color,
          ),
          // IndexMicroText(''),
        ],
      ),
    );
  }
}
