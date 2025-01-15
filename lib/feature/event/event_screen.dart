import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/feature/event/modify/event_modify_screen.dart';
import 'package:rotary_flutter/feature/home_component.dart';
import 'package:rotary_flutter/util/secure_storage.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../data/model/event_model.dart';
import '../../util/fontSize.dart';
import '../../util/global_color.dart';
import '../../util/logger.dart';
import '../../util/model/loadstate.dart';
import '../home_view_model.dart';
import 'detail/event_detail_screen.dart';
import 'event_component.dart';
import 'event_view_model.dart';

class EventScreen extends ConsumerStatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends ConsumerState<EventScreen> {
  DateTime _selectedDate = DateTime.now();
  List<EventModel> _selectedEvents = [];

  var isAdmin = false;

  void checkAdmin() async {
    var data = (await globalStorage.read(key: 'admin')) == 'admin';

    setState(() => isAdmin = data);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(EventProvider).getEvent().then((onValue) {
        _loadEventsForDate(_selectedDate);
        checkAdmin();
      });
    });
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

    // 연도 선택 후 처리
    if (selectedYear != null) {
      setState(() {
        _selectedDate =
            DateTime(selectedYear, _selectedDate.month, _selectedDate.day);
      });
      _loadEventsForDate(_selectedDate);
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

    if (selectedMonth != null) {
      setState(() {
        _selectedDate =
            DateTime(_selectedDate.year, selectedMonth, _selectedDate.day);
      });
      _loadEventsForDate(_selectedDate);
    }
  }

  void _loadEventsForDate(DateTime date) {
    final eventState = ref.read(EventProvider).eventState;

    if (eventState is Success) {
      final data = eventState.data as List<EventModel>;
      _selectedEvents = data.where((event) {
        final eventDate = DateTime.tryParse(event.time ?? '');
        return eventDate != null && isSameDay(eventDate, date);
      }).toList();
      setState(() {});
    }
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

  @override
  Widget build(BuildContext context) {
    final eventProvider = ref.watch(EventProvider);
    Log.d('${eventProvider.eventState}');

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: LoadStateScaffold(
          backgroundColor: GlobalColor.white,
          loadState: eventProvider.eventState,
          appBar: AppBar(
            title: const Text('행사 일정'),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                ref.read(HomeProvider).popCurrentWidget();
              },
            ),
          ),
          successBody: (data) {
            return CustomScrollView(
              slivers: [
                _buildHeader(context),
                _buildCalendar(),
                _buildEventList(),
              ],
            );
          },
          floatingActionButton: isAdmin
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => EventModifyScreen())).then((value){
                      getData();
                    });
                  },
                  backgroundColor: GlobalColor.primaryColor,
                  child: const Icon(
                    Icons.add_rounded,
                  ))
              : null,
        ));
  }

  Widget _buildCalendar() {
    return SliverToBoxAdapter(
        child: Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(top: 15, left: 5, right: 5),
      decoration: BoxDecoration(
          color: GlobalColor.indexBoxColor,
          borderRadius: BorderRadius.circular(15)),
      child: TableCalendar(
        locale: 'ko_KR',
        onPageChanged: (focusedDay) {
          setState(() {
            _selectedDate = focusedDay;
          });
          _loadEventsForDate(focusedDay);
        },
        // daysOfWeek: ['일', '월', '화', '수', '목', '금', '토'],
        eventLoader: _eventLoader,
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: GlobalColor.lightPrimaryColor,
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
        onDaySelected: (selectedDay, _) {
          setState(() {
            _selectedDate = selectedDay;
          });
          _loadEventsForDate(selectedDay);
        },
        selectedDayPredicate: (date) => isSameDay(_selectedDate, date),
        focusedDay: _selectedDate,
        firstDay: DateTime(2000),
        lastDay: DateTime(2050, 12, 31),
        headerVisible: false,
      ),
    ));
  }

  Widget _buildHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.all(5),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => _selectYear(context, _selectedDate.year),
                  child: Text(
                    '${_selectedDate.year}년',
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
                    '${_selectedDate.month}월',
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
                      _selectedDate = DateTime(_selectedDate.year,
                          _selectedDate.month - 1, _selectedDate.day);
                    });
                    _loadEventsForDate(_selectedDate);
                  },
                ),
                SizedBox(
                  width: 80,
                ),
                InkWell(
                  child: Icon(Icons.arrow_right, size: 40),
                  onTap: () {
                    setState(() {
                      _selectedDate = DateTime(_selectedDate.year,
                          _selectedDate.month + 1, _selectedDate.day);
                    });
                    _loadEventsForDate(_selectedDate);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEventList() {
    if (_selectedEvents.isEmpty) {
      return const SliverFillRemaining(
        child: Center(child: Text('해당 날짜에는 이벤트가 없습니다')),
      );
    }

    return SliverList.separated(
      itemCount: _selectedEvents.length,
      itemBuilder: (context, index) {
        final event = _selectedEvents[index];
        return EventTile(
          event: event,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EventDetailScreen(event: event))).then((value){
                      getData();
            });
          },
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 10),
    );
  }
}
