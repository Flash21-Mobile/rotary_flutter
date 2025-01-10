import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';
import 'package:rotary_flutter/feature/home_view_model.dart';
import 'package:rotary_flutter/util/global_color.dart';

import 'list/user_search_list_screen.dart';


class UserSearchScreen extends ConsumerStatefulWidget {
  const UserSearchScreen({
    super.key,
  });

  @override
  ConsumerState<UserSearchScreen> createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends ConsumerState<UserSearchScreen> {
  @override
  Widget build(BuildContext context) {
    var homeProvider = ref.read(HomeProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        return Scaffold(
          appBar: AppBar(
            title: Text('회원검색'),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                ref.read(HomeProvider).popCurrentWidget();
              },
            ),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 15,right: 15, bottom: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),    //todo r: 인원수
                  Row(
                    children: [
                      Container(
                          width: 150,
                          child: SvgPicture.asset(
                            height: 100,
                            'asset/icons/logo_star.svg',
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IndexThumbTitle(
                            '로타리 3700지구',
                          ),
                          Text(
                            '전체인원 ${2707}',
                            style: TextStyle(
                                fontSize: maxWidth * 0.035,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              homeProvider.pushCurrentWidget = UserSearchListScreen(initialRegion: 0);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 15, right: 5, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
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
                  SizedBox(height: 10),
                InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  onTap: (){

                        homeProvider.pushCurrentWidget = UserSearchListScreen(initialRegion: 1);
                  },
                    child: Container(
                    height: 95,
                    decoration: BoxDecoration(
                        color: GlobalColor.indexBoxColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: SvgPicture.asset(
                            'asset/icons/logo_rotary.svg',
                            width: 30,
                            height: 30,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IndexThumbTitle(
                              '지구지도부',
                            ),
                            SizedBox(width: 10),
                            IndexText('132명'),
                          ],)
                      ],
                    ))),

                  SizedBox(height: 10),
                  GridView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.3,
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10),
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      return Container(

                          decoration: BoxDecoration(
                              color: GlobalColor.indexBoxColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      'asset/icons/logo_rotary.svg',
                                      width: 30,
                                      height: 30,
                                    ),
                                    SizedBox(height: 10,),
                                    IndexText('${index+1}지역',)
                                  ]),
                              onTap: () {
                      homeProvider.pushCurrentWidget = UserSearchListScreen(initialRegion: index +1);
                      }));
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
