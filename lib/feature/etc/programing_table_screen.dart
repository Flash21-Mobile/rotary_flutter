import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';
import 'package:rotary_flutter/util/global_color.dart';

import '../home_view_model.dart';

class ProgramingTableScreen extends ConsumerStatefulWidget {
  const ProgramingTableScreen({super.key});

  @override
  ConsumerState<ProgramingTableScreen> createState() =>
      _ProgramingTableScreen();
}

class _ProgramingTableScreen extends ConsumerState<ProgramingTableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColor.white,
      appBar: AppBar(
        title: const Text('편성표'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            ref.read(HomeProvider).popCurrentWidget();
          },
        ),
      ),
      body: const SingleChildScrollView(
        child: DataTableExample(),
      ),
    );
  }
}

class DataTableExample extends StatelessWidget {
  const DataTableExample({super.key});

  @override
  Widget build(BuildContext context) {
    // 데이터 정의
    final List<List<String>> data = [
      [
        '1',
        '초계 정규익\n(대구달구벌RC)',
        '대구, 대구동신, 대구동성, 대구수선화, 대구 청산, 대구민들레, 대구수목, 대구문화',
      ],
      [
        '2',
        '해청 김병수\n(청도RC)',
        '청도, 대구영남, 대구청운, 대구태양, 청도원화, 대구유성, 대구대성, 대구송원',
      ],
      [
        '3',
        '가람 강은주\n(대구라이프RC)',
        '서대구, 대구청구, 대구달구벌, 대구강동, 대구태극, 대구한길, 대구나눔, 대구종각',
      ],
      [
        '4',
        '현종 최형진\n(대구태극RC)',
        '새대구, 대구대덕, 대구와룡, 대구태백, 대구미지, 대구금천, 대구하람',
      ],
      [
        '5',
        '삼문 성웅\n(대구뉴팔공RC)',
        '북대구, 대구달서, 대구동북, 대구동남, 대구반월, 대구뉴팔공, 대구코스코스, 대구동명',
      ],
      [
        '6',
        '심천 김영상\n(대구금송RC)',
        '대구수성, 대구낙동, 대구천마, 대구이글, 대구수정, 대구청룡, 대구금송',
      ],
      [
        '7',
        '우강 정준수\n(대구금호RC)',
        '동대구, 대구금호, 대구청솔, 대구금강, 대구백설, 대구하나, 대구금산, 대구사군자',
      ],
      [
        '8',
        '호일 박종현\n(대구동광RC)',
        '대구88, 중대구, 대구한마음, 대구동삼, 대구라이프, 대구청맥, 대구동광, 대구라온',
      ],
      [
        '9',
        '백범 김창수\n(대구무림RC)',
        '대구달성, 대구ROTC, 대구성서, 대구은하수, 대구광장, 대구무림, 대구주목',
      ],
      [
        '10',
        '수경 이명미\n(경산한솔RC)',
        '경산, 경산중앙, 대구시지, 경산퀸즈, 경산한솔, 대구상록, 대구신성, 경산무지개',
      ],
      [
        '11',
        '대각 김태훈\n(대구이글RC)',
        '왜관, 대구동호, 고령, 성주, 고령철쭉, 성주참외, 왜관가온',
      ],
      [
        '12',
        '현농 김상명\n(대구금산RC)',
        '대구송림, 대구통일, 대구강북, 대구수련, 대구무궁화, 대구바둑, 대구희망, 대구웰가',
      ],
    ];

    final screenWidth = MediaQuery.of(context).size.width; // 화면 너비 가져오기

    return ScrollablePinchView(
      child: DataTable(
        columnSpacing: screenWidth * 0.02, // 화면 크기에 비례한 열 간 간격
        columns: const <DataColumn>[
          DataColumn(
            label: Center(
              child: Text(
                '지역',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ),
          DataColumn(
            label: Center(
              child: Text(
                '총재지역대표',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ),
          DataColumn(
            label: Center(
              child: Text(
                '클럽명',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ),
        ],
        rows: data.map((row) {
          return DataRow(
            cells: [
              DataCell(
                Container(
                  width: screenWidth * 0.05, // 지역 열의 크기
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    row[0],
                    softWrap: true,
                    maxLines: null,
                  ),
                ),
              ),
              DataCell(
                Container(
                  width: screenWidth * 0.3, // 총재지역대표 열의 크기
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    row[1],
                    softWrap: true,
                    maxLines: null,
                  ),
                ),
              ),
              DataCell(
                Flexible(
                  child: Text(
                    row[2],
                    softWrap: true, // 줄바꿈 활성화
                    maxLines: null, // 줄 수 제한 없음
                    overflow: TextOverflow.visible, // 텍스트 잘림 방지
                  ),
                ),
              ),
              // DataCell(
              //   Flexible(
              //     child: Text(
              //       row[2],
              //       softWrap: true, // 줄바꿈 활성화
              //       maxLines: null, // 줄 수 제한 없음
              //       overflow: TextOverflow.visible, // 텍스트 잘림 방지
              //     ),
              //   ),
              // ),
            ],
          );
        }).toList(),
      ),
    );
  }
}