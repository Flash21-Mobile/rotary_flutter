import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rotary_flutter/util/global_color.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../../../util/fontSize.dart';

class EventScreen extends StatefulWidget {
  final Map<String, dynamic>? args;

  const EventScreen({super.key, this.args});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  bool isLoaded = true;

  // 추가: EventTile 리스트 생성 (예시 데이터)
  String? category;

// 1. EventTile 리스트 생성
  final List<EventTileData> allEventTiles = [
    EventTileData(
      major: '건축과',
      st: 52,
      name: '한상수',
      location: '경북대학교 장례식장',
      startDate: '2024-08-20',
      endDate: '2024-08-22',
      obituary: true,
    ),
    EventTileData(
      major: '법학과',
      st: 52,
      name: '김철수',
      location: '신라웨딩 3층 장미홀',
      startDate: '2024-08-29',
      endDate: '',
      wedding: true,
    ),
    EventTileData(
      major: '경영학과',
      st: 52,
      name: '신짱구',
      location: '수성아트피아',
      startDate: '2024-08-28',
      endDate: '',
      event: true,
    ),
    // 필요시 더 많은 EventTileData 추가 가능
  ];
  List<dynamic> eventList = [];
  List<dynamic> allEventList = [];
  @override
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime? startDate; // 일정의 시작 날짜
  DateTime? endDate; // 일정의 종료 날짜
  Map<DateTime, List<String>> events = {}; // 날짜별 일정 데이터
  // List<String>
  // 날짜 선택 시 호출되는 함수
  Future<void> onDaySelected(
      DateTime selectedDate, DateTime focusedDate) async {
    setState(() {
      isLoaded = false;
      this.selectedDate = selectedDate;
    });
    String formattedDate = DateFormat('yyyyMM').format(selectedDate);
    String formattedDate2 = DateFormat('yyyy-MM-dd').format(selectedDate);
    print('현재 선택한 날짜 ${formattedDate}');
    // var result = await EventsApi().getEventsList('con', category, formattedDate);
    setState(() {
      // List<dynamic> eventData = result.data;
      // allEventList = result.data;
      // eventList = eventData.where((item) => item.board_eventsdate == formattedDate2).toList();
      isLoaded = true;
    });
  }

  // 이전 달로 이동
  void _goToPreviousMonth() {
    setState(() {
      selectedDate = DateTime(
        selectedDate.year,
        selectedDate.month - 1,
        selectedDate.day,
      );
    });
  }

  // 다음 달로 이동
  void _goToNextMonth() {
    setState(() {
      selectedDate = DateTime(
        selectedDate.year,
        selectedDate.month + 1,
        selectedDate.day,
      );
    });
  }

  // 연도 선택 팝업
  Future<void> _selectYear() async {
    int? selectedYear = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('연도를 선택하세요'),
          content: SizedBox(
            height: 200,
            width: 200,
            child: ListView.builder(
              itemCount: 51, // 2000년부터 2050년까지
              itemBuilder: (BuildContext context, int index) {
                int year = 2000 + index;
                return ListTile(
                  title: Text('$year'),
                  onTap: () {
                    Navigator.of(context).pop(year);
                  },
                );
              },
            ),
          ),
        );
      },
    );

    if (selectedYear != null) {
      setState(() {
        selectedDate =
            DateTime(selectedYear, selectedDate.month, selectedDate.day);
      });
    }
  }

  // 월 선택 팝업
  Future<void> _selectMonth() async {
    int? selectedMonth = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('월을 선택하세요'),
          content: SizedBox(
            height: 200,
            width: 200,
            child: ListView.builder(
              itemCount: 12,
              itemBuilder: (BuildContext context, int index) {
                int month = index + 1;
                return ListTile(
                  title: Text('$month월'),
                  onTap: () {
                    Navigator.of(context).pop(month);
                  },
                );
              },
            ),
          ),
        );
      },
    );

    if (selectedMonth != null) {
      setState(() {
        selectedDate =
            DateTime(selectedDate.year, selectedMonth, selectedDate.day);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    onDaySelected(selectedDate, selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColor.white,
      appBar: AppBar(
        title: Text('배점표'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: _selectYear,
                    child: Text(
                      '${selectedDate.year}년',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 18,
                    ),
                    onTap: _goToPreviousMonth, // 이전 달로 이동
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: _selectMonth, // 월 선택 팝업 호출
                    child: Text(
                      '${selectedDate.month}월',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                    ),
                    onTap: _goToNextMonth, // 다음 달로 이동
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              // TableCalendar
              Container(
                decoration: BoxDecoration(
                    color: GlobalColor.indexBoxColor,
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.symmetric(vertical: 20),
                child: TableCalendar(
                  onDaySelected: onDaySelected,

                  selectedDayPredicate: (date) {
                    return isSameDay(selectedDate, date);
                  },
                  onPageChanged: (focusedDay) {
                    String formattedDate = DateFormat('MM').format(focusedDay);
                    setState(() {
                      selectedDate = focusedDay;
                      onDaySelected(selectedDate, selectedDate);
                    });
                  },
                  focusedDay: selectedDate,
                  firstDay: DateTime(2000),
                  lastDay: DateTime(2050),
                  headerVisible: false,
                  // 기본 헤더를 숨김
                  eventLoader: (day) {
                    // 선택된 날짜에 해당하는 이벤트를 반환
                    String formattedDate = DateFormat('yyyy-MM-dd').format(day);
                    if (allEventList.any((item) {
                      return item.board_eventsdate == formattedDate;
                    })) {
                      return ['hi'];
                    } else
                      return [];
                  },
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: const Color.fromARGB(86, 5, 73, 151),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: GlobalColor.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: BoxDecoration(
                      // 이벤트 마커 표시
                      color: Colors.red, // 이벤트가 있는 날짜에 표시될 마커 색상
                      shape: BoxShape.circle,
                    ),
                    markersAlignment: Alignment.bottomCenter,
                    // 마커 위치
                    markerSize: 6.0, // 마커 크기
                  ),
                ),
              ),
              // 선택한 날짜의 일정 목록 표시
              if (isLoaded)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      if (eventList.length == 0)
                        Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 35,
                              ),
                              Text(
                                '해당 날짜에는 이벤트가 없습니다',
                                style: TextStyle(
                                    fontSize: DynamicFontSize.font18(context)),
                              )
                            ],
                          ),
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    // context.pushNamed('EventDetailScreen',
                                    //     extra: {
                                    //       'type': eventList[index].board_id??'con',
                                    //       'no': eventList[index].board_no
                                    //     });
                                  },
                                  child: EventTile(
                                    major: eventList[index].create_name,
                                    st: 0,
                                    category: eventList[index].board_type,
                                    name: eventList[index].board_title,
                                    location:
                                        '${eventList[index].board_address}',
                                    startDate:
                                        eventList[index].board_eventsdate,
                                    endDate: eventList[index].board_eventedate,
                                    obituary: false,
                                    wedding: false,
                                    event: false,
                                  ),
                                ),
                                // 마지막 EventTile이 아닐 경우에만 간격 추가
                                if (index < allEventTiles.length - 1)
                                  SizedBox(height: 10),
                              ],
                            );
                          },
                          itemCount: eventList.length,
                        )
                      // for(var i=0; i<eventList!.length!; i++)
                    ],
                  ),
                )
              else
                Padding(
                  padding: EdgeInsets.all(50),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: const Color.fromARGB(255, 105, 112, 120),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class EventTileData {
  final String major;
  final int st;
  final String name;
  final String location;
  final String startDate;
  final String endDate;
  final bool obituary;
  final bool wedding;
  final bool event;

  EventTileData({
    required this.major,
    required this.st,
    required this.name,
    required this.location,
    required this.startDate,
    required this.endDate,
    this.obituary = false,
    this.wedding = false,
    this.event = false,
  });
}

class EventTile extends StatelessWidget {
  final String major;
  final int st;
  final String name;
  final String location;
  final String startDate;
  final String endDate;
  final String category;
  final bool wedding;
  final bool obituary;
  final bool event;
  final bool detail;
  final Map? detailInfo;

  const EventTile(
      {super.key,
      required this.name,
      required this.category,
      required this.location,
      required this.startDate,
      required this.endDate,
      required this.st,
      required this.major,
      this.wedding = false,
      this.obituary = false,
      this.event = false,
      this.detail = false,
      this.detailInfo});

  @override
  Widget build(BuildContext context) {
    String eventType = '';
    Color eventTypeColor = Colors.transparent;
    if (category == 'marriage') {
      eventType = '결혼';
      eventTypeColor = Color(0xffFF5C00);
    } else if (category == 'obituary') {
      eventType = '부고';
      eventTypeColor = Colors.black;
    } else if (event) {
      eventType = '행사';
      eventTypeColor = GlobalColor.indexBoxColor;
    }
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: detail ? GlobalColor.black : Colors.white,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: SizedBox(
                  // height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   '$major',
                      //   style: TextStyle(
                      //       fontSize: DynamicFontSize.font18(context),
                      //       fontWeight: FontWeight.w700),
                      // ),
                      Wrap(
                        runSpacing: 5,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: DynamicFontSize.font18(context),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 48,
                            height: DynamicFontSize.font19(context),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: eventTypeColor,
                            ),
                            child: Center(
                              child: Text(
                                eventType,
                                style: TextStyle(
                                  fontSize: DynamicFontSize.font10(context),
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      if (location != null && location != '')
                        Container(
                          // width: double.infinity,
                          height: DynamicFontSize.font19(context) * 2,
                          padding: EdgeInsets.all(7.5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: GlobalColor.black,
                          ),
                          child: Text(
                            location,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: DynamicFontSize.font17(context),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      if (location != null && location != '')
                        SizedBox(
                          height: 15,
                        ),
                      Text(
                        '$startDate',
                        style: TextStyle(
                            color: GlobalColor.primaryColor,
                            fontSize: DynamicFontSize.font15(context),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          detail ? Divider() : SizedBox.shrink(),
          detail
              ? SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '마음전할곳',
                        style: TextStyle(
                          fontSize: DynamicFontSize.font15(context),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${detailInfo!['bank']}  ${detailInfo!['account']}',
                            style: TextStyle(
                              fontSize: DynamicFontSize.font20(context),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(
                                  ClipboardData(text: detailInfo!['account']));
                            },
                            child: Container(
                              height: DynamicFontSize.font20(context) +
                                  DynamicFontSize.font18(context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: GlobalColor.primaryColor,
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: DynamicFontSize.font20(context)),
                              child: Center(
                                child: Text(
                                  '복사',
                                  style: TextStyle(
                                    fontSize: DynamicFontSize.font20(context),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}