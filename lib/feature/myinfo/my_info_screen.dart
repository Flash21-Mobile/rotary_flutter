import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rotary_flutter/data/model/account_model.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';
import 'package:rotary_flutter/feature/home_component.dart';
import 'package:rotary_flutter/feature/home_view_model.dart';
import 'package:rotary_flutter/feature/myInfo/my_info_view_model.dart';
import 'package:rotary_flutter/util/global_color.dart';

import '../../util/common/common.dart';
import '../myInfo/modify/my_info_modify_screen.dart';

class MyInfoScreen extends ConsumerStatefulWidget {
  const MyInfoScreen({super.key});

  @override
  ConsumerState<MyInfoScreen> createState() => _MyInfoScreen();
}

class _MyInfoScreen extends ConsumerState<MyInfoScreen> {
  void getMyData() async {
    await ref.read(MyInfoProvider).getMyAccount();
  }

  @override
  void initState() {
    super.initState();
    getMyData();
  }

  @override
  Widget build(BuildContext context) {
    var myInfoProvider = ref.watch(MyInfoProvider);

    return LoadStateScaffold(
      appBar: AppBar(
        title: Text('내 정보'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            ref.read(HomeProvider).popCurrentWidget();
          },
        ),
      ),
      loadState: myInfoProvider.accountState,
      backgroundColor: GlobalColor.white,
      successBody: (data) {
        var account = (data as List<Account>).first;

        return Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(children: [
              SizedBox(
                height: 30,
              ),
              account.cellphone != null
                  ? Image.network(
                      '${BASE_URL}/qr?size=10&data=tel:+${account.cellphone}',
                      width: 150,
                      height: 150)
                  : SizedBox(),
              SizedBox(
                height: 30,
              ),
              Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: GlobalColor.indexBoxColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IndexText(
                        '회원정보',
                        textColor: GlobalColor.indexColor,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            width: 25,
                            height: 25,
                            'asset/icons/search_icon.svg',
                          ),
                          IndexTitle(account.name),
                          Spacer(),
                          InkWell(
                              onTap: () {
                                ref.read(HomeProvider).pushCurrentWidget =
                                    MyInfoModifyScreen();
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: GlobalColor.primaryColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    '수정하기',
                                    style: TextStyle(color: GlobalColor.white),
                                  )))
                        ],
                      )
                    ],
                  ))
            ]));
      },
    );
  }
}
