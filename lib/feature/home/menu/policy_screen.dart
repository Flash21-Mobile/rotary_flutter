import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';
import 'package:rotary_flutter/util/global_color.dart';

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
        title: const Text('운영방침'),
        centerTitle: true,
      ),
      body: ScrollablePinchView(
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Circular Image with Shadow
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.network(
                  'https://mmate.flash21.com/images/rotary/operation-img.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Title Text
            const Text(
              "2024-25년도 지구 운영방침 및 중점목표",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // Main Content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "스테파니 얼칙 국제로타리 차기회장은 2024-25년도 회장 표어로 \"기적을 이루는 로타리\"를 발표하고 회원들에게 생명을 구하는 로타리의 힘을 인식하고 확대할 것을 촉구했다.",
                  style: TextStyle(fontSize: 16),
                ),
                _buildLine(),
                const Text(
                  "또한 \"우리가 요술 지팡이를 흔들고 주문을 외운다고 해서 소아마비를 종식시키거나 세상에 평화를 가져올 수는 없다\"고 전제하고 \"모든 것이 여러분에게 달려 있다. 완료된 모든 프로젝트, 기부된 모든 액수, 모든 신입회원들로 여러분은 기적을 만들 것\"이라 강조했다.",
                  style: TextStyle(fontSize: 16),
                ),
                _buildLine(),
                const Text(
                  "그녀는 현재 미국 내 클럽 및 지구들이 알바니아, 코소보, 우크라이나의 로타리클럽과 파트너십을 맺고 인도주의 및 교육 프로젝트를 추진하도록 지원하고 있다.",
                  style: TextStyle(fontSize: 16),
                ),

                _buildLine(),

                // Section Title
                const Text(
                  "● 지구 중점 목표",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                // Goals List
                const Text("1. 회원 3700명 (회원 순증가 500명 이상)",
                    style: TextStyle(fontSize: 16)),
                const Text("2. 신생클럽 4개 이상 창립",
                    style: TextStyle(fontSize: 16)),
                const Text("(RCC/Rotaract 포함)", style: TextStyle(fontSize: 16)),
                const Text("3. 로타리 재단 120만불 달성 (지역당 10만불)",
                    style: TextStyle(fontSize: 16)),
                const Text("4. 글로벌 봉사사업 확대",
                    style: TextStyle(fontSize: 16)),
                const Text("5. 공공이미지 강화", style: TextStyle(fontSize: 16)),
                const Text("6. 환경보존활동", style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 50),
          ],
        ),
      )),
    );
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
