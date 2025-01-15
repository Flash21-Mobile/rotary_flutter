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
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 7),
        child: Row(
          children: [
            Expanded(
              flex: 3,
                child: Row(
              children: [
                SizedBox(width: 8,),
                IndexTitle(indexName, textColor: GlobalColor.greyFontColor,)],
            )),
            SizedBox(width: 15,),
            Expanded(
                flex: 9,
                child: IndexTitle(index ?? ''))
          ],
        ));
  }
}
