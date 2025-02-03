import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';
import 'package:rotary_flutter/util/global_color.dart';

class UserInfoIndex extends StatelessWidget {
  final String assetName;
  final String indexName;
  final String? index;

  const UserInfoIndex(
      {super.key,
      required this.assetName,
      required this.indexName,
      required this.index});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
        height: 40,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Row(
          children: [
            Container(
                width: 90,
                child: IndexTextTitle(
                  indexName,
                  textColor: GlobalColor.greyFontColor,
                )),
            Container(
              child: IndexTextTitle(
                index ?? '',
                height: 1.1,
              ),
              width: width - 90 - 60,
            )
          ],
        ));
  }
}
