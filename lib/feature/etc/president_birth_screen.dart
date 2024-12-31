import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/util/fontSize.dart';

import '../../../util/global_color.dart';
import '../home/home_main_component.dart';
import '../home_view_model.dart';

class PresidentBirthScreen extends ConsumerStatefulWidget {
  const PresidentBirthScreen({super.key});

  @override
  ConsumerState<PresidentBirthScreen> createState() => _PresidentBirthScreen();
}

class _PresidentBirthScreen extends ConsumerState<PresidentBirthScreen> {
  var list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalColor.white,
        appBar: AppBar(
          title: Text('총재월신'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SearchBox(hint: '검색어를 입력해주세요',),
              list.isNotEmpty
                  ? ListView.builder(itemBuilder: (context, index) {
                      return Placeholder();
                    })
                  : Expanded(child: Column(
                      children: [
                        SizedBox(height: 150,),
                        Text('ⓘ',
                          style: TextStyle(
                              fontSize: 40),
                        ),
                        IndexText('조회된 데이터가 없습니다.'),
                      ],
                    ))
            ],
          ),
        ));
  }
}
