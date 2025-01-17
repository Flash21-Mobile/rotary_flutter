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
      getBanners().then((value) {
        if (value is Success) _startAutoSlider();
      });
    });
  }


  Future<LoadState> getBanners() async {
    return await ref.read(HomeMainProvider).getAdvertiseRandom();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlider() {
    final viewModel = ref.watch(HomeMainProvider);

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        // 페이지를 한 단계씩 넘기도록 설정
        int nextPage =
            (_currentPage + 1) % viewModel.futureBanners.length; // 무한 순환을 위한 계산
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
    final viewModel = ref.watch(HomeMainProvider);

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
                                IndexMaxTitle(
                                  '로타리 3700지구',
                                ),
                                Text(
                                  '전체인원 ${2707}',
                                  style: TextStyle(
                                      fontSize: DynamicFontSize.font22(context),
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 16,
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
                      )),
                    // PageView.builder(
                    //   onPageChanged: (index) {
                    //     setState(() {
                    //       _currentPage = index; // 페이지 변경 시 currentPage 갱신
                    //     });
                    //   },
                    //   controller: _pageController,
                    //   itemCount: viewModel.futureBanners.length,
                    //   itemBuilder: (context, index) {
                    //     return InkWell(
                    //         onTap: () {
                    //           Log.d('${viewModel.futureBanners[index]}');
                    //           Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    //             return AdvertiseDetailScreen(data: viewModel.advertises[index]);
                    //           }));
                    //         },
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           children: [
                    //             ClipRRect(
                    //                 borderRadius: BorderRadius.circular(10),
                    //                 child: FutureImage(
                    //                     viewModel.futureBanners[index],
                    //                     width: 100,
                    //                     height: 100,
                    //                     onError: SizedBox())),
                    //             SizedBox(
                    //               width: 15,
                    //             ),
                    //             Container(
                    //                 width:
                    //                     MediaQuery.of(context).size.width - 145,
                    //                 child: Column(
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.center,
                    //                   children: [
                    //                     IndexTitle(
                    //                         '${viewModel.advertises[index].title}'),
                    //                     SizedBox(
                    //                       height: 8,
                    //                     ),
                    //                     ...viewModel.advertises[index]
                    //                                 .content !=
                    //                             '설명없음'
                    //                         ? [
                    //                             Container(
                    //                                 child: IndexMinText(
                    //                               '${viewModel.advertises[index].content}',
                    //                               maxLength: 2,
                    //                               textColor:
                    //                                   GlobalColor.indexColor,
                    //                             )),
                    //                             SizedBox(
                    //                               height: 5,
                    //                             )
                    //                           ]
                    //                         : [SizedBox()],
                    //                     IndexMinText(
                    //                         '${viewModel.advertises[index].account?.grade?.name} / ${viewModel.advertises[index].account?.name}')
                    //                   ],
                    //                 ))
                    //           ],
                    //         ));
                    //   },
                    // ),
                    // Container(
                    //   margin: EdgeInsets.all(8),
                    //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    //   decoration: BoxDecoration(
                    //       color: GlobalColor.black.withAlpha(900),
                    //       borderRadius: BorderRadius.circular(100)),
                    //   child: IndexMinText(
                    //     '${_currentPage + 1} / 5',
                    //     textColor: GlobalColor.white,
                    //   ),
                    // ),
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
