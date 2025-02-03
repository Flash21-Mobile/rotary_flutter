import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:rotary_flutter/data/model/event/response/event_model.dart';
import 'package:rotary_flutter/feature/event/event_view_model.dart';
import 'package:rotary_flutter/feature/myInfo/modify/my_info_modify_component.dart';
import 'package:rotary_flutter/util/model/loadstate.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../util/fontSize.dart';
import '../../../util/global_color.dart';
import '../../home/home_main_component.dart';
import '../../home_view_model.dart';

class EventModifyScreen extends ConsumerStatefulWidget {
  const EventModifyScreen({super.key});

  @override
  ConsumerState<EventModifyScreen> createState() => _Widget();
}

class _Widget extends ConsumerState<EventModifyScreen> {
  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  set setSelectedData(DateTime dateTime) {
    setState(() {
      _selectedDate = dateTime;
      _weekday = _weekdayList[dateTime.weekday - 1];
    });
  }

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  String? onFocused = 'date';

  late String _weekday;

  late int _period;
  late int _hour;
  late int _min;

  final List<String> _weekdayList = ['월', '화', '수', '목', '금', '토', '일'];

  final _periodLists = ['오전', '오후'];

  @override
  void initState() {
    super.initState();
    var time = DateTime.now();
    setState(() {
      _weekday = _weekdayList[time.weekday - 1]; // Flutter는 월요일부터 시작
      _period = time.hour >= 12 ? 1 : 0;
      _hour = time.hour > 12 ? time.hour - 12 : time.hour; // 12시간 형식
      _hour = _hour == 0 ? 12 : _hour;
      _min = time.minute;
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(EventProvider);

    return Scaffold(
        backgroundColor: GlobalColor.white,
        appBar: AppBar(
          title: IndexMaxTitle('행사 추가'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: GlobalColor.primaryColor),
                    child: IndexText(
                      '저장',
                       defaultScale: true,
                       textColor: GlobalColor.white,
                    ),
                  ),
                  onTap: () async {
                    if (titleController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('제목을 입력해주세요'),
                        ),
                      );
                    } else if (contentController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('내용을 입력해주세요'),
                          duration: Duration(milliseconds: 1500),
                        ),
                      );
                    } else {
                      DateTime dateTime = DateTime(_selectedDate.year,
                          _selectedDate.month, _selectedDate.day, _hour, _min);

                      // ISO 8601 형식으로 변환
                      String iso8601String = dateTime.toIso8601String();
                      var response = await viewModel.postEvent(
                          titleController.text,
                          contentController.text,
                          iso8601String);

                      if (response is Success) {
                        Navigator.pop(context);
                      }
                    }
                  },
                ))
          ],
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyInfoModifyTextField(
                        indexTitle: '제목',
                        indexController: titleController,
                        multilineEnable: true,
                        keyboardType: TextInputType.multiline,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MyInfoModifyTextField(
                        indexTitle: '행사 내용',
                        indexController: contentController,
                        multilineEnable: true,
                        keyboardType: TextInputType.multiline,
                      ),
                      SizedBox(
                        height: 20
                      ),
                      IndexText(
                        '행사 날짜'
                      ),
                      SizedBox(
                        height: 5
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
                                            color: GlobalColor.indexBoxColor,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          )
                                        : null,
                                    padding: EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    child: onFocused == 'date'
                                        ? IndexTitle(
                                            '${selectedDate.month}월 ${selectedDate.day}일 ($_weekday)',
                                          )
                                        : IndexText(
                                            '${selectedDate.month}월 ${selectedDate.day}일 ($_weekday)',
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
                                            color: GlobalColor.indexBoxColor,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          )
                                        : null,
                                    padding: EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    child: onFocused == 'time'
                                        ? IndexTitle(
                                            '${_periodLists[_period]} $_hour:$_min',
                                          )
                                        : IndexText(
                                            '${_periodLists[_period]} $_hour:$_min',
                                          ),
                                  )))
                        ],
                      ),
                      switch (onFocused) {
                        'time' => timePicker(),
                        'date' => datePiker(),
                        _ => SizedBox()
                      }

                      // IndexMinText('${formatDateTime(widget.event.time)}',textColor: GlobalColor.greyFontColor,)
                    ])),
          )
        ])));
  }

  String formatDateTime(String? dateTime) {
    DateTime parsedDate = DateTime.parse(dateTime ?? '');
    return "${parsedDate.year}.${parsedDate.month.toString().padLeft(2, '0')}.${parsedDate.day.toString().padLeft(2, '0')}";
  }

  Widget timePicker() {
    return Column(children: [
      SizedBox(height: 15),
      Container(
        height: 1,
        width: double.infinity,
        color: GlobalColor.indexBoxColor,
      ),
      Row(children: [
        // 오전, 오후
        Container(
            height: 160,
            width: (MediaQuery.of(context).size.width - 30) / 3,
            child: CupertinoPicker(
                itemExtent: 50.0,
                scrollController: FixedExtentScrollController(initialItem: 0),
                onSelectedItemChanged: (index) => setState(() {
                      _period = index;
                      _updateSelectedDate();
                    }),
                children: List.generate(2, (index) {
                  return Center(
                      child: Text(
                    _periodLists[index],
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ));
                }))),

        // 시각
        Container(
            height: 160,
            width: (MediaQuery.of(context).size.width - 30) / 3,
            child: CupertinoPicker(
                itemExtent: 50.0,
                scrollController:
                    FixedExtentScrollController(initialItem: _hour),
                onSelectedItemChanged: (index) {
                  setState(() {
                    _hour = index + 1;
                    _updateSelectedDate();
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

        // 분
        Container(
            height: 160,
            width: (MediaQuery.of(context).size.width - 30) / 3,
            child: CupertinoPicker(
                itemExtent: 50.0,
                scrollController:
                    FixedExtentScrollController(initialItem: _min),
                onSelectedItemChanged: (index) {
                  setState(() {
                    _min = index;
                    _updateSelectedDate();
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
    ]);
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => _selectYear(context, selectedDate.year),
                child: Text(
                  '${selectedDate.year}년',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: DynamicFontSize.font22(context)),
                ),
              )
            ],
          ),
          Container(
              width: 80,
              child: InkWell(
                onTap: () => _selectMonth(context),
                child: Text(
                  textAlign: TextAlign.center,
                  '${selectedDate.month}월',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: DynamicFontSize.font22(context)),
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Icon(Icons.arrow_left, size: 40),
                onTap: () {
                  setState(() {
                    setSelectedData = DateTime(selectedDate.year,
                        selectedDate.month - 1, selectedDate.day);
                  });
                },
              ),
              SizedBox(
                width: 80,
              ),
              InkWell(
                child: Icon(Icons.arrow_right, size: 40),
                onTap: () {
                  setState(() {
                    setSelectedData = DateTime(selectedDate.year,
                        selectedDate.month + 1, selectedDate.day);
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget datePiker() {
    return Column(
      children: [
        _buildHeader(context),
        TableCalendar(
          locale: 'ko_KR',
          focusedDay: selectedDate,
          firstDay: DateTime(2000),
          lastDay: DateTime(2050, 12, 31),
          headerVisible: false,
          onDaySelected: (selectedDay, _) {
            setState(() {
              setSelectedData = selectedDay;
            });
          },
          selectedDayPredicate: (date) => isSameDay(selectedDate, date),
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: GlobalColor.black,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: GlobalColor.transparent,
              shape: BoxShape.circle,
            ),
            todayTextStyle: TextStyle(color: GlobalColor.black),
          ),
          onPageChanged: (focusedDay) {
            setState(() {
              setSelectedData = focusedDay;
            });
          },
        )
      ],
    );
  }

  Future<void> _selectYear(BuildContext context, int currentYear) async {
    final ScrollController scrollController = ScrollController();

    final selectedYear = await showDialog<int>(
      context: context,
      builder: (context) {
        // 대화상자 내에서 선택된 연도로 자동 스크롤을 이동
        Future.delayed(Duration.zero, () {
          final selectedIndex = currentYear - 2000;
          scrollController.jumpTo(selectedIndex * 50 - 50); // 아이템 높이에 맞춰 스크롤 이동
        });

        return AlertDialog(
          title: const Text('연도를 선택하세요'),
          content: SizedBox(
            height: 300,
            width: 200,
            child: ListView.builder(
              controller: scrollController,
              itemCount: 51, // 2000년부터 2050년까지
              itemBuilder: (_, index) {
                final year = 2000 + index;
                bool isSelected = year == currentYear; // 선택된 연도

                return InkWell(
                    onTap: () {
                      Navigator.of(context).pop(year);
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 15),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color:
                              isSelected ? GlobalColor.lightPrimaryColor : null,
                          borderRadius: BorderRadius.circular(15)),
                      // 선택된 항목 배경색
                      child: Text('$year년'),
                    ));
              },
            ),
          ),
        );
      },
    );
    if (selectedYear != null) {
      setState(() {
        setSelectedData =
            DateTime(selectedYear, selectedDate.month, selectedDate.day);
      });
    }
  }

  Future<void> _selectMonth(BuildContext context) async {
    final selectedMonth = await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('월을 선택하세요'),
        content: SizedBox(
          height: 300,
          width: 200,
          child: ListView.builder(
            itemCount: 12, // 1월부터 12월까지
            itemBuilder: (_, index) {
              final month = index + 1;
              return ListTile(
                title: Text('$month월'),
                onTap: () => Navigator.of(context).pop(month),
              );
            },
          ),
        ),
      ),
    );
  }

  void _updateSelectedDate() {
    final adjustedHour = _period == 1 ? _hour + 12 : _hour; // 오후면 +12
    setSelectedData = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      adjustedHour == 24 ? 0 : adjustedHour, // 24시는 0으로 처리
      _min,
    );
  }
}
