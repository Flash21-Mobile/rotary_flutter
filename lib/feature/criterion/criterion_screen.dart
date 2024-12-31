import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';
import 'package:rotary_flutter/util/fontSize.dart';
import 'package:rotary_flutter/util/global_color.dart';
import '../home_view_model.dart';
import 'criterion_row.dart';

class CriterionScreen extends ConsumerStatefulWidget {
  const CriterionScreen({super.key});

  @override
  ConsumerState<CriterionScreen> createState() => _CriterionScreen();
}

class _CriterionScreen extends ConsumerState<CriterionScreen> {
  final rows = [
    CriterionRow.defaultClub('지구 확대', '신생 클럽을 창립한 클럽'),
    CriterionRow.defaultClub('회원증강 최우수클럽', '최다 회원순증가 클럽'),
    CriterionRow.defaultClub('회원증강 우수클럽', '회원 순증 10명 이상 클럽'),
    CriterionRow.defaultClub('100% 회원증강 클럽', '클럽 회원 100% 순증가 클럽'),
    CriterionRow.defaultClub('로터리재단 기여 최우수클럽', '로타리 재단에 최고액을 기부한 클럽'),
    CriterionRow.defaultClub('로터리재단 기여 우수클럽', '로터리재단 기부 20,000불 이상 클럽'),
    CriterionRow.withNote('전회원 PHF 기부 클럽', '전회원 PHF 달성 클럽', '❊ 지명 제외'),
    CriterionRow.defaultClub('전회원 RFSM 로타리재단 후원', '전 회원 100\$ 이상 기여한 클럽'),
    CriterionRow.defaultClub('장학문화재단 최우수클럽', '장학문화재단 최고액 기부 클럽'),
    CriterionRow.defaultClub('봉사상', '최다 봉사 사업 클럽'),
    CriterionRow.withNote('공공이미지 함양상', '매스미디어에 로타리홍보 5회 이상', '❊ 동일 봉사 건 제외'),
    CriterionRow('지구대회 등록상', '최우수등록클럽', '매스미디어에 로타리홍보 5회 이상'),
    CriterionRow('지구대회 등록상', '우수등록클럽', '회원 100% 등록'),
    CriterionRow.defaultClub('베스트 영상물 제작상', 'SNS 영상물 제작, 공유클럽 선정'),
    CriterionRow.defaultClub('봉사파트너 공헌상', '리틀,인터,로타랙트,RCC 창립클럽'),
    CriterionRow.defaultClub('지구행사 주관 공로상', '지구행사를 최다 주관한 클럽'),
    CriterionRow.defaultClub('우수 부인회 상', '우수한 부인회 운영클럽'),
  ];

  final List<TableRow> headers = [
    TableRow(decoration: BoxDecoration(color: Colors.grey[100]), children: [
      TableCell(
          child: Container(
            height: 50,
            alignment: Alignment.center,
            child: Text(
              '시상 종류',
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
          )),
      TableCell(
          child: Container(
            height: 50,
            alignment: Alignment.center,
            child: Text(
              '대상',
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
          )),
      TableCell(
          child: Container(
            height: 50,
            alignment: Alignment.center,
            child: Text(
              '내용',
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
          )),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColor.white,
      appBar: AppBar(
        title: const Text('표창기준'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            ref.read(HomeProvider).popCurrentWidget();
          },
        ),
      ),
      body:ScrollablePinchView(
        child:
        // padding: const EdgeInsets.all(16.0),
        Padding(padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
        children: [
          // 제목 Section
          const Text(
            '2024-25년도 지구총재 표창기준',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // 종합표창 기본조건 Section
          const Text(
            '종합표창 기본조건',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // 조건 목록
          const Text(
            '1. 지구 각종회비 및 각종 의무 분담금의 기한 내 납부\n'
                '2. 각종 보고서(보조금 신청, 결과보고서, 각종 등록 및 광고 등) 기한 내 제출\n'
                '3. 클럽에서 연수리더 초빙 교육(2회 의무)\n'
                '4. 회원수 30명 미만 클럽의 활성화와 등기부여를 위한 기본 조건 충족시 가산점 2배 부여',
            style: TextStyle(fontSize: 18, height: 1.5),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16.0), // 들여쓰기 처리
            child: Text(
              '- 기본조건 : 회원순증 6명, 로타리재단 기부 \$12,000, 전회원 80% 이상 내로타리 가입\n'
                  '- 단, 1.2배 가산 적용은 회원증강 및 로타리재단 기부에 한함',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
          const SizedBox(height: 8),

          const Text(
            '5. 클럽 주관의 신회원(입회 3년 미만) 연수 교육 1회 이상 필수',
            style: TextStyle(fontSize: 18, height: 1.5),
          ),
          const SizedBox(height: 16),

          // 표창 적용 시기 Section
          const Text(
            '표창 적용 시기',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            '1. 2024년 7월 1일부터 2025년 3월 31일 기준이며, \n회원증강 부문은 2024년 7월 1일부터 2025년 3월 31일까지 적용한다.\n'
                '2. 종합표창 근거서류 위반조가 확인 될 시 해당 클럽은 모든 지구표창에서 제외한다.\n'
                '3. 표창의 모든 서류는 2025년 3월 31일 오후 5시까지 지구사무국에 도착분에 한한다.(온/오프라인)\n',
            style: TextStyle(fontSize: 18, height: 1.5),
          ),

          // 종합표창 section
          const Text(
            '종합표창',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 16.0,
              headingRowColor: MaterialStateColor.resolveWith(
                    (states) => Colors.grey[200]!,
              ),
              columns: const <DataColumn>[
                DataColumn(label: Expanded(child: Center(child: Text('시상종류', style: TextStyle(fontWeight: FontWeight.bold),),),),),
                DataColumn(label: Expanded(child: Center(child: Text('대상', style: TextStyle(fontWeight: FontWeight.bold),),),),),
                DataColumn(label: Expanded(child: Center(child: Text('내용', style: TextStyle(fontWeight: FontWeight.bold),),),),),
              ],
              rows: const <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Center(child: Text('최우수클럽', textAlign: TextAlign.center,),),),
                    DataCell(Center(child: Text('1개 클럽', textAlign: TextAlign.center,),),),
                    DataCell(Center(child: Text('클럽 종합평가점수\n최고점 클럽', textAlign: TextAlign.center,),),),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Center(child: Text('우수클럽', textAlign: TextAlign.center,),),),
                    DataCell(Center(child: Text('12개 클럽', textAlign: TextAlign.center,),),),
                    DataCell(Center(child: Text('최우수 클럽을 제외한\n차순위 클럽', textAlign: TextAlign.center,),),),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Center(child: Text('여성 우수클럽', textAlign: TextAlign.center,),),),
                    DataCell(Center(child: Text('1개 클럽', textAlign: TextAlign.center,),),),
                    DataCell(Center(child: Text('여성클럽종합평가점수\n최고클럽', textAlign: TextAlign.center,),),),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Center(child: Text('신클럽 우수클럽\n(창립 3년 미만)', textAlign: TextAlign.center,),),),
                    DataCell(Center(child: Text('1개 클럽)', textAlign: TextAlign.center,),),),
                    DataCell(Center(child: Text('신생클럽 종합평가점수\n최고클럽)', textAlign: TextAlign.center,),),),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Center(child: Text('총재클럽특별상', textAlign: TextAlign.center,),),),
                    DataCell(Center(child: Text('', textAlign: TextAlign.center,),),),
                    DataCell(Center(child: Text('지구발전에 현저한 공로가\n있는 클럽', textAlign: TextAlign.center,),),),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),

          const Text(
            '* 기본조건 (총재클럽특별상 제외)\n'
                '회원순증가 6명 이상/재단 \$12,000 이상/전회원 내 로타리 가입 80% 이상/신회원(3년 미만) 연수교육 1회 이상',
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
          const SizedBox(height: 10.0),

          const Text(
            '* 종합표창의 회원순증가 인원은 신생클럽 창립 인원 포함',
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
          const SizedBox(height: 10.0),

          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '클럽 표창',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Table(
              border: TableBorder.all(color: Color(0xffeeeeee)),
              children: headers + rows.map((row) => row.toDataRow()).toList(),
            )
          ])
        ],
      ),))
    );
  }
}

