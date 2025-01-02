import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/feature/home_component.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(EventProvider).getEvent().then((onValue) {
        _loadEventsForDate(_selectedDate);
      });
    });
  }

  Future<void> _selectYear(BuildContext context) async {
    final selectedYear = await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('연도를 선택하세요'),
        content: SizedBox(
          height: 300,
          width: 200,
          child: ListView.builder(
            itemCount: 51, // 2000년부터 2050년까지
            itemBuilder: (_, index) {
              final year = 2000 + index;
              return ListTile(
                title: Text('$year년'),
                onTap: () => Navigator.of(context).pop(year),
              );
            },
          ),
        ),
      ),
    );

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
            }));
  }

  Widget _buildCalendar() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.only(top: 15, left: 5, right: 5),
        decoration: BoxDecoration(
        color: GlobalColor.indexBoxColor,
          borderRadius: BorderRadius.circular(15)
    ),
      child: TableCalendar(
        eventLoader: _eventLoader,
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: GlobalColor.primaryColor,
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
        lastDay: DateTime(2050),
        headerVisible: false,
      ),)
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => _selectYear(context),
              child: Text(
                '${_selectedDate.year}년',
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: DynamicFontSize.font22(context)),
              ),
            ),
            const Spacer(),
            InkWell(
              child: Icon(Icons.arrow_back_ios, size: 20),
              onTap: () {
                setState(() {
                  _selectedDate = DateTime(_selectedDate.year,
                      _selectedDate.month - 1, _selectedDate.day);
                });
                _loadEventsForDate(_selectedDate);
              },
            ),
            InkWell(
              onTap: () => _selectMonth(context),
              child: Text(
                '${_selectedDate.month}월',
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: DynamicFontSize.font22(context)),
              ),
            ),
            SizedBox(width: 5,),
            InkWell(
              child: Icon(Icons.arrow_forward_ios, size: 20,),
              onTap: () {
                setState(() {
                  _selectedDate = DateTime(_selectedDate.year,
                      _selectedDate.month + 1, _selectedDate.day);
                });
                _loadEventsForDate(_selectedDate);
              },
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
            ref.read(HomeProvider).pushCurrentWidget =
                EventDetailScreen(event: event);
          },
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 10),
    );
  }
}
