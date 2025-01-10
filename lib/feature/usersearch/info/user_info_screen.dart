import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';
import 'package:rotary_flutter/feature/home_component.dart';
import 'package:rotary_flutter/feature/usersearch/info/user_info_component.dart';
import 'package:rotary_flutter/feature/usersearch/info/user_info_provider.dart';
import 'package:rotary_flutter/feature/usersearch/list/user_search_list_view_model.dart';
import 'package:rotary_flutter/util/fontSize.dart';
import 'package:rotary_flutter/util/global_color.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/model/account_model.dart';
import '../../home/home_main_screen.dart';
import '../../home_view_model.dart';
import '../../myInfo/my_info_screen.dart';
import '../list/user_search_list_component.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  const UserInfoScreen({super.key, required this.id});

  final int id;

  @override
  ConsumerState<UserInfoScreen> createState() => _UserInfoScreen();
}

class _UserInfoScreen extends ConsumerState<UserInfoScreen> {
  @override
  void initState() {
    ref.read(UserInfoProvider).getUserInfo(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = ref.watch(UserInfoProvider);
    var userSearchListViewModel = ref.read(UserSearchListProvider);

    return
        LoadStateScaffold(
            backgroundColor: GlobalColor.white,
            appBar: AppBar(
              title: Text('회원정보'),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            loadState: viewModel.userInfoState,
            successBody: (data) {
              final account = (data as List<Account>).first;

              return NestedScrollView(
                  key: ValueKey('nested'),
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            FutureImage(
                              userSearchListViewModel
                                  .getAccountFile(account.id),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width * 1.2,
                            )
                            // Icon(Icons.person_rounded,size: MediaQuery.of(context).size.width/5,color: GlobalColor.indexColor,)
                          ],
                        ),
                      )
                    ];
                  },
                  body: DefaultTabController(
                      length: 2,
                      child: Column(children: [
                        SizedBox(
                          height: 15,
                        ),
                        TabBar(
                          tabs: [
                            Tab(
                              text: '개인정보',
                            ),
                            Tab(
                              text: '회사정보',
                            ),
                          ],
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: GlobalColor.primaryColor,
                              fontSize: DynamicFontSize.font20(context)),
                          unselectedLabelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: DynamicFontSize.font20(context),
                              color: GlobalColor.indexColor),
                          indicator: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  color: GlobalColor.primaryColor, width: 1)),
                          indicatorPadding:
                              EdgeInsets.symmetric(horizontal: 15),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                            child: TabBarView(
                          physics: ClampingScrollPhysics(),
                          children: [
                            SingleChildScrollView(
                                child: Column(
                              children: [
                                UserInfoIndex(
                                    assetName: 'asset/icons/info/name_icon.svg',
                                    indexName: '성명',
                                    index: account.name),
                                UserInfoIndex(
                                    assetName:
                                        'asset/icons/info/position_icon.svg',
                                    indexName: '직책',
                                    index: ''),
                                UserInfoIndex(
                                    assetName:
                                        'asset/icons/info/affiliation_icon.svg',
                                    indexName: '소속',
                                    index: account.grade?.name),
                                UserInfoIndex(
                                    assetName:
                                        'asset/icons/info/calendar_icon.svg',
                                    indexName: '입회일',
                                    index: null),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: InkWell(
                                            onTap: () async {
                                              var uri = Uri(
                                                  scheme: 'sms',
                                                  path: account.cellphone);
                                              if (await canLaunchUrl(uri))
                                                await launchUrl(uri);
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(left: 15),
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: GlobalColor
                                                          .lightPrimaryColor)),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                        'asset/icons/info/message_icon.svg'),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    IndexText('문자보내기',
                                                        textColor: GlobalColor
                                                            .primaryColor)
                                                  ]),
                                            ))),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                        child: InkWell(
                                            onTap: () async {
                                              var uri = Uri(
                                                  scheme: 'tel',
                                                  path: account.cellphone);
                                              if (await canLaunchUrl(uri))
                                                await launchUrl(uri);
                                            },
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(right: 15),
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: GlobalColor
                                                          .lightPrimaryColor)),
                                              child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                        'asset/icons/info/phone_icon.svg'),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    IndexText('전화하기',
                                                        textColor: GlobalColor
                                                            .primaryColor)
                                                  ]),
                                            )))
                                  ],
                                )
                              ],
                            )),
                            SingleChildScrollView(
                                child: Column(
                              children: [
                                UserInfoIndex(
                                    assetName:
                                        'asset/icons/info/company_icon.svg',
                                    indexName: '상호',
                                    index: account.workName),
                                UserInfoIndex(
                                    assetName: 'asset/icons/info/name_icon.svg',
                                    indexName: '성명',
                                    index: account.name),
                                UserInfoIndex(
                                    assetName:
                                        'asset/icons/info/position_icon.svg',
                                    indexName: '직책',
                                    index: account.workPositionName),
                                UserInfoIndex(
                                    assetName:
                                        'asset/icons/info/phone_icon.svg',
                                    indexName: '전화번호',
                                    index: account.cellphone),
                                UserInfoIndex(
                                    assetName: 'asset/icons/info/fax_icon.svg',
                                    indexName: '팩스번호',
                                    index: null),
                                UserInfoIndex(
                                    assetName:
                                        'asset/icons/info/address_icon.svg',
                                    indexName: '주소',
                                    index:
                                        '${account.workAddress ?? ''} ${account.workAddressSub ?? ''}'),
                                UserInfoIndex(
                                    assetName:
                                        'asset/icons/info/email_icon.svg',
                                    indexName: '이메일',
                                    index: account.email),
                              ],
                            )),
                          ],
                        ))
                      ])));
            });
  }
}
