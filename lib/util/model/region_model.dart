import 'package:rotary_flutter/util/model/account_grade_model.dart';

class RegionModel {
  final int? id;
  final String name;
  final List<AccountGradeModel> grades;

  RegionModel({required this.id, required this.name, required this.grades});
}