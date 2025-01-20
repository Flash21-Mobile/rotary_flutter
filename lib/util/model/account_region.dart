library;

import 'package:rotary_flutter/util/model/account_grade_model.dart';
import 'package:rotary_flutter/util/model/region_model.dart';

import '../../data/model/account_model.dart';

part 'account_grade.dart';

class AccountRegion {
  static List<RegionModel> regions = [
    RegionModel(name: "전체", grades: [
      ...[AccountGradeModel(grade: '전체', date: null)],
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
    ]),
    RegionModel(name: "지구지도부", grades: [
      ...[AccountGradeModel(grade: '전체', date: null)],
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
    ]),
    RegionModel(name: "1지역", grades: [AccountGradeModel(grade: '1지역 전체', date: null), ..._AccountGrade.firstGrades]),
    RegionModel(name: "2지역", grades: [AccountGradeModel(grade: '2지역 전체', date: null), ..._AccountGrade.secondGrades]),
    RegionModel(name: "3지역", grades: [AccountGradeModel(grade: '3지역 전체', date: null), ..._AccountGrade.thirdGrades]),
    RegionModel(name: "4지역", grades: [AccountGradeModel(grade: '4지역 전체', date: null), ..._AccountGrade.forthGrades]),
    RegionModel(name: "5지역", grades: [AccountGradeModel(grade: '5지역 전체', date: null), ..._AccountGrade.fifthGrades]),
    RegionModel(name: "6지역", grades: [AccountGradeModel(grade: '6지역 전체', date: null), ..._AccountGrade.sixthGrades]),
    RegionModel(name: "7지역", grades: [AccountGradeModel(grade: '7지역 전체', date: null), ..._AccountGrade.seventhGrades]),
    RegionModel(name: "8지역", grades: [AccountGradeModel(grade: '8지역 전체', date: null), ..._AccountGrade.eighthGrades]),
    RegionModel(name: "9지역", grades: [AccountGradeModel(grade: '9지역 전체', date: null), ..._AccountGrade.ninthGrades]),
    RegionModel(name: "10지역", grades: [AccountGradeModel(grade: '10지역 전체', date: null), ..._AccountGrade.tenthGrades]),
    RegionModel(name: "11지역", grades: [AccountGradeModel(grade: '11지역 전체', date: null), ..._AccountGrade.eleventhGrades]),
    RegionModel(name: "12지역", grades: [AccountGradeModel(grade: '12지역 전체', date: null), ..._AccountGrade.twelfthGrades]),
  ];
}
