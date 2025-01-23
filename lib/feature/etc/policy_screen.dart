import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';
import 'package:rotary_flutter/util/global_color.dart';

import '../home_view_model.dart';

class PolicyScreen extends ConsumerStatefulWidget {
  const PolicyScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PolicyScreen();
}

class _PolicyScreen extends ConsumerState<PolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColor.white,
      appBar: AppBar(
        title: const IndexMaxTitle('운영방침'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            ref.read(HomeProvider).popCurrentWidget();
          },
        ),
      ),
      body: ScrollablePinchView(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: GlobalColor.dividerColor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(70),
                    blurRadius: 10,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: ClipOval(
                  child: Container(
                decoration: BoxDecoration(
                    color: GlobalColor.white,
                    borderRadius: BorderRadius.circular(100)),
                child: Image.network(
                  alignment: Alignment.center,
                  'https://mmate.flash21.com/images/rotary/operation-img.jpg',
                  // fit: BoxFit.cover,
                ),
              )),
            ),
            const SizedBox(height: 30),
            const IndexTitle("2024-25년도 지구 운영방침 및 중점목표"),
            const SizedBox(height: 30),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IndexText(
                  height: 1.2,
                  "스테파니 얼칙 국제로타리 차기회장은 2024-25년도 회장 표어로 \"기적을 이루는 로타리\"를 발표하고 회원들에게 생명을 구하는 로타리의 힘을 인식하고 확대할 것을 촉구했다.",
                ),
                SizedBox(
                  height: 30,
                ),
                IndexText(
                  height: 1.2,
                  "또한 \"우리가 요술 지팡이를 흔들고 주문을 외운다고 해서 소아마비를 종식시키거나 세상에 평화를 가져올 수는 없다\"고 전제하고 \"모든 것이 여러분에게 달려 있다. 완료된 모든 프로젝트, 기부된 모든 액수, 모든 신입회원들로 여러분은 기적을 만들 것\"이라 강조했다.",
                ),

                // Section Title
                SizedBox(height: 30),
                IndexTitle("● 지구 중점 목표"),
                SizedBox(height: 10),

                // Goals List
                Row(children: [
                  SizedBox(width: 20, child: IndexMinText('1.', height: 1.2)),
                  IndexText("회원 3700명 (회원 순증가 500명 이상)", height: 1.2,)
                ]),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(width: 20, child: IndexMinText('2.', height: 1.2)),
                  IndexText("신생클럽 4개 이상 창립\n(RCC/Rotaract 포함)", height: 1.2,),
                ]),
                Row(children: [
                  SizedBox(width: 20, child: IndexMinText('3.', height: 1.2)),
                  IndexText("로타리 재단 120만불 달성 (지역당 10만불)",height: 1.2,),
                ]),
                Row(children: [
                  SizedBox(width: 20, child: IndexMinText('4.', height: 1.2)),
                  IndexText("글로벌 봉사사업 확대", height: 1.2,),
                ]),
                Row(children: [
                  SizedBox(width: 20, child: IndexMinText('5.', height: 1.2)),
                  IndexText("공공이미지 강화", height: 1.2,),
                ]),
                Row(children: [
                  SizedBox(width: 20, child: IndexMinText('6.', height: 1.2)),
                  IndexText("환경보존활동",height: 1.2,),
                ]),
              ],
            ),
            const SizedBox(height: 100),
          ],
        ),
      )),
    );
  }
}
