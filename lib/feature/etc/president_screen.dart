import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';
import 'package:rotary_flutter/util/global_color.dart';
import '../home_view_model.dart';

class PresidentScreen extends ConsumerStatefulWidget {
  const PresidentScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PresidentScreen();
}

class _PresidentScreen extends ConsumerState<PresidentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalColor.white,
        appBar: AppBar(
          title: const IndexMaxTitle('RI 회장'),
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
                            color: Colors.grey.withAlpha(50),
                            blurRadius: 15,
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      child: ClipOval(
                          child: Container(
                        decoration: BoxDecoration(
                            color: GlobalColor.white,
                            borderRadius: BorderRadius.circular(100)),
                        child: Image.network(
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                          'https://mmate.flash21.com/images/rotary/ri-president.jpg',
                        ),
                      )),
                    ),
                    const SizedBox(height: 30),
                    const IndexTitle('스테파니 얼칙(Stephanie Urchick)'),
                    const SizedBox(height: 30),
                    const Column(children: [
                      IndexText(
                        height: 1.2,
                          "스테파니 얼칙(Stephanie Urchick) 차기회장은 미국 펜실베이니아주, 맥머리 로타리클럽의 회원으로서 2024-25년도에 로타리 회장으로 취임한다.그녀는 RI 이사 및 재단 이사를 역임했으며,연수리더, RRFC, RI 회장대리를 포함해 다양한 역량을 발휘하며 RI에 봉사해왔다.이밖에도 3회에 걸쳐 규정심의회에서 대의 원과 무임소 의원으로 활동했다."),
                      SizedBox(height: 30,),
                      IndexText(
                          height: 1.2,
                          "또한 스테파니 차기회장은 전략 계획 위원장 및 로타리재단 100주년 기념위원회 위원장을 역임했으며, 선 거 심의 위원회와 운영 심의 위원회를 포함한 다양한 RI 위원회 위원으로도 활동했다."),
                      SizedBox(height: 30,),
                      IndexText(
                          height: 1.2,
                          "1991년에 로타리에 입회한 그녀는 인도와 나이지리아의 전국 면역의 날을 포함한 다양한 국제봉사 프로젝 트에 참여했고, 베트남에서는 초등학교 건립을 돕기 위해 클럽과 함께 일했으며, 도미니카 공화국에서는 정 수 필터 프로젝트에 참여했다.여러 슬라브어권의 언어를 배운 그녀는 우크라이나에서 로타리클럽 신입회원 들을 멘토링하고, 폴란드 병원에 유방조영술 장비와 생체검사실을 마련하기 위한 로타리재단 보조금을 조 율했다. 폴란드의 크라쿠프 로타리클럽은 기념 책자에서 스테파니 차기회장을 탈공산주의 폴란드에서 로타 리의 재탄생을 지원한 핵심 인물로 언급했다."),
                      SizedBox(height: 30,),
                      IndexText(
                          height: 1.2,
                          "그녀는 현재 미국 내 클럽 및 지구들이 알바니아, 코소보, 우크라이나의 로타리클럽과 파트너십을 맺고 인 도주의 및 교육 프로젝트를 추진하도록 지원하고 있다."),
                      SizedBox(height: 30,),
                      IndexText(
                          height: 1.2,
                          "고등교육, 컨설팅 및 엔터테인먼트 산업에 종사하는 스테파니 차기회장은펜실베니아 인디애나 대학교에서 리더십 연구로 박사 학위를 받았으며, 로타리재단과 수많은 지역사회 및 국제 단체로부터 표창과 상을 수상 했다."),
                      SizedBox(
                        height: 100,
                      ),
                    ]),
                  ],
                ))));
  }
}