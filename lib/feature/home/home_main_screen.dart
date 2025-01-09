import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rotary_flutter/feature/home_view_model.dart';
import 'package:rotary_flutter/feature/userSearch/user_search_screen.dart';
import 'package:rotary_flutter/util/fontSize.dart';
import 'package:rotary_flutter/util/global_color.dart';

import '../../util/common/common.dart';
import '../../util/model/menu_items.dart';
import '../advertise/advertise_component.dart';
import '../advertise/advertise_screen.dart';
import '../advertise/advertise_view_model.dart';
import '../userSearch/list/user_search_list_screen.dart';
import 'home_main_component.dart';

class HomeMainScreen extends ConsumerStatefulWidget {
  const HomeMainScreen({super.key});

  @override
  ConsumerState<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends ConsumerState<HomeMainScreen> {
  final PageController _pageController =
      PageController(initialPage: 0); // 초기 페이지는 0으로 설정
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getBanners();
      _startAutoSlider();
    });
  }

  Future<void> getBanners() async {
    await ref.read(AdvertiseProvider).getAdvertiseRandom();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlider() {
    final viewModel = ref.watch(AdvertiseProvider);

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        // 페이지를 한 단계씩 넘기도록 설정
        int nextPage =
            (_currentPage + 1) % viewModel.banners.length; // 무한 순환을 위한 계산
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final homeProvider = ref.read(HomeProvider);
    final viewModel = ref.watch(AdvertiseProvider);

    return Container(
        color: GlobalColor.primaryColor,
        child: CustomScrollView(physics: ClampingScrollPhysics(), slivers: [
          SliverToBoxAdapter(
              child: Container(
                  color: GlobalColor.white,
                  width: double.infinity,
                  height: (MediaQuery.of(context).size.width) * 6 / 16,
                        alignment: Alignment.center,
                  child: Stack(children: [
                    InkWell(
                        onTap: (){
                          ref.read(HomeProvider).pushCurrentWidget = const UserSearchScreen();
                        },
                        child:
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              height: (MediaQuery.of(context).size.width) * 6 / 24,
                              width: (MediaQuery.of(context).size.width) * 6 / 24,
                              'asset/icons/logo_star.svg',
                            ),
                            SizedBox(width: 15,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IndexThumbTitle(
                                  '로타리 3700지구',
                                ),
                                Text(
                                  '전체인원 ${2707}',
                                  style: TextStyle(
                                      fontSize: DynamicFontSize.font22(context),
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    homeProvider.pushCurrentWidget =
                                        UserSearchListScreen(initialRegion: 0);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 15, right: 5, top: 5, bottom: 5),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: GlobalColor.indexBoxColor),
                                    child: Row(
                                      children: [
                                        Text('전체보기'),
                                        Icon(Icons.arrow_right_rounded)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ))
                      // Center(
                      //   child: CircularProgressIndicator(),
                      // ),
                      //   PageView.builder(
                      //   onPageChanged: (index) {
                      //     setState(() {
                      //       _currentPage = index; // 페이지 변경 시 currentPage 갱신
                      //     });
                      //   },
                      //   controller: _pageController,
                      //   itemCount: viewModel.banners.length,
                      //   itemBuilder: (context, index) {
                      //     final bannerIndex = index % viewModel.banners.length;
                      //     return InkWell(
                      //         onTap: () {
                      //           ref.read(HomeProvider).pushCurrentWidget =
                      //               AdvertiseDetailScreen(
                      //                   imagePath:
                      //                       '${BASE_URL}/file/${viewModel.banners[bannerIndex]?.first ?? ' '}');
                      //         },
                      //         child: Image.network(
                      //           '${BASE_URL}/file/${viewModel.banners[bannerIndex]?.last ?? ' '}',
                      //           headers: const {'cheat': 'showmethemoney'},
                      //           fit: BoxFit.cover
                      //         ));
                      //   },
                      // )
                  ]))),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 1.5),
            delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
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
                        Text(
                          menuItems[index].label,
                          style: TextStyle(
                              color: GlobalColor.indexBoxColor,
                              fontSize: width * 0.035,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ));
            }, childCount: menuItems.length
                // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //   crossAxisCount: 3,
                //   childAspectRatio: 1.2,
                //   mainAxisSpacing: 1,
                //   crossAxisSpacing: 1
                // ),

                ),
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
                      SvgPicture.asset(
                        'asset/icons/logo_index.svg',
                        width: 70,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '국제로타리 3700지구',
                            style: TextStyle(
                                color: GlobalColor.indexColor,
                                fontSize: DynamicFontSize.font12(context)),
                          ),
                          Text(
                            '대구광역시 중구 동덕로 115 진석타워 5층 501호',
                            style: TextStyle(
                                color: GlobalColor.indexColor,
                                fontSize: DynamicFontSize.font12(context)),
                          ),
                          Text(
                            'TEL 053-473-3700. FAX 053-429-7901~2',
                            style: TextStyle(
                                color: GlobalColor.indexColor,
                                fontSize: DynamicFontSize.font12(context)),
                          ),
                          Text(
                            '',
                            style: TextStyle(
                                color: GlobalColor.indexColor,
                                fontSize: DynamicFontSize.font12(context)),
                          ),
                        ],
                      ),
                    ],
                  )))
        ]));
  }
}
