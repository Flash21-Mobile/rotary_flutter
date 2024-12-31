import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/data/model/event_model.dart';
import 'package:rotary_flutter/feature/event/event_view_model.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';
import 'package:rotary_flutter/feature/home_component.dart';
import 'package:rotary_flutter/util/global_color.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../../../../util/fontSize.dart';
import '../../util/logger.dart';
import '../../util/model/loadstate.dart';
import '../home_view_model.dart';
import 'detail/event_detail_screen.dart';
import 'event_component.dart';

class EventScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic>? args;

  const EventScreen({super.key, this.args});

  @override
  ConsumerState<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends ConsumerState<EventScreen> {
  bool isLoaded = true;

  // 추가: EventTile 리스트 생성 (예시 데이터)
  String? category;

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(EventProvider).getEvent();
    });
  }

  Future<void> onDaySelected(
      DateTime selectedDate, DateTime focusedDate) async {
    setState(() {
      this.selectedDate = selectedDate;
    });
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    Log.d('현재 선택한 날짜 ${selectedDate}');

    selectedEvents = _eventLoaderData(selectedDate);

    setState(() {});
  }

  List<String> _eventLoader(DateTime day) {
    var data = (ref.read(EventProvider).eventState as Success).data;
    data as List<EventModel>;

    return data
        .where((data) {
          final indexData = DateTime.tryParse(data.time ?? '');
          if (indexData == null) return false;
          return indexData.year == day.year &&
              indexData.month == day.month &&
              indexData.day == day.day;
        })
        .map((event) => event.content ?? '')
        .toList(); // content 값 반환
  }

  List<EventModel> _eventLoaderData(DateTime day) {
    var data = (ref.read(EventProvider).eventState as Success).data;
    data as List<EventModel>;

    return data
        .where((data) {
          final indexData = DateTime.tryParse(data.time ?? '');
          if (indexData == null) return false;
          return indexData.year == day.year &&
              indexData.month == day.month &&
              indexData.day == day.day;
        })
        .map((event) => event)
        .toList(); // content 값 반환
  }

  List<EventModel> selectedEvents = [];

  @override
  Widget build(BuildContext context) {
    var eventProvider = ref.watch(EventProvider);
    var homeProvider = ref.read(HomeProvider);

    Log.d('selectedEvent: $selectedEvents');

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: LoadStateScaffold(
            loadState: eventProvider.eventState,
            backgroundColor: GlobalColor.white,
            appBar: AppBar(
              title: Text('행사일정'),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  ref.read(HomeProvider).popCurrentWidget();
                },
              ),
            ),
            successBody: (data) {
              data as List<EventModel>;

              return CustomScrollView(slivers: [
                SliverToBoxAdapter(
                  child: Row(
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
                        child: const Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 18,
                        ),
                        onTap: () {
                          setState(() => selectedDate = DateTime(
                                selectedDate.year,
                                selectedDate.month - 1,
                                selectedDate.day,
                              ));
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: _selectMonth, // 월 선택 팝업 호출
                        child: Text(
                          '${selectedDate.month}월',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () => setState(() => selectedDate = DateTime(
                              selectedDate.year,
                              selectedDate.month + 1,
                              selectedDate.day,
                            )),
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                        ), // 다음 달로 이동
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 10,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
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
                      eventLoader: _eventLoader,
                      calendarStyle: const CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: Color.fromARGB(86, 5, 73, 151),
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
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 10,
                  ),
                ),
                ...selectedEvents.isEmpty
                    ? [
                        SliverFillRemaining(
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 35,
                                ),
                                Text(
                                  '해당 날짜에는 이벤트가 없습니다',
                                  style: TextStyle(
                                      fontSize:
                                          DynamicFontSize.font18(context)),
                                )
                              ],
                            ),
                          ),
                        )
                      ]
                    : [
                        SliverToBoxAdapter(
                            child: Container(
                                margin: EdgeInsets.only(top: 15, bottom: 15),
                                child: IndexTitle('일정'))),
                        SliverList.separated(
                          itemCount: selectedEvents.length,
                          itemBuilder: (value, index) {
                            return EventTile(
                              event: selectedEvents[index],
                              onTap: () {
                                homeProvider.pushCurrentWidget = EventDetailScreen(event: selectedEvents[index],);
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 15,
                            );
                          },
                        )
                      ]
              ]);
            }));
  }
}
