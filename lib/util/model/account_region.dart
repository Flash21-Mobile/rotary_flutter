library;

import 'package:rotary_flutter/util/model/account_grade_model.dart';
import 'package:rotary_flutter/util/model/region_model.dart';

import '../../data/model/account/response/account_model.dart';

part 'account_grade.dart';

class AccountRegion {
  static List<RegionModel> regions = [
    RegionModel(id: null, name: "전체", grades: <AccountGradeModel>[
      ...[AccountGradeModel(grade: '전체', date: null, id: null)],
      ..._AccountGrade.firstGrades,
      ..._AccountGrade.secondGrades,
      ..._AccountGrade.thirdGrades,
      ..._AccountGrade.forthGrades,
      ..._AccountGrade.fifthGrades,
      ..._AccountGrade.sixthGrades,
      ..._AccountGrade.seventhGrades,
      ..._AccountGrade.eighthGrades,
      ..._AccountGrade.ninthGrades,
      ..._AccountGrade.tenthGrades,
      ..._AccountGrade.eleventhGrades,
      ..._AccountGrade.twelfthGrades
    ]..sort((a, b) {
      if (a.date == null) return -1; // a가 null이면 앞으로 보냄
      if (b.date == null) return 1;  // b가 null이면 뒤로 보냄
      return a.date!.compareTo(b.date!); // 날짜 기준 오름차순 정렬
    })),
    RegionModel(id: 238, name: "1지역", grades: [AccountGradeModel(grade: '1지역 전체', date: null,id: null), ..._AccountGrade.firstGrades..sort((a, b) {
  if (a.date == null) return -1; // a가 null이면 앞으로 보냄
  if (b.date == null) return 1;  // b가 null이면 뒤로 보냄
  return a.date!.compareTo(b.date!); // 날짜 기준 오름차순 정렬
  })]),
    RegionModel(id: 240,name: "2지역", grades: [AccountGradeModel(grade: '2지역 전체', date: null,id: null), ..._AccountGrade.secondGrades]..sort((a, b) {
      if (a.date == null) return -1; // a가 null이면 앞으로 보냄
      if (b.date == null) return 1;  // b가 null이면 뒤로 보냄
      return a.date!.compareTo(b.date!); // 날짜 기준 오름차순 정렬
    })),
    RegionModel(id: 241,name: "3지역", grades: [AccountGradeModel(grade: '3지역 전체', date: null,id: null), ..._AccountGrade.thirdGrades]..sort((a, b) {
      if (a.date == null) return -1; // a가 null이면 앞으로 보냄
      if (b.date == null) return 1;  // b가 null이면 뒤로 보냄
      return a.date!.compareTo(b.date!); // 날짜 기준 오름차순 정렬
    })),
    RegionModel(id: 242,name: "4지역", grades: [AccountGradeModel(grade: '4지역 전체', date: null,id: null), ..._AccountGrade.forthGrades]..sort((a, b) {
      if (a.date == null) return -1; // a가 null이면 앞으로 보냄
      if (b.date == null) return 1;  // b가 null이면 뒤로 보냄
      return a.date!.compareTo(b.date!); // 날짜 기준 오름차순 정렬
    })),
    RegionModel(id: 243,name: "5지역", grades: [AccountGradeModel(grade: '5지역 전체', date: null,id: null), ..._AccountGrade.fifthGrades]..sort((a, b) {
      if (a.date == null) return -1; // a가 null이면 앞으로 보냄
      if (b.date == null) return 1;  // b가 null이면 뒤로 보냄
      return a.date!.compareTo(b.date!); // 날짜 기준 오름차순 정렬
    })),
    RegionModel(id: 254,name: "6지역", grades: [AccountGradeModel(grade: '6지역 전체', date: null,id: null), ..._AccountGrade.sixthGrades]..sort((a, b) {
      if (a.date == null) return -1; // a가 null이면 앞으로 보냄
      if (b.date == null) return 1;  // b가 null이면 뒤로 보냄
      return a.date!.compareTo(b.date!); // 날짜 기준 오름차순 정렬
    })),
    RegionModel(id: 255,name: "7지역", grades: [AccountGradeModel(grade: '7지역 전체', date: null,id: null), ..._AccountGrade.seventhGrades]..sort((a, b) {
      if (a.date == null) return -1; // a가 null이면 앞으로 보냄
      if (b.date == null) return 1;  // b가 null이면 뒤로 보냄
      return a.date!.compareTo(b.date!); // 날짜 기준 오름차순 정렬
    })),
    RegionModel(id: 256,name: "8지역", grades: [AccountGradeModel(grade: '8지역 전체', date: null,id: null), ..._AccountGrade.eighthGrades]..sort((a, b) {
      if (a.date == null) return -1; // a가 null이면 앞으로 보냄
      if (b.date == null) return 1;  // b가 null이면 뒤로 보냄
      return a.date!.compareTo(b.date!); // 날짜 기준 오름차순 정렬
    })),
    RegionModel(id: 257,name: "9지역", grades: [AccountGradeModel(grade: '9지역 전체', date: null,id: null), ..._AccountGrade.ninthGrades]..sort((a, b) {
      if (a.date == null) return -1; // a가 null이면 앞으로 보냄
      if (b.date == null) return 1;  // b가 null이면 뒤로 보냄
      return a.date!.compareTo(b.date!); // 날짜 기준 오름차순 정렬
    })),
    RegionModel(id: 12,name: "10지역", grades: [AccountGradeModel(grade: '10지역 전체', date: null,id: null), ..._AccountGrade.tenthGrades]..sort((a, b) {
      if (a.date == null) return -1; // a가 null이면 앞으로 보냄
      if (b.date == null) return 1;  // b가 null이면 뒤로 보냄
      return a.date!.compareTo(b.date!); // 날짜 기준 오름차순 정렬
    })),
    RegionModel(id: 13,name: "11지역", grades: [AccountGradeModel(grade: '11지역 전체', date: null,id: null), ..._AccountGrade.eleventhGrades]..sort((a, b) {
      if (a.date == null) return -1; // a가 null이면 앞으로 보냄
      if (b.date == null) return 1;  // b가 null이면 뒤로 보냄
      return a.date!.compareTo(b.date!); // 날짜 기준 오름차순 정렬
    })),
    RegionModel(id: 14,name: "12지역", grades: [AccountGradeModel(grade: '12지역 전체', date: null,id: null), ..._AccountGrade.twelfthGrades]..sort((a, b) {
      if (a.date == null) return -1; // a가 null이면 앞으로 보냄
      if (b.date == null) return 1;  // b가 null이면 뒤로 보냄
      return a.date!.compareTo(b.date!); // 날짜 기준 오름차순 정렬
    })),
  ];
}
