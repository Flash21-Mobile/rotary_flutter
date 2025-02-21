import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../util/fontSize.dart';
import '../../../util/global_color.dart';

class MyInfoModifyDialog extends ConsumerStatefulWidget {
  final BuildContext context;
  final DateTime? selectedDate;
  final String title;

  const MyInfoModifyDialog(this.context, this.title,
      {super.key, this.selectedDate});

  Future<DateTime?> show() async {
    final dateTime = await showDialog<DateTime>(
            context: context,
            builder: (context) {
              return MyInfoModifyDialog(
                context,
                title,
                selectedDate: selectedDate,
              );
            }) ??
        selectedDate;

    return dateTime;
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Widget();
}

class _Widget extends ConsumerState<MyInfoModifyDialog> {
  late DateTime _selectedDate;

  DateTime get selectedDate => _selectedDate;

  set setSelectedData(DateTime dateTime) {
    setState(() {
      _selectedDate = dateTime;
    });
  }

  @override
  void initState() {
    super.initState();

    _selectedDate = widget.selectedDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalColor.transparent,
        body: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                alignment: Alignment.center,
                color: GlobalColor.transparent,
                margin: EdgeInsets.all(15),
                child: datePiker())));
  }

  Widget datePiker() {
    return InkWell(
        onTap: () {},
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            decoration: BoxDecoration(
                color: GlobalColor.white,
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IndexMaxTitle(widget.title),
                _buildHeader(context),
                TableCalendar(
                  locale: 'ko_KR',
                  focusedDay: selectedDate,
                  firstDay: DateTime(1900),
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
                      color: GlobalColor.primaryColor,
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
                ),
                SizedBox(height: 30),
                InkWell(
                    onTap: () {
                      Navigator.pop(context, selectedDate);
                    },
                    child: Container(
                        width: double.infinity,
                        child: IndexText(
                          '확인',
                          textColor: GlobalColor.white,
                        ),
                        padding: EdgeInsets.all(15),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: GlobalColor.primaryColor,
                            borderRadius: BorderRadius.circular(100))))
              ],
            )));
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
                  child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: Text(
                        '${selectedDate.year}년',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: DynamicFontSize.font22(context)),
                      )))
            ],
          ),
          InkWell(
              onTap: () => _selectMonth(context, selectedDate.month),
              child: Container(
                  alignment: Alignment.center,
                  width: 60,
                  height: 40,
                  child: Text(
                    textAlign: TextAlign.center,
                    '${selectedDate.month}월',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: DynamicFontSize.font22(context)),
                  ))),
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

  Future<void> _selectYear(BuildContext context, int currentYear) async {
    final ScrollController scrollController = ScrollController();

    final selectedYear = await showDialog<int>(
      context: context,
      builder: (context) {
        // 대화상자 내에서 선택된 연도로 자동 스크롤을 이동
        Future.delayed(Duration.zero, () {
          final selectedIndex = currentYear - 1900;
          scrollController.jumpTo(selectedIndex * 50 - 50); // 아이템 높이에 맞춰 스크롤 이동
        });

        return AlertDialog(
          title: const Text('연도를 선택하세요'),
          content: SizedBox(
            height: 300,
            width: 200,
            child: ListView.builder(
              controller: scrollController,
              itemCount: 151, // 1900년부터 2050년까지
              itemBuilder: (_, index) {
                final year = 1900 + index;
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

  Future<void> _selectMonth(BuildContext context, int currentMonth) async {
    final ScrollController scrollController = ScrollController();

    final selectedMonth = await showDialog<int>(
      context: context,
      builder: (context) {
        Future.delayed(Duration.zero, () {
          final selectedIndex = currentMonth;
          if (selectedIndex > 3 && selectedIndex < 8) {
            scrollController
                .jumpTo((selectedIndex - 2) * 50); // 아이템 높이에 맞춰 스크롤 이동
          } else if (selectedIndex >= 8) {
            scrollController.jumpTo(50 * 6);
          }
        });

        return AlertDialog(
          title: const Text('월을 선택하세요'),
          content: SizedBox(
            height: 300,
            width: 200,
            child: ListView.builder(
              controller: scrollController,
              itemCount: 12, // 1월부터 12월까지
              itemBuilder: (_, index) {
                final month = index + 1;
                bool isSelected = month == currentMonth;
                return InkWell(
                    onTap: () => Navigator.of(context).pop(month),
                    child: Container(
                        height: 50,
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 15),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: isSelected
                                ? GlobalColor.lightPrimaryColor
                                : null,
                            borderRadius: BorderRadius.circular(15)),
                        child: Text('$month월')));
              },
            ),
          ),
        );
      },
    );

    if (selectedMonth != null) {
      setState(() {
        setSelectedData =
            DateTime(selectedDate.year, selectedMonth, selectedDate.day);
      });
    }
  }
}
