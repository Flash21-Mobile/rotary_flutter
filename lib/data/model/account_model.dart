import 'package:json_annotation/json_annotation.dart';

part 'account_model.g.dart';

@JsonSerializable()
class Account {
  int? id;
  bool? permission;
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
  Grade? groupGrade;
  Grade? pastGrade;
  bool? android;
  bool? ios;
  bool? active;
  int? clubRI;
  int? memberRI;
  String? nickname;
  String? englishName;
  String? memo;
  String? job;
  Grade? region;
  Grade? team;
  Grade? childTeam;
  String? time;

  Account(
      {this.id,
        this.permission,
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
        this.groupGrade,
        this.pastGrade,
        this.android,
        this.ios,
        this.active,
        this.clubRI,
        this.memberRI,
        this.nickname,
        this.englishName,
        this.memo,
        this.job,
        this.region,
        this.team,
        this.childTeam,
        this.time});

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
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