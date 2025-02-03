import 'package:json_annotation/json_annotation.dart';

part 'account_request_dto.g.dart';

@JsonSerializable()
class AccountRequestModel {
  bool? active;
  bool? android;
  String? birthDate;
  String? cellphone;
  int? clubRi;
  String? email;
  String? englishName;
  String? faxNumber;
  int? fifthGrade;
  int? firstGrade;
  int? fourthGrade;
  int? grade;
  int? graduationYear;
  String? homeAddress;
  String? homeAddressSub;
  String? homeAddressZipCode;
  bool? ios;
  String? job;
  int? memberRi;
  String? memo;
  String? name;
  String? nickname;
  bool? permission;
  int? secondGrade;
  int? signupYear;
  String? telephone;
  int? thirdGrade;
  String? time;
  String? userId;
  String? userPassword;
  String? workAddress;
  String? workAddressSub;
  String? workAddressZipCode;
  String? workName;
  String? workPositionName;

  AccountRequestModel(
      {required this.active,
      required this.android,
      required this.birthDate,
      required this.cellphone,
      required this.clubRi,
      required this.email,
      required this.englishName,
      required this.faxNumber,
      required this.fifthGrade,
      required this.firstGrade,
      required this.fourthGrade,
      required this.grade,
      required this.graduationYear,
      required this.homeAddress,
      required this.homeAddressSub,
      required this.homeAddressZipCode,
      required this.ios,
      required this.job,
      required this.memberRi,
      required this.memo,
      required this.name,
      required this.nickname,
      required this.permission,
      required this.secondGrade,
      required this.signupYear,
      required this.telephone,
      required this.thirdGrade,
      required this.time,
      required this.userId,
      required this.userPassword,
      required this.workAddress,
      required this.workAddressSub,
      required this.workAddressZipCode,
      required this.workName,
      required this.workPositionName});

  factory AccountRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AccountRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountRequestModelToJson(this);
}
