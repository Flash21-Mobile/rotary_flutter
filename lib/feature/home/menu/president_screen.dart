
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';
import 'package:rotary_flutter/util/fontSize.dart';
import 'package:rotary_flutter/util/global_color.dart';

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
          title: Text('RI 회장'),
          centerTitle: true,
        ),
        body: ScrollablePinchView(
            child: Column(
              children: [
                SizedBox(height: 20), // 이미지 위에 간격 추가
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.65,
                            height: MediaQuery.of(context).size.width * 0.7,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.9),
                                  blurRadius: 20,
                                  offset: const Offset(0, 30),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.network(
                                'https://mmate.flash21.com/images/rotary/ri-president.jpg',
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width * 0.65,
                                height: MediaQuery.of(context).size.width * 0.65,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        '스테파니 얼칙(Stephanie Urchick)',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20), // 이미지 아래 간격

                Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(children: [
                    IndexText(
                        "스테파니 얼칙(Stephanie Urchick) 차기회장은 미국 펜실베이니아주, 맥머리 로타리클럽의 회원으로서 2024-25년도에 로타리 회장으로 취임한다.그녀는 RI 이사 및 재단 이사를 역임했으며,연수리더, RRFC, RI 회장대리를 포함해 다양한 역량을 발휘하며 RI에 봉사해왔다.이밖에도 3회에 걸쳐 규정심의회에서 대의 원과 무임소 의원으로 활동했다."),
                    _buildLine(),
                    IndexText(
                      "또한 스테파니 차기회장은 전략 계획 위원장 및 로타리재단 100주년 기념위원회 위원장을 역임했으며, 선 거 심의 위원회와 운영 심의 위원회를 포함한 다양한 RI 위원회 위원으로도 활동했다.",
                    ),
                    _buildLine(),
                    IndexText(
                        "1991년에 로타리에 입회한 그녀는 인도와 나이지리아의 전국 면역의 날을 포함한 다양한 국제봉사 프로젝 트에 참여했고, 베트남에서는 초등학교 건립을 돕기 위해 클럽과 함께 일했으며, 도미니카 공화국에서는 정 수 필터 프로젝트에 참여했다.여러 슬라브어권의 언어를 배운 그녀는 우크라이나에서 로타리클럽 신입회원 들을 멘토링하고, 폴란드 병원에 유방조영술 장비와 생체검사실을 마련하기 위한 로타리재단 보조금을 조 율했다. 폴란드의 크라쿠프 로타리클럽은 기념 책자에서 스테파니 차기회장을 탈공산주의 폴란드에서 로타 리의 재탄생을 지원한 핵심 인물로 언급했다."),
                    _buildLine(),
                    IndexText(
                        "그녀는 현재 미국 내 클럽 및 지구들이 알바니아, 코소보, 우크라이나의 로타리클럽과 파트너십을 맺고 인 도주의 및 교육 프로젝트를 추진하도록 지원하고 있다."),
                    _buildLine(),
                    IndexText(
                        "고등교육, 컨설팅 및 엔터테인먼트 산업에 종사하는 스테파니 차기회장은펜실베니아 인디애나 대학교에서 리더십 연구로 박사 학위를 받았으며, 로타리재단과 수많은 지역사회 및 국제 단체로부터 표창과 상을 수상 했다."),
                    SizedBox(
                      height: 100,
                    ),
                  ]),
                )
              ],
            )));
  }
}


Widget _buildLine() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Divider(
          thickness: 1.5, // 선 두께
          color: Colors.grey, // 선 색상
        ),
        SizedBox(
          height: 20,
        ),
      ],
    ),
  );
}
