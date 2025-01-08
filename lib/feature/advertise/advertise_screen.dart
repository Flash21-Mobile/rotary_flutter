import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/data/model/advertise_model.dart';
import 'package:rotary_flutter/feature/advertise/advertise_component.dart';
import 'package:rotary_flutter/feature/home_component.dart';
import 'package:rotary_flutter/feature/userSearch/list/user_search_list_component.dart';
import 'package:rotary_flutter/util/common/common.dart';
import 'package:rotary_flutter/util/fontSize.dart';

import '../../../../data/model/advertise_model.dart';
import '../../../../util/global_color.dart';
import '../home/home_main_component.dart';
import '../home_view_model.dart';
import 'advertise_view_model.dart';

class AdvertiseScreen extends ConsumerStatefulWidget {
  const AdvertiseScreen({super.key});

  @override
  ConsumerState<AdvertiseScreen> createState() => _AdvertiseScreen();
}

class _AdvertiseScreen extends ConsumerState<AdvertiseScreen> {
  @override
  void initState() {
    ref.read(AdvertiseProvider).getAdvertiseAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var advertiseProvider = ref.watch(AdvertiseProvider);

    return LoadStateScaffold(
        loadState: advertiseProvider.advertiseState,
        backgroundColor: GlobalColor.white,
        appBar: AppBar(
          title: Text('광고협찬'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              ref.read(HomeProvider).popCurrentWidget();
            },
          ),
        ),
        successBody: (data) {
          data as List<List<String>?>;



          return Column(children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: SearchBox(
                hint: '검색어를 입력해주세요',
              ),
            ),
            SizedBox(
              height: 15,
            ),
            data.isNotEmpty
                ? Expanded(
                    child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            ref.read(HomeProvider).pushCurrentWidget =
                                AdvertiseDetailScreen(
                                    imagePath:
                                        '${BASE_URL}/file/${data[index]?.first ?? ' '}');
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height:
                                (MediaQuery.of(context).size.width) * 6 / 16,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              // 둥근 모서리 크기
                              border: Border.all(
                                color: GlobalColor.indexColor, // 보더 색상
                                width: 1.0, // 보더 두께
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                '${BASE_URL}/file/${data[index]?.last ?? ' '}',
                                headers: const {'cheat': 'showmethemoney'},
                                fit: BoxFit.cover, // 이미지가 영역을 채우도록
                                errorBuilder: (context, error, stackTrace){
                                  return SizedBox();
                                },
                              ),
                            ),
                          ));
                    },
                    separatorBuilder: (_, $) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: data.length,
                  ))
                : Expanded(
                    child: Column(
                    children: [
                      SizedBox(
                        height: 150,
                      ),
                      Text(
                        'ⓘ',
                        style: TextStyle(fontSize: 40),
                      ),
                      IndexText('조회된 데이터가 없습니다.'),
                    ],
                  ))
          ]);
        },
        errorBody: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(children: [
              SearchBox(
                hint: '검색어를 입력해주세요',
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                  child: Column(
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  Text(
                    'ⓘ',
                    style: TextStyle(fontSize: 40),
                  ),
                  IndexText('조회된 데이터가 없습니다.'),
                ],
              )),
            ])));
  }
}
