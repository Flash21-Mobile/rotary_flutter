import 'package:json_annotation/json_annotation.dart';

part 'account_model.g.dart';

@JsonSerializable()
class Account {
  int? id;
  String? userId;
  String? userPassword;
  String? name;
  String? email;
  String? telephone;
  String? cellphone;
  String? faxNumber;
  int? signupYear;
  int? graduationYear;
  String? birthDate;
  String? workAddress;
  String? workAddressSub;
  String? workAddressZipCode;
  String? workName;
  String? workPositionName;
  String? homeAddress;
  String? homeAddressSub;
  String? homeAddressZipCode;
  Grade? grade;
  Grade? firstGrade;
  Grade? secondGrade;
  Grade? thirdGrade;
  Grade? fourthGrade;
  Grade? fifthGrade;
  bool? android;
  bool? ios;
  bool? active;
  bool? permission;
  String? clubRi;
  String? memberRi;
  String? nickname;
  String? englishName;
  String? memo;
  String? job;
  String? time;
  bool? hidden;

  Account(
      {this.id,
      this.userId,
      this.userPassword,
      this.name,
      this.email,
      this.telephone,
      this.cellphone,
      this.faxNumber,
      this.signupYear,
      this.graduationYear,
      this.birthDate,
      this.workAddress,
      this.workAddressSub,
      this.workAddressZipCode,
      this.workName,
      this.workPositionName,
      this.homeAddress,
      this.homeAddressSub,
      this.homeAddressZipCode,
      this.grade,
      this.firstGrade,
      this.secondGrade,
      this.thirdGrade,
      this.fourthGrade,
      this.fifthGrade,
      this.android,
      this.ios,
      this.active,
      this.permission,
      this.clubRi,
      this.memberRi,
      this.nickname,
      this.englishName,
      this.memo,
      this.job,
      this.time,
      this.hidden});

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

@JsonSerializable()
class Grade {
  int? id;
  String? name;
  String? positionName;
  int? order;
  int? groupOrder;
  bool? active;

  Grade(
      {this.id,
      this.name,
      this.positionName,
      this.order,
      this.groupOrder,
      this.active});

  factory Grade.fromJson(Map<String, dynamic> json) => _$GradeFromJson(json);

  Map<String, dynamic> toJson() => _$GradeToJson(this);
}
