import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/data/model/advertise_model.dart';
import 'package:rotary_flutter/feature/home/menu/advertise/advertise_view_model.dart';
import 'package:rotary_flutter/feature/home_component.dart';
import 'package:rotary_flutter/util/fontSize.dart';

import '../../../../data/model/article_model.dart';
import '../../../../util/global_color.dart';
import '../../../home_provider.dart';
import '../../home_main_component.dart';

class AdvertiseScreen extends ConsumerStatefulWidget {
  const AdvertiseScreen({super.key});

  @override
  ConsumerState<AdvertiseScreen> createState() => _AdvertiseScreen();
}

class _AdvertiseScreen extends ConsumerState<AdvertiseScreen> {
  @override
  void initState() {
    ref.read(AdvertiseProvider).getAdvertise();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var advertiseProvider = ref.watch(AdvertiseProvider);

    var list = [
      'https://mmate.flash21.com/images/rotary/rotary_slide.jpg',
      'https://mmate.flash21.com/images/rotary/rotary_slide02.jpg',
      'https://mmate.flash21.com/images/rotary/rotary_slide.jpg',
      'https://mmate.flash21.com/images/rotary/rotary_slide02.jpg',
      'https://mmate.flash21.com/images/rotary/rotary_slide.jpg',
      'https://mmate.flash21.com/images/rotary/rotary_slide02.jpg',
      'https://mmate.flash21.com/images/rotary/rotary_slide.jpg',
      'https://mmate.flash21.com/images/rotary/rotary_slide02.jpg',
      'https://mmate.flash21.com/images/rotary/rotary_slide.jpg',
      'https://mmate.flash21.com/images/rotary/rotary_slide02.jpg',
    ];

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
          data as List<Article>;

          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  SearchBox(
                    hint: '검색어를 입력해주세요',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  data.isNotEmpty
                      ? Expanded(
                          child: ListView.separated(
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Column(
                                  children: [
                                    Image.network(
                                      list[index],
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(15),
                                        color: Colors.black12,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child:
                                            IndexText('${data[index].title}'))
                                  ],
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
                ],
              ));
        });
  }
}
