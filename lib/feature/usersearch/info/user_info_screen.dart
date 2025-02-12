import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rotary_flutter/data/model/article/response/article_model.dart';
import 'package:rotary_flutter/feature/advertise/advertise_component.dart';
import 'package:rotary_flutter/feature/advertise/advertise_view_model.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';
import 'package:rotary_flutter/feature/home_component.dart';
import 'package:rotary_flutter/feature/usersearch/info/user_info_component.dart';
import 'package:rotary_flutter/feature/usersearch/info/user_info_provider.dart';
import 'package:rotary_flutter/feature/usersearch/list/user_search_list_view_model.dart';
import 'package:rotary_flutter/feature/usersearch/viewer.dart';
import 'package:rotary_flutter/util/fontSize.dart';
import 'package:rotary_flutter/util/global_color.dart';
import 'package:rotary_flutter/util/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/model/account/response/account_model.dart';
import '../../../util/model/loadstate.dart';
import '../../home/home_main_screen.dart';
import '../../home_view_model.dart';
import '../../myInfo/my_info_screen.dart';
import '../list/user_search_list_component.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  const UserInfoScreen({super.key, required this.account});

  final Account account;

  @override
  ConsumerState<UserInfoScreen> createState() => _UserInfoScreen();
}

class _UserInfoScreen extends ConsumerState<UserInfoScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(UserSearchListProvider).accountAdvertiseState = End();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(UserSearchListProvider).getArticleByAccount(widget.account.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = ref.watch(UserSearchListProvider);

    return Scaffold(
        backgroundColor: GlobalColor.white,
        appBar: AppBar(
          title: IndexMaxTitle('회원정보'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: DefaultTabController(
        length: 2,
        child:
        // SizedBox(
        //   height: 15,
        // ),
        //
        CustomScrollView(
          // key: ValueKey('nested'),
          // headerSliverBuilder:
          //     (BuildContext context, bool innerBoxIsScrolled) {
          //   return [
          //     SliverList(
          //       delegate: SliverChildListDelegate(
          //         [
          //
          //           // Icon(Icons.person_rounded,size: MediaQuery.of(context).size.width/5,color: GlobalColor.indexColor,)
          //         ],
          //       ),
          //     )
          //   ];
          // },
            slivers: [
              //           SizedBox(
              //   height: 15,
              // ),
              // Expanded(
              //     child: Stack(children: [
              //       Container(
              //           margin: EdgeInsets.only(top: 290),
              //           child: ,
              SliverToBoxAdapter(
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return UserSearchViewer(id: widget.account.id);
                        }));
                      },
                      child: FutureImage(
                        align: Alignment.topCenter,
                        viewModel.getAccountFile(widget.account.id),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width * 1.2,
                      ))),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: TabBar(
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
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 25),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  child: Container(
                    height: 40 * 7 + 30,
                    child: TabBarView(
                      children: [
                        Column(
                          children: [
                            UserInfoIndex(
                                assetName: 'asset/icons/name_icon.svg',
                                indexName: '성명',
                                index: widget.account.name),
                            UserInfoIndex(
                                assetName: 'asset/icons/name_icon.svg',
                                indexName: '아호',
                                index: widget.account.nickname),
                            UserInfoIndex(
                                assetName: 'asset/icons/position_icon.svg',
                                indexName: '직책',
                                index: widget.account.secondGrade?.name),
                            UserInfoIndex(
                                assetName: 'asset/icons/affiliation_icon.svg',
                                indexName: '소속',
                                index: widget.account.grade?.name),
                            UserInfoIndex(
                              assetName: 'asset/icons/calendar_icon.svg',
                              indexName: '입회일',
                              index: widget.account.time != null
                                  ? formatDateTime(widget.account.time)
                                  : '',
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 25,
                                ),
                                InkWell(
                                  onTap: () async {
                                    var uri = Uri(
                                        scheme: 'tel',
                                        path: widget.account.cellphone);
                                    if (await canLaunchUrl(uri))
                                      await launchUrl(uri);
                                  },
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: GlobalColor.indexBoxColor,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: SvgPicture.asset(
                                        'asset/icons/phone_icon.svg'),
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                InkWell(
                                    borderRadius: BorderRadius.circular(100),
                                    onTap: () async {
                                      var uri = Uri(
                                          scheme: 'sms',
                                          path: widget.account.cellphone);
                                      if (await canLaunchUrl(uri))
                                        await launchUrl(uri);
                                    },
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: GlobalColor.indexBoxColor,
                                        borderRadius:
                                        BorderRadius.circular(100),
                                      ),
                                      child: SvgPicture.asset(
                                          'asset/icons/message_icon.svg'),
                                    )),
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            UserInfoIndex(
                                assetName: 'asset/icons/company_icon.svg',
                                indexName: '상호',
                                index: widget.account.workName),
                            UserInfoIndex(
                                assetName: 'asset/icons/name_icon.svg',
                                indexName: '성명',
                                index: widget.account.name),
                            UserInfoIndex(
                                assetName: 'asset/icons/position_icon.svg',
                                indexName: '직책',
                                index: widget.account.workPositionName),
                            UserInfoIndex(
                                assetName: 'asset/icons/phone_icon.svg',
                                indexName: '전화',
                                index: widget.account.telephone),
                            UserInfoIndex(
                                assetName: 'asset/icons/fax_icon.svg',
                                indexName: '팩스',
                                index: widget.account.faxNumber),
                            UserInfoIndex(
                                assetName: 'asset/icons/address_icon.svg',
                                indexName: '주소',
                                index:
                                '${widget.account.workAddress ?? ''} ${widget.account.workAddressSub ?? ''}'),
                            InkWell(
                                onTap:
                                widget.account.email != null ? () {
                                  launchEmail(widget.account.email!);
                                } : null,
                                child: UserInfoIndex(
                                    assetName: 'asset/icons/email_icon.svg',
                                    indexName: '이메일',
                                    index: widget.account.email)),
                          ],
                        ),
                      ],
                    ),
                  )),
              ...switch (viewModel.accountAdvertiseState) {
                Loading() => [
                  SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ))
                ],
                Success() => [
                  SliverList.separated(
                    itemCount:
                    (viewModel.accountAdvertiseState as Success)
                        .data
                        .length,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: GlobalColor.indexBoxColor,
                          ),
                          padding: EdgeInsets.all(15),
                          child: AdvertiseListTile(
                            indexWidth: 175,
                            data: (viewModel.accountAdvertiseState
                            as Success)
                                .data[index],
                            onTap: () {
                              FocusScope.of(context).unfocus();

                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) {
                                    return AdvertiseDetailScreen(
                                        data: (viewModel.accountAdvertiseState
                                        as Success)
                                            .data[index]);
                                  }));
                            },
                          ));
                    },
                    separatorBuilder: (_, $) => SizedBox(
                      height: 10,
                    ),
                  )
                ],
                _ => []
              },
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 100,
                ),
              )
            ])));
  }

  String formatDateTime(String? dateTime) {
    DateTime parsedDate = DateTime.parse(dateTime ?? '');
    return "${parsedDate.year}.${parsedDate.month.toString().padLeft(2, '0')}.${parsedDate.day.toString().padLeft(2, '0')}";
  }

  void launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      debugPrint("이메일을 열 수 없습니다.");
    }
  }
}
