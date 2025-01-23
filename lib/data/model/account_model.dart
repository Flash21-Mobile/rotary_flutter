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
  int? clubRi;
  int? memberRi;
  String? nickname;
  String? englishName;
  String? memo;
  String? job;
  String? time;

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
        this.time});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userPassword = json['user_password'];
    name = json['name'];
    email = json['email'];
    telephone = json['telephone'];
    cellphone = json['cellphone'];
    faxNumber = json['fax_number'];
    signupYear = json['signup_year'];
    graduationYear = json['graduation_year'];
    birthDate = json['birth_date'];
    workAddress = json['work_address'];
    workAddressSub = json['work_address_sub'];
    workAddressZipCode = json['work_address_zip_code'];
    workName = json['work_name'];
    workPositionName = json['work_position_name'];
    homeAddress = json['home_address'];
    homeAddressSub = json['home_address_sub'];
    homeAddressZipCode = json['home_address_zip_code'];
    grade = json['grade'] != null ? new Grade.fromJson(json['grade']) : null;
    firstGrade = json['first_grade'] != null
        ? new Grade.fromJson(json['first_grade'])
        : null;
    secondGrade = json['second_grade'] != null
        ? new Grade.fromJson(json['second_grade'])
        : null;
    thirdGrade = json['third_grade'] != null
        ? new Grade.fromJson(json['third_grade'])
        : null;
    fourthGrade = json['fourth_grade'] != null
        ? new Grade.fromJson(json['fourth_grade'])
        : null;
    fifthGrade = json['fifth_grade'] != null
        ? new Grade.fromJson(json['fifth_grade'])
        : null;
    android = json['android'];
    ios = json['ios'];
    active = json['active'];
    permission = json['permission'];
    clubRi = json['club_ri'];
    memberRi = json['member_ri'];
    nickname = json['nickname'];
    englishName = json['english_name'];
    memo = json['memo'];
    job = json['job'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_password'] = this.userPassword;
    data['name'] = this.name;
    data['email'] = this.email;
    data['telephone'] = this.telephone;
    data['cellphone'] = this.cellphone;
    data['fax_number'] = this.faxNumber;
    data['signup_year'] = this.signupYear;
    data['graduation_year'] = this.graduationYear;
    data['birth_date'] = this.birthDate;
    data['work_address'] = this.workAddress;
    data['work_address_sub'] = this.workAddressSub;
    data['work_address_zip_code'] = this.workAddressZipCode;
    data['work_name'] = this.workName;
    data['work_position_name'] = this.workPositionName;
    data['home_address'] = this.homeAddress;
    data['home_address_sub'] = this.homeAddressSub;
    data['home_address_zip_code'] = this.homeAddressZipCode;
    if (this.grade != null) {
      data['grade'] = this.grade!.toJson();
    }
    if (this.firstGrade != null) {
      data['first_grade'] = this.firstGrade!.toJson();
    }
    if (this.secondGrade != null) {
      data['second_grade'] = this.secondGrade!.toJson();
    }
    if (this.thirdGrade != null) {
      data['third_grade'] = this.thirdGrade!.toJson();
    }
    if (this.fourthGrade != null) {
      data['fourth_grade'] = this.fourthGrade!.toJson();
    }
    if (this.fifthGrade != null) {
      data['fifth_grade'] = this.fifthGrade!.toJson();
    }
    data['android'] = this.android;
    data['ios'] = this.ios;
    data['active'] = this.active;
    data['permission'] = this.permission;
    data['club_ri'] = this.clubRi;
    data['member_ri'] = this.memberRi;
    data['nickname'] = this.nickname;
    data['english_name'] = this.englishName;
    data['memo'] = this.memo;
    data['job'] = this.job;
    data['time'] = this.time;
    return data;
  }
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
      {
  this.id,
        this.name,
        this.positionName,
        this.order,
        this.groupOrder,
        this.active
      }
      );

  Grade.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    positionName = json['position_name'];
    order = json['order'];
    groupOrder = json['group_order'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['position_name'] = this.positionName;
    data['order'] = this.order;
    data['group_order'] = this.groupOrder;
    data['active'] = this.active;
    return data;
  }
}