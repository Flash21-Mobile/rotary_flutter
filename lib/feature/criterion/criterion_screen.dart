import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';
import 'package:rotary_flutter/util/fontSize.dart';
import 'package:rotary_flutter/util/global_color.dart';
import 'package:rotary_flutter/util/table/sliver_table_table.dart';
import 'package:rotary_flutter/util/table/table_data.dart';
import '../home_view_model.dart';

class CriterionScreen extends ConsumerStatefulWidget {
  const CriterionScreen({super.key});

  @override
  ConsumerState<CriterionScreen> createState() => _CriterionScreen();
}

class _CriterionScreen extends ConsumerState<CriterionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColor.white,
      appBar: AppBar(
        title: const IndexMaxTitle('표창기준'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            ref.read(HomeProvider).popCurrentWidget();
          },
        ),
      ),
      body: CustomScrollPinchView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        slivers: [
          // 제목 Section
          const SliverToBoxAdapter(
              child: IndexThumbTitle(
            '2024-25년도 지구총재 표창기준',
            textAlign: TextAlign.center,
          )),

          sliverTextTitle(
            '종합표창 기본조건',
          ),

          const SliverToBoxAdapter(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 20, child: IndexMinText('1.')),
              Flexible(child: IndexMinText('지구 각종회비 및 각종 의무 분담금의 기한 내 납부'))
            ],
          )),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          const SliverToBoxAdapter(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 20, child: IndexMinText('2.')),
              Flexible(
                  child: IndexMinText(
                      '각종 보고서(보조금 신청, 결과보고서, 각종 등록 및\n광고 등) 기한 내 제출',
                      height: 1.2))
            ],
          )),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          const SliverToBoxAdapter(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 20, child: IndexMinText('3.')),
              Flexible(
                  child: IndexMinText('클럽에서 연수리더 초빙 교육(2회 의무)', height: 1.2))
            ],
          )),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),

          const SliverToBoxAdapter(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 20, child: IndexMinText('4.')),
              Flexible(
                  child: IndexMinText(
                      '회원수 30명 미만 클럽의 활성화와 등기부여를\n위한 기본 조건 충족시 가산점 2배 부여',
                      height: 1.2))
            ],
          )),

          const SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.only(left: 24), // 들여쓰기 처리
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 20, child: IndexMinText('-')),
                        Flexible(
                            child: IndexMinText(
                                '기본조건 : 회원순증 6명, 로타리재단 기부\n\$12,000, 전회원 80% 이상 내로타리 가입',
                                height: 1.2))
                      ]))),

          const SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.only(left: 24), // 들여쓰기 처리
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 20, child: IndexMinText('-')),
                        Flexible(
                            child: IndexMinText(
                          '단, 1.2배 가산 적용은 회원증강 및 로타리재단\n기부에 한함',
                                height: 1.2
                        ))
                      ]))),

          const SliverToBoxAdapter(child: SizedBox(height: 8)),

          const SliverToBoxAdapter(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 20, child: IndexMinText('5.')),
              Flexible(
                  child: IndexMinText('클럽 주관의 신회원(입회 3년 미만) 연수 교육\n1회 이상 필수',
                      height: 1.2))
            ],
          )),
          sliverTextTitle(
            '표창 적용 시기',
          ),

          const SliverToBoxAdapter(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 20, child: IndexMinText('1.')),
              Flexible(
                  child: IndexMinText(
                      '2024년 7월 1일부터 2025년 3월 31일 기준이며,\n회원증강 부문은 2024년 7월 1일부터\n2025년 3월 31일까지 적용한다.',
                      height: 1.2))
            ],
          )),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          const SliverToBoxAdapter(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 20, child: IndexMinText('2.')),
              Flexible(
                  child: IndexMinText(
                      '종합표창 근거서류 위반조가 확인 될 시 해당 클럽은 모든 지구표창에서 제외한다.',
                      height: 1.2))
            ],
          )),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          const SliverToBoxAdapter(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 20, child: IndexMinText('3.')),
              Flexible(
                  child: IndexMinText(
                      '표창의 모든 서류는 2025년 3월 31일 오후 5시까지 지구사무국에 도착분에 한한다.(온/오프라인)',
                      height: 1.2))
            ],
          )),
          sliverTextTitle(
            '종합표창',
          ),
          SliverTable(data: TableData.all),
          const SliverToBoxAdapter(
            child: SizedBox(height: 10.0),
          ),
          const SliverToBoxAdapter(
            child: IndexMicroText(
              '* 기본조건 (총재클럽특별상 제외)\n  - 회원순증가 6명 이상\n  - 재단 \$12,000 이상\n  - 전회원 내 로타리 가입 80% 이상\n  - 신회원(3년 미만) 연수교육 1회 이상',
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          const SliverToBoxAdapter(
            child: IndexMicroText(
              '* 종합표창의 회원순증가 인원은 신생클럽 창립 인원 포함',
            ),
          ),

          sliverTextTitle('클럽표창'),
          SliverTable(data: TableData.club),

          sliverTextTitle('개인표창'),
          SliverTable(data: TableData.personal),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
            ),
          )
        ],
      ),
    );
  }

  Widget sliverTextTitle(String text) => SliverToBoxAdapter(
      child: Container(
          margin: EdgeInsets.only(top: 30, bottom: 10),
          child: IndexMaxTitle(text)));
}
