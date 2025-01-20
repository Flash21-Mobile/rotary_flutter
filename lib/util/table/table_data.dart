import 'table_interfaces.dart';

class TableData {
  static List<CriterionAll> all = [
    const CriterionAll(type: '시상종류', target: '대상', content: '내용'),
    const CriterionAll(type: '최우수클럽', target: '1개 클럽', content: '클럽 종합평가점수 최고점 클럽'),
    const CriterionAll(type: '우수클럽', target: '12개 클럽', content: '최우수 클럽을 제외한 차순위 클럽'),
    const CriterionAll(type: '여성 우수클럽', target: '1개 클럽', content: '여성클럽종합평가점수 최고클럽'),
    const CriterionAll(type: '신클럽 우수클럽\n(창립 3년 미만)', target: '1개 클럽', content: '신생클럽 종합평가점수 최고클럽'),
    const CriterionAll(type: '총재클럽특별상', target: '1개 클럽', content: '지구발전에 현저한\n공로가 있는 클럽'),
  ];

  static List<CriterionClub> club = [
    const CriterionClub(type: '시상종류', target: '대상', content: '내용'),
    const CriterionClub(type: '지구 확대', target: '해당 클럽', content: '신생 클럽을 창립한 클럽'),
    const CriterionClub(type: '회원증강\n최우수클럽', target: '해당 클럽', content: '최다 회원순증가 클럽'),
    const CriterionClub(type: '회원증강\n우수클럽', target: '해당 클럽', content: '회원 순증 10명 이상 클럽'),
    const CriterionClub(type: '100% 회원증강 클럽', target: '해당 클럽', content: '클럽 회원 100% 순증가 클럽'),
    const CriterionClub(type: '로타리재단\n기여 최우수클럽', target: '해당 클럽', content: '로타리 재단에 최고액을\n기부한 클럽'),
    const CriterionClub(type: '로타리재단\n기여 우수클럽', target: '해당 클럽', content: '로타리재단 기부\n20,000불 이상 클럽'),
    const CriterionClub(type: '전회원\nPHF 기부 클럽', target: '해당 클럽', content: '전회원 PHF 달성 클럽', note: '❊ 지명 제외'),
    const CriterionClub(type: '전회원 RFSM\n로타리재단 후원', target: '해당 클럽', content: '전 회원 100\$ 이상 기여한 클럽'),
    const CriterionClub(type: '장학문화재단\n최우수클럽', target: '해당 클럽', content: '장학문화재단 최고액 기부 클럽'),
    const CriterionClub(type: '봉사상', target: '해당 클럽', content: '최다 봉사 사업 클럽'),
    const CriterionClub(type: '공공이미지 함양상', target: '해당 클럽', content: '매스미디어에 로타리홍보 5회 이상', note: '❊ 동일 봉사 건 제외'),
    const CriterionClub(type: '지구대회 등록상', target: '최우등록클럽', content: '매스미디어에 로타리홍보\n5회 이상'),
    const CriterionClub(type: '지구대회 등록상', target: '우수등록클럽', content: '회원 100% 등록'),
    const CriterionClub(type: '베스트 영상물\n제작상', target: '해당 클럽', content: 'SNS 영상물 제작, 공유클럽 선정'),
    const CriterionClub(type: '봉사파트너 공헌상', target: '해당 클럽', content: '리틀,인터,로타랙트,RCC 창립클럽'),
    const CriterionClub(type: '지구행사 주관\n공로상', target: '해당 클럽', content: '지구행사를 최다 주관한 클럽'),
    const CriterionClub(type: '우수 부인회 상', target: '해당 클럽', content: '우수한 부인회 운영클럽'),
  ];

  static List<CriterionPersonal> personal = [
    const CriterionPersonal(type: '시상종류', target: '대상', note: '비고'),
    const CriterionPersonal(type: '로타리 확대상', target: '신생클럽 어드바이저, 스폰서 클럽 회장'),
    const CriterionPersonal(type: '홍보상', target: '외부표창 수상자'),
    const CriterionPersonal(type: '홍보상', target: '로타리활동을 매스미디어에\n많이 홍보한 회원'),
    const CriterionPersonal(type: '로타리\n자원봉사상', target: '로타리 자원봉사 최다\n참여 회원'),
    const CriterionPersonal(type: '봉사파트너\n공헌상', target: '리틀, 인터, 로타랙트클럽\n창립에 현저한\n공로가 있는 회원'),
    const CriterionPersonal(type: '봉사파트너\n공헌상', target: '지역사회 봉사단 창립에\n현저한 공로가 있는 회원'),
    const CriterionPersonal(type: '봉사파트너\n공헌상', target: '로타리 재단 동창에 현저한\n공로가 있는 회원'),
    const CriterionPersonal(type: '회원증강상', target: '대상 - 신입회원을 10명\n이상 추천한 회원'),
    const CriterionPersonal(type: '회원증강상', target: '금상 - 신입회원을 8명\n이상 추천한 회원'),
    const CriterionPersonal(type: '회원증강상', target: '은상- 신입회원을 5명\n이상 추천한 회원'),
    const CriterionPersonal(type: '공로상', target: '지구발전에 현저한 공로가\n있는 회원'),
    const CriterionPersonal(type: '개참상', target: '10, 15, 20, 25, 30, 35, 40,\n45, 50, 55년 개참회원', note: '20년 미만(상장)\n20년 이상(상패)'),
    const CriterionPersonal(type: '우수회장, 총무상', target: '각 지역대표가 추천한\n각 지역 회장(1명), 총무(1명)'),
    const CriterionPersonal(type: '총재특별상', target: ''),
    const CriterionPersonal(type: '국제봉사상', target: '국제봉사 활동에 현저한\n공로가 있는 회원'),
    const CriterionPersonal(type: '우수재단 기여상', target: '로타리재단 \$3,000\n이상 기부 회원'),
    const CriterionPersonal(type: '유공상', target: '클럽발전에 현저한\n공이 있는 회원', note: '클럽별 1인 추천'),
    const CriterionPersonal(type: '우수 사무장상', target: '업무 능력 및 클럽과\n지구 간의 원활한 소통', note: '최우수클럽 1명,\n지역대표 추천 3명')
  ];
}