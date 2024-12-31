import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';
import 'package:rotary_flutter/util/global_color.dart';

import '../home_view_model.dart';

class AllocationTableScreen extends ConsumerStatefulWidget {
  const AllocationTableScreen({super.key});

  @override
  ConsumerState<AllocationTableScreen> createState() =>
      _AllocationTableScreen();
}

class _AllocationTableScreen extends ConsumerState<AllocationTableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColor.white,
      appBar: AppBar(
        title: const Text('배점표'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            ref.read(HomeProvider).popCurrentWidget();
          },
        ),
      ),
      body:  ScrollablePinchView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AllocationSection(
                title: '신생클럽 창립',
                content: [
                  Text(
                    '● 창립 날짜별 차등부여',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '- 7~9월 창립: 3,000점 X 1.5배 가산\n- 10~12월 창립: 3,000점 X 1.3배 가산\n- 1월 이후 창립: 3,000점\n*(신입회원 RI등록 및 지구회비 입금기준)',
                    style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '신입회원 1인 지구회비 = 90,000원 X 12개월수\n예) 7월~9월 창립 회원수 40명 기준: 40명 X 100점 + 3,000점 X 1.5배 = 8,500점',
                    style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                  ),
                ],isFirst: true,
              ),
              AllocationSection(
                title: '신입회원 증가',
                content: [
                  Text(
                    '● 입회 날짜별 점수 차등 및 가산점 부여',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '- 7~9월 증가 회원 1인당 100점 X 1.5배 가산\n- 10~12월 증가 회원 1인당 100점 X 1.3배 가산\n- 1월 이후 증가 회원 1인당 100점\n*(신입회원 RI등록 및 지구회비 입금기준)',
                    style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '신입회원 1인 지구회비 = 90,000원 X 12개월수\n예) 7월~9월 증가 회원 수 10명 기준: 10명 X 100점 X 1.5배 = 1,500점',
                    style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                  ),
                ],
              ),
              AllocationSection(
                title: '재단기부',
                content: [
                  Text(
                    '● 월별 차등 점수 부여',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '- 7~9월 기부: X 1.5배 가산\n- 10~11월 기부: X 1.3배 가산',
                    style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '\$5,000 미만: \$1,000 당 100점\n\$5,000이상 \$10,000 미만: \$1,000 당 150점 적용\n\$10,000 이상: \$1,000 당 250점 적용',
                    style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '예) 7월~9월 기부 \$10,000 미만 기준: \$9,000 X 0.15 X 1.5배 = 2,025점\n예) 7월~9월 기부 \$10,000 이상 기준: \$15,000 X 0.25 X 1.5배 = 5,625점',
                    style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                  ),
                ],
              ),
              AllocationSection(
                title: '전회원 PHF',
                content: [
                  Text(
                    '● 5000점',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '2024-25년도 RI 등록된 클럽 전체 회원 모두가\n\$1,000이상 로타리재단에 기부한 클럽(지명제외)',
                    style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                  ),
                ],
              ),
              AllocationSection(
                title: '전회원 RFSM',
                content: [
                  Text(
                    '● 1000점',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '2024-25년도 RI 등록된 클럽 전체 회원 모두가\n\$100이상 로타리재단에 기부한 클럽(지명제외)',
                    style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                  ),
                ],
              ),
              AllocationSection(
                title: '폴리오 플러스 기금 (저금통) 모금 참여',
                content: [
                  Text(
                    '● 200점',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '재적회원 70% 저금통 배부/회수율 80% 이상 200점\n추가 회수 저금통 개당 5점 가산',
                    style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                  ),
                ],
              ),
              AllocationSection(
                title: '폴리오 플러스 기금',
                content: [
                  Text(
                    '● 금액별 차등부여',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '10만원당 10점 X1.5배 (현금만 인정, 수표 X)',
                    style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                  ),
                ],
              ),

              AllocationSection(
                title: '장학문화재단 기부',
                content: [
                  Text(
                    '● 30만원당 30점',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor,
                    ),
                  ),
                ],
              ),
              AllocationSection(
                title: '지구연수협의회 등록',
                content: [
                  Text(
                    '● 100점',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '의무등록 12명 / 추가 등록 1인당 10점 가산\n(단, 재적회원 수의 초과 추가 등록은 불가)',
                    style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                  ),
                ],
              ),
              AllocationSection(
                title: '지구대회 등록',
                content: [
                  Text(
                    '● 100점',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '등록인원별 추가 점수 부여\n\n- 100%등록시 추가300점, \n- 150% 등록시 추가점 500점,\n- 200% 등록시 추가점수 1,000점',
                    style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                  ),
                ],
              ),
              AllocationSection(
                title: '지구행사 주관 지역 및 클럽',
                content: [
                  Text(
                    '● 200점',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '횟수별 200점 (6명 기준) / 행사 정리까지 완료',
                    style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                  ),
                ],
              ),
              AllocationSection(
                title: '지구행사 후원 기부 및 광고 협찬',
                content: [
                  Text(
                    '● 100만원당 200점',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor,
                    ),
                  ),
                ],
              ),
              AllocationSection(
                title: '지구 주관 김장봉사 협찬 및 참여',
                content: [
                  Text(
                    '● 100만원당 100점',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor,
                    ),
                  ),
                ],
              ),
              AllocationSection(
                title: '기타 지구행사 참여 (등록금 없는 경우)',
                content: [
                  Text(
                    '● 30점',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '점수 부여에 대해 사전 공지된 행사만 해당',
                    style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                  ),
                ],
              ),
              AllocationSection(
                title: 'RI회비 상, 하반기 납부',
                content: [
                  Text(
                    '● 50점',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '상반기 8월 31일 / 하반기 2월 28일까지 납부',
                    style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                  ),
                ],
              ),
              AllocationSection(
                title: '지구회비 납부',
                content: [
                  Text(
                    '● 50점',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '한국로타리 100주년 기념 사업비 포함, \n8월 31일까지 납부한 클럽에 점수 부여',
                    style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                  ),
                ],
              ),
              AllocationSection(
                title: '각종 분담금 납부 (세미나, 지구행사 등록비)',
                content: [
                  Text(
                    '● 1만원당 10점',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor,
                    ),
                  ),
                ],
              ),
              AllocationSection(
                title: '로타리코리아지, 청소년연합회비, 로타리회관 관리비',
                content: [
                  Text(
                    '● 1만원당 10점',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor,
                    ),
                  ),
                ],
              ),
              AllocationSection(
                title: '봉사활동',
                content: [
                  Text(
                    '● 실시 횟수당 100점',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '최대 24회까지만 인정',
                    style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                  ),
                ],
              ),
              AllocationSection(
                title: '국내 자매클럽 합동봉사 및 교류',
                content: [
                  Text(
                    '● 실시 횟수당 120점',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '최대 10회까지만 인정 / 자매클럽 결연 및 \n교류, 봉사 등',
                    style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                  ),
                ],
              ),
              AllocationSection(
                title: '국제봉사',
                content: [
                  Text(
                    '● 200점',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '참여회원 1인 200점',
                    style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                  ),
                ],
              ),
              AllocationSection(
                title: '문화정기모임',
                content: [
                  Text(
                    '● 60점',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '2회 이상 실시 1회당 60점 (최대 3회까지 인정)',
                    style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                  ),
                ],
              ),
              AllocationSection(
                title: '로타리코리아 총재월신 투고',
                content: [
                  Text(
                    '● 70점',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '게재횟수 당 70점, 로타리코리아, 총재월신 \n각 최대 2회 가능 (동정 미포함)',
                    style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                  ),
                ],
              ),
              AllocationSection(
                title: 'RCC창립',
                content: [
                  Text(
                    '● 1000점',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '20명 이상 창립 (창립 전 지구보고 건에 한해 인정)',
                    style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                  ),
                ],
              ),
              AllocationSection(
                title: '장학금 및 봉사금 전달',
                content: [
                  Text(
                    '● 100만원당 100점',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '(클럽명의로 전달 시 인정)',
                    style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                  ),
                ],
              ),
              AllocationSection(
                title: '물품 전달',
                content: [
                  Text(
                    '● 80점',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '물품금액 100만원당 80점 \n(클럽명의로 전달 시 인정)',
                    style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                  ),
                ],
              ),
              AllocationSection(
                title: '글로벌 보조금 사업 인바운드',
                content: [
                  Text(
                    '● 300점',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '클럽 주관의 글로벌 보조금 사업 시행 및 승인 완료시',
                    style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                  ),
                ],
              ),
              AllocationSection(
                title: '글로벌 보조금 사업 아웃바운드',
                content: [
                  Text(
                    '● 200점',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '클럽 주관의 글로벌 보조금 사업 시행 및 승인 완료시',
                    style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                  ),
                ],
              ),
              AllocationSection(
                title: '국외 자매클럽 결연 및 교류, 봉사',
                content: [
                  Text(
                    '● 실시횟수당 100점, 10명이상 실시 및 교류',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor,
                    ),
                  ),
                ],
              ),
            AllocationSection(
              title: '장학금 및 봉사금 전달',
              content: [
                Text(
                  '● 100만원당 100점',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: GlobalColor.darkGreyFontColor,
                  ),
                ),
              ],
            ),
            AllocationSection(
              title: '물품 전달',
              content: [
                Text(
                  '● 10만원당 80점',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: GlobalColor.darkGreyFontColor,
                  ),
                ),
              ],
            ),
            AllocationSection(
              title: '리틀, 인터, 로타랙트 창립',
              content: [
                Text(
                  '● 1000점',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: GlobalColor.darkGreyFontColor,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  '20명 이상 창립 / 30명 이상 창립시 100점 추가 \n점수 부여',
                  style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                ),
              ],
            ),
            AllocationSection(
              title: '신세대 파트너 합동 봉사활동',
              content: [
                Text(
                  '● 50점',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: GlobalColor.darkGreyFontColor,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  '인터-로타랙트 클럽의 봉사활동 \n(로타리안 10명 이상 참여시 인정)',
                  style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                ),
              ],
            ),
            AllocationSection(
              title: '라일라 등록 및 참여',
              content: [
                Text(
                  '● 200점',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: GlobalColor.darkGreyFontColor,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  '의무등록 200점 / 추가등록 1인당 50점 가산',
                  style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                ),
              ],
            ),
            AllocationSection(
              title: '인터로타랙트 지구대회 등록 및 참여',
              content: [
                Text(
                  '● 200점',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor),
                ),
                SizedBox(height: 12),
                Text(
                  '의무등록 200점 / 추가 등록 1인당 50점 가산',
                  style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                ),
              ],
            ),
            AllocationSection(
              title: '클럽에서 연수위원 초빙 교육(2회 의무)',
              content: [
                Text(
                  '● 1회/100점',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor),
                ),
                SizedBox(height: 12),
                Text(
                  '- 1회 참여 이상시 점수 부여, \n  클럽 인원 60% 이상 참여 \n\n- 최대 3회까지 점수 부여 \n\n- 회당 40분 이상 강의',
                  style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                ),
              ],
            ),
            AllocationSection(
              title: '라일라 등록 및 참여',
              content: [
                Text(
                  '● 날짜별 차등부여',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor),
                ),
                SizedBox(height: 12),
                Text(
                  '- 8월 이전 개최 200점 \n- 8월 이내 개최 100점 \n- 9월 1일 이후 개최 50점',
                  style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                ),
              ],
            ),
            AllocationSection(
              title: '클럽 주관의 신회원(3년 미만) 연수회 1회 필수',
              content: [
                Text(
                  '● 100점',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor),
                ),
                SizedBox(height: 12),
                Text(
                  '클럽 주관의 신회원 연수회 1회 이상 개최 후 명단, 사진 제출 필수',
                  style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                ),
              ],
            ),
            AllocationSection(
              title: '세계대회 등록',
              content: [
                Text(
                  '● 100점',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor),
                ),
                SizedBox(height: 12),
                Text(
                  '등록인원 1인당 100점',
                  style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                ),
              ],
            ),
            AllocationSection(
              title: '로타리, 봉사관련 영상미디어(공영방송) 홍보',
              content: [
                Text(
                  '● 100점',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor),
                ),
                SizedBox(height: 12),
                Text(
                  'MBC, KBS, TBC(SBS) 등 공영방송 홍보 횟수 당 100점 / 중복건 제외 / 링크 필요',
                  style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                ),
              ],
            ),
            AllocationSection(
              title: '숏폼 콘텐츠, 숏폼 플랫폼, SNS 홍보',
              content: [
                Text(
                  '● 10점',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor),
                ),
                SizedBox(height: 12),
                Text(
                  '숏폼 콘텐츠 (유튜브, 틱톡, 릴스 등), \nSNS (인스타, 페이스북 등) \n홍보 횟수당 10점 / 최대 20회',
                  style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                ),
              ],
            ),
            AllocationSection(
              title: '신문사 홍보',
              content: [
                Text(
                  '● 30점',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor),
                ),
                SizedBox(height: 12),
                Text(
                  '신문사 (전국지, 매일신문, 영남일보, 대구일보) \n게재 횟수당 30점 / 최대 20회 (중복 제외)',
                  style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                ),
              ],
            ),
            AllocationSection(
              title: '내 로타리 계정 만들기',
              content: [
                Text(
                  '● 100점',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor),
                ),
                SizedBox(height: 12),
                Text(
                  '전회원의 80% 이상 로타리 웹사이트 "내 로타" \n계정 만들기 완료',
                  style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                ),
              ],
            ),
            AllocationSection(
              title: '사진콘테스트 출품 참여',
              content: [
                Text(
                  '● 10점',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor),
                ),
                SizedBox(height: 12),
                Text(
                  '1작품당 10점, 클럽당 출품작 20점까지 인정 \n(출품작 20점 초과 시 배점에서 제외)',
                  style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                ),
              ],
            ),
            AllocationSection(
              title: '총재월신, 로타리코리아지 책자비치',
              content: [
                Text(
                  '● 1회/20점',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor),
                ),
                SizedBox(height: 12),
                Text(
                  '공공기관 내 총재월신, 로타리코리아지 비치 할 시 (인증샷 필수) / 최대 10회',
                  style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                ),
              ],
            ),
            AllocationSection(
              title: '로타리 회원의 집 신청',
              content: [
                Text(
                  '● 15점',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor),
                ),
                SizedBox(height: 12),
                Text(
                  '로타리 회원의 집 명판 달기 참여 업체 1개당 15점',
                  style: TextStyle(fontSize: 16, color: GlobalColor.darkGreyFontColor),
                ),
              ],
            ),
            AllocationSection(
              title: '로타리 제휴(대구은행) 희망카드발급',
              content: [
                Text(
                  '● 기업신용카드 발급 1개당 15점 / 개인신용카드 1개당 10점',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: GlobalColor.darkGreyFontColor),
                ),
              ],
            ),





            ],
          ),
        ),
      ),
    );
  }
}

class AllocationSection extends StatelessWidget {
  final String title;
  final List<Widget> content;
  final bool isFirst; // 첫 번째 항목 여부 플래그 추가

  const AllocationSection({
    Key? key,
    required this.title,
    required this.content,
    this.isFirst = false, // 기본값 false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 24),
          decoration: BoxDecoration(
            color: GlobalColor.primaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Card(
          color: GlobalColor.boxColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: content,
            ),
          ),
        ),
      ],
    );
  }
}
