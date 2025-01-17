library;

import 'package:rotary_flutter/util/model/region_model.dart';

part 'account_grade.dart';

class AccountRegion {
  static List<RegionModel> regions = [
    RegionModel(name: "전체", grades: [
      ...['전체 RC'],
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
    RegionModel(name: "1지역", grades: ['1지역 전체', ..._AccountGrade.firstGrades]),
    RegionModel(name: "2지역", grades: ['2지역 전체', ..._AccountGrade.secondGrades]),
    RegionModel(name: "3지역", grades: ['3지역 전체', ..._AccountGrade.thirdGrades]),
    RegionModel(name: "4지역", grades: ['4지역 전체', ..._AccountGrade.forthGrades]),
    RegionModel(name: "5지역", grades: ['5지역 전체', ..._AccountGrade.fifthGrades]),
    RegionModel(name: "6지역", grades: ['6지역 전체', ..._AccountGrade.sixthGrades]),
    RegionModel(name: "7지역", grades: ['7지역 전체', ..._AccountGrade.seventhGrades]),
    RegionModel(name: "8지역", grades: ['8지역 전체', ..._AccountGrade.eighthGrades]),
    RegionModel(name: "9지역", grades: ['9지역 전체', ..._AccountGrade.ninthGrades]),
    RegionModel(name: "10지역", grades: ['10지역 전체', ..._AccountGrade.tenthGrades]),
    RegionModel(name: "11지역", grades: ['11지역 전체', ..._AccountGrade.eleventhGrades]),
    RegionModel(name: "12지역", grades: ['12지역 전체', ..._AccountGrade.twelfthGrades]),
    RegionModel(name: "지구지도부", grades: [
      ...['전체 RC'],
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
  ];
}
