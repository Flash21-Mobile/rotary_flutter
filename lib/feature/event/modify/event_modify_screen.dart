import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:rotary_flutter/data/model/event_model.dart';
import 'package:rotary_flutter/feature/myInfo/modify/my_info_modify_component.dart';

import '../../../util/global_color.dart';
import '../../home/home_main_component.dart';
import '../../home_view_model.dart';

class EventModifyScreen extends ConsumerStatefulWidget {
  const EventModifyScreen({super.key});

  @override
  ConsumerState<EventModifyScreen> createState() => _Widget();
}

class _Widget extends ConsumerState<EventModifyScreen> {
  String? onFocused;

  int _dayTime = 3;
  int _hour = 11;
  int _min = 34;

  final _dataTimeList = ['오전', '오후'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalColor.white,
        appBar: AppBar(
          title: Text('행사 추가'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              ref.read(HomeProvider).popCurrentWidget();
            },
          ),
        ),
        body: Column(children: [
          Expanded(
              child: Column(
            children: [
              SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyInfoModifyTextField(
                            indexTitle: '제목',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '행사 날짜',
                            style:
                                TextStyle(color: GlobalColor.darkGreyFontColor),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: InkWell(
                                      splashColor: GlobalColor.indexBoxColor,
                                      highlightColor: GlobalColor.indexBoxColor,
                                      borderRadius: BorderRadius.circular(100),
                                      onTap: () {
                                        setState(() {
                                          if (onFocused != 'date')
                                            onFocused = 'date';
                                          else
                                            onFocused = null;
                                        });
                                      },
                                      child: Container(
                                        decoration: onFocused == 'date'
                                            ? BoxDecoration(
                                                color:
                                                    GlobalColor.indexBoxColor,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              )
                                            : null,
                                        padding: EdgeInsets.all(10),
                                        alignment: Alignment.center,
                                        child: onFocused == 'date'
                                            ? IndexTitle(
                                                '1월 26일 (일)',
                                              )
                                            : IndexText(
                                                '1월 26일 (일)',
                                              ),
                                      ))),
                              Expanded(
                                  child: InkWell(
                                      splashColor: GlobalColor.indexBoxColor,
                                      highlightColor: GlobalColor.indexBoxColor,
                                      borderRadius: BorderRadius.circular(100),
                                      onTap: () {
                                        setState(() {
                                          if (onFocused != 'time')
                                            onFocused = 'time';
                                          else
                                            onFocused = null;
                                        });
                                      },
                                      child: Container(
                                        decoration: onFocused == 'time'
                                            ? BoxDecoration(
                                                color:
                                                    GlobalColor.indexBoxColor,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              )
                                            : null,
                                        padding: EdgeInsets.all(10),
                                        alignment: Alignment.center,
                                        child: onFocused == 'time'
                                            ? IndexTitle(
                                                '${_dataTimeList[_dayTime]} $_hour:$_min',
                                              )
                                            : IndexText(
                                          '${_dataTimeList[_dayTime]} $_hour:$_min',
                                              ),
                                      )))
                            ],
                          ),
                        ... onFocused == 'time' ?
                        [
                          SizedBox(height: 15),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: GlobalColor.indexBoxColor,
                          ),
                          Row(children: [
                            Container(
                                //todo r: 연도 선택할때 올해 가운데 오게 하기
                                height: 160,
                                width:
                                    (MediaQuery.of(context).size.width - 30) /
                                        3,
                                child: CupertinoPicker(
                                    itemExtent: 50.0,
                                    scrollController:
                                        FixedExtentScrollController(
                                            initialItem: 0),
                                    onSelectedItemChanged: (index) {
                                      setState(() {
                                        _dayTime = index;
                                      });
                                    },
                                    children: List.generate(2, (index) {
                                      return Center(
                                          child: Text(
                                        _dataTimeList[index],
                                        style: TextStyle(
                                          fontSize: 30,
                                        ),
                                      ));
                                    }))),
                            Container(
                                //todo r: 연도 선택할때 올해 가운데 오게 하기
                                height: 160,
                                width:
                                    (MediaQuery.of(context).size.width - 30) /
                                        3,
                                child: CupertinoPicker(
                                    itemExtent: 50.0,
                                    scrollController:
                                        FixedExtentScrollController(
                                            initialItem: 0),
                                    onSelectedItemChanged: (index) {
                                      setState(() {
                                        _hour = index;
                                      });
                                    },
                                    children: List.generate(12, (index) {
                                      return Center(
                                          child: Text(
                                        '${index + 1}',
                                        style: TextStyle(
                                          fontSize: 30,
                                        ),
                                      ));
                                    }))),
                            Container(
                                //todo r: 연도 선택할때 올해 가운데 오게 하기
                                height: 160,
                                width:
                                    (MediaQuery.of(context).size.width - 30) /
                                        3,
                                child: CupertinoPicker(
                                    itemExtent: 50.0,
                                    scrollController:
                                        FixedExtentScrollController(
                                            initialItem: 0),
                                    onSelectedItemChanged: (index) {
                                      setState(() {
                                        _min  = index;
                                      });
                                    },
                                    children: List.generate(60, (index) {
                                      return Center(
                                          child: Text(
                                        '$index',
                                        style: TextStyle(
                                          fontSize: 30,
                                        ),
                                      ));
                                    }))),
                          ]),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: GlobalColor.indexBoxColor,
                          ),
                          SizedBox(height: 15),
]: [SizedBox()]
                          // IndexMinText('${formatDateTime(widget.event.time)}',textColor: GlobalColor.greyFontColor,)
                        ])),
              )
            ],
          ))
        ]));
  }

  String formatDateTime(String? dateTime) {
    DateTime parsedDate = DateTime.parse(dateTime ?? '');
    return "${parsedDate.year}.${parsedDate.month.toString().padLeft(2, '0')}.${parsedDate.day.toString().padLeft(2, '0')}";
  }
}
