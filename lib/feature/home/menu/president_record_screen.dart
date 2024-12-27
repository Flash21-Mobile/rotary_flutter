import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';
import 'package:rotary_flutter/util/fontSize.dart';
import 'package:rotary_flutter/util/global_color.dart';

class PresidentRecordScreen extends ConsumerStatefulWidget {
  const PresidentRecordScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PresidentRecordScreen();
}

class _PresidentRecordScreen extends ConsumerState<PresidentRecordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColor.white,
      appBar: AppBar(
        title: const Text('총재 약력'),
        centerTitle: true,
      ),
      body: ScrollablePinchView(
        child: Column(
          children: [
            const SizedBox(height: 20),
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
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 20,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.network(
                            'https://mmate.flash21.com/images/rotary/capacity-img.jpg',
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
                    '이충환',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("학력"),
                  const IndexText(
                      "UCLA 치과대학 악안명 임플란트(PRECEPTOR) 수료"),
                  const IndexText("조선대학교 치의학과 보철학 박사 졸업"),
                  const SizedBox(height: 20),

                  _buildSectionTitle("일반 경력"),
                  const IndexText(
                      "2001년~현재 UCLS임플란트 연구회 회장"),
                  const IndexText(
                      "2015년~2023년 대구광역시 검도 협회 회장 역임"),
                  const IndexText(
                      "2019년~2023년 한국심는치아 연구회 회장 역임"),
                  const IndexText("2020년~현재 늘사랑 청소년 운영 위원"),
                  const SizedBox(height: 20),

                  _buildSectionTitle("로타리 경력"),
                  const IndexText(
                      "2001.08.22 대구달구벌 로타리클럽 입회"),
                  const IndexText(
                      "2011-12년도 대구달구벌 로타리클럽 회장"),
                  const IndexText(
                      "2012-13년도 국제로타리 3700지구 의료봉사위원장"),
                  const IndexText(
                      "2013-14년도 국제로타리 3700지구 총재보좌역"),
                  const IndexText(
                      "2014-15년도 국제로타리 3700지구 의료봉사위원장"),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: 80, // 선의 길이
            height: 2, // 선의 두께
            color: Colors.grey, // 선의 색상
          ),
          SizedBox(height: 3),
        ],
      ),
    );
  }
}
