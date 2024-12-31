import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rotary_flutter/feature/home_view_model.dart';
import 'package:rotary_flutter/util/global_color.dart';

import '../../util/model/menu_items.dart';
import '../advertise/advertise_screen.dart';

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

  final _banners = [
    'asset/images/star_slide.jpg',
    'asset/images/rotary_slide.png'
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlider();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlider() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        // 페이지를 한 단계씩 넘기도록 설정
        int nextPage = (_currentPage + 1) % _banners.length; // 무한 순환을 위한 계산
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

    final homeProvider =ref.read(HomeProvider);

    return Container(color: GlobalColor.primaryColor, child: CustomScrollView(
            physics: ClampingScrollPhysics(),
            slivers: [
          SliverToBoxAdapter(
              child:InkWell(
                  onTap: (){
                    ref.read(HomeProvider).pushCurrentWidget = AdvertiseScreen();
                  },
                  child:Container(
                  width: double.infinity,
                  height: (MediaQuery.of(context).size.width) * 6 / 16,
                  child: PageView.builder(
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index; // 페이지 변경 시 currentPage 갱신
                      });
                    },
                    controller: _pageController,
                    itemCount: _banners.length,
                    itemBuilder: (context, index) {
                      final bannerIndex = index % _banners.length;
                      return Image.asset(
                        _banners[bannerIndex],
                        fit: BoxFit.cover,
                      );
                    },
                  )))),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.6),
            delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              // return Container(width: 50, height: 50,color: Colors.black,);
              return InkWell(
                  onTap: (){
                    homeProvider.pushCurrentWidget =menuItems[index].widget;
                    if(menuItems[index].onTap != null) menuItems[index].onTap!();
                    },
                  child:Container(
                decoration: BoxDecoration(
                  color: GlobalColor.primaryColor,
                  border: Border.all(
                    width: 0.5,
                      color: Colors.white24),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    menuItems[index].iconPath== null
                    ?SizedBox()
                    :SvgPicture.asset(
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
        ]));
  }
}
