import 'package:flutter/material.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';
import 'package:rotary_flutter/util/global_color.dart';

import 'UserSearchList/user_search_list.dart';

class UserSearchScreen extends StatefulWidget {
  const UserSearchScreen({
    super.key,
  });

  @override
  State<UserSearchScreen> createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        return Scaffold(
          appBar: AppBar(
            title: Text('회원검색'),
            centerTitle: true,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                          width: 150,
                          child: Image.asset(
                            height: 100,
                            'asset/images/main_logo02.png',
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const UserListWidget(initialLocation: 0)));
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserListWidget(
                                initialLocation: 1)));
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
                          child: Image.asset(
                            'asset/images/main_logo03.png',
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
                                    Image.asset(
                                      'asset/images/main_logo03.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                    SizedBox(height: 10,),
                                    IndexText('${index+1}지역',)
                                  ]),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserListWidget(
                                            initialLocation: index+2)));
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
