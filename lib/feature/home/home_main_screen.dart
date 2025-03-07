import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rotary_flutter/feature/home/home_main_view_model.dart';
import 'package:rotary_flutter/feature/home_view_model.dart';
import 'package:rotary_flutter/feature/userSearch/user_search_screen.dart';
import 'package:rotary_flutter/util/fontSize.dart';
import 'package:rotary_flutter/util/global_color.dart';
import 'package:rotary_flutter/util/model/loadstate.dart';

import '../../util/common/common.dart';
import '../../util/logger.dart';
import '../../util/model/menu_items.dart';
import '../advertise/advertise_component.dart';
import '../advertise/advertise_screen.dart';
import '../advertise/advertise_view_model.dart';
import '../userSearch/list/user_search_list_component.dart';
import '../userSearch/list/user_search_list_screen.dart';
import '../usersearch/list/user_search_list_view_model.dart';
import 'home_main_component.dart';

class HomeMainScreen extends ConsumerStatefulWidget {
  const HomeMainScreen({super.key});

  @override
  ConsumerState<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends ConsumerState<HomeMainScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final homeProvider = ref.read(HomeProvider);
    final userSearchListViewModel = ref.watch(UserSearchListProvider);
    return Container(
        color: GlobalColor.primaryColor,
        child: CustomScrollView(physics: ClampingScrollPhysics(), slivers: [
          SliverToBoxAdapter(
              child: Container(
                  color: GlobalColor.white,
                  width: double.infinity,
                  height: (MediaQuery.of(context).size.width) * 6 / 16,
                  alignment: Alignment.center,
                  child: Stack(alignment: Alignment.bottomRight, children: [
                    InkWell(
                        onTap: () {
                          ref.read(HomeProvider).pushCurrentWidget =
                              const UserSearchScreen();
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                height: width * 6 / 24,
                                width: width * 6 / 24,
                                'asset/icons/logo_star.svg',
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IndexMaxTitle('로타리 3700지구'),
                                  IndexText('전체인원 ${userSearchListViewModel.allAccountCount}'),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      homeProvider.pushCurrentWidget =
                                          UserSearchListScreen(
                                              initialRegion: 0);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 15,
                                          right: 5,
                                          top: 5,
                                          bottom: 5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: GlobalColor.indexBoxColor),
                                      child: Row(
                                        children: [
                                          IndexMinText('전체보기'),
                                          Icon(Icons.arrow_right_rounded)
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )),
                  ]))),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 1.5),
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              // return Container(width: 50, height: 50,color: Colors.black,);
              return InkWell(
                  onTap: () {
                    homeProvider.pushCurrentWidget = menuItems[index].widget;
                    if (menuItems[index].onTap != null)
                      menuItems[index].onTap!();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: GlobalColor.primaryColor,
                      border: Border.all(width: 0.5, color: Colors.white24),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        menuItems[index].iconPath == null
                            ? SizedBox()
                            : SvgPicture.asset(
                                menuItems[index].iconPath!,
                                width: width * 0.08,
                                height: width * 0.08,
                              ),
                        SizedBox(height: height * 0.01),
                        IndexTitle(
                          menuItems[index].label,
                          textColor: GlobalColor.indexBoxColor,
                        )
                      ],
                    ),
                  ));
            }, childCount: menuItems.length),
          ),
          SliverToBoxAdapter(
            child: Divider(
              height: 0.5,
              thickness: 0.5,
              color: Colors.white24,
            ),
          ),
          SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset('asset/icons/logo_index.svg', width: 70),
                      const SizedBox(width: 15),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IndexMicroText('국제로타리 3700지구',
                              defaultScale: true,
                              textColor: GlobalColor.indexColor),
                          IndexMicroText('대구광역시 중구 동덕로 115 진석타워 5층 501호',
                              defaultScale: true,
                              textColor: GlobalColor.indexColor),
                          IndexMicroText('TEL 053-473-3700. FAX 053-429-7901~2',
                              defaultScale: true,
                              textColor: GlobalColor.indexColor),
                          IndexMicroText(''),
                        ],
                      ),
                    ],
                  )))
        ]));
  }
}
