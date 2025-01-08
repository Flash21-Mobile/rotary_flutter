// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      userPassword: (json['userPassword'] as num?)?.toInt(),
      permission: json['permission'] as bool?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      telephone: json['telephone'] as String?,
      cellphone: json['cellphone'] as String?,
      faxNumber: json['faxNumber'] as String?,
      signupYear: (json['signupYear'] as num?)?.toInt(),
      graduationYear: (json['graduationYear'] as num?)?.toInt(),
      birthDate: json['birthDate'] as String?,
      workAddress: json['workAddress'] as String?,
      workAddressSub: json['workAddressSub'] as String?,
      workAddressZipCode: json['workAddressZipCode'] as String?,
      workName: json['workName'] as String?,
      workPositionName: json['workPositionName'] as String?,
      homeAddress: json['homeAddress'] as String?,
      homeAddressSub: json['homeAddressSub'] as String?,
      homeAddressZipCode: json['homeAddressZipCode'] as String?,
      grade: json['grade'] == null
          ? null
          : Grade.fromJson(json['grade'] as Map<String, dynamic>),
      groupGrade: json['groupGrade'] == null
          ? null
          : Grade.fromJson(json['groupGrade'] as Map<String, dynamic>),
      pastGrade: json['pastGrade'] == null
          ? null
          : Grade.fromJson(json['pastGrade'] as Map<String, dynamic>),
      android: json['android'] as bool?,
      ios: json['ios'] as bool?,
      active: json['active'] as bool?,
      clubRI: (json['clubRI'] as num?)?.toInt(),
      memberRI: (json['memberRI'] as num?)?.toInt(),
      nickname: json['nickname'] as String?,
      englishName: json['englishName'] as String?,
      memo: json['memo'] as String?,
      job: json['job'] as String?,
      region: json['region'] == null
          ? null
          : Grade.fromJson(json['region'] as Map<String, dynamic>),
      team: json['team'] == null
          ? null
          : Grade.fromJson(json['team'] as Map<String, dynamic>),
      childTeam: json['childTeam'] == null
          ? null
          : Grade.fromJson(json['childTeam'] as Map<String, dynamic>),
      time: json['time'] as String?,
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userPassword': instance.userPassword,
      'permission': instance.permission,
      'name': instance.name,
      'email': instance.email,
      'telephone': instance.telephone,
      'cellphone': instance.cellphone,
      'faxNumber': instance.faxNumber,
      'signupYear': instance.signupYear,
      'graduationYear': instance.graduationYear,
      'birthDate': instance.birthDate,
      'workAddress': instance.workAddress,
      'workAddressSub': instance.workAddressSub,
      'workAddressZipCode': instance.workAddressZipCode,
      'workName': instance.workName,
      'workPositionName': instance.workPositionName,
      'homeAddress': instance.homeAddress,
      'homeAddressSub': instance.homeAddressSub,
      'homeAddressZipCode': instance.homeAddressZipCode,
      'grade': instance.grade,
      'groupGrade': instance.groupGrade,
      'pastGrade': instance.pastGrade,
      'android': instance.android,
      'ios': instance.ios,
      'active': instance.active,
      'clubRI': instance.clubRI,
      'memberRI': instance.memberRI,
      'nickname': instance.nickname,
      'englishName': instance.englishName,
      'memo': instance.memo,
      'job': instance.job,
      'region': instance.region,
      'team': instance.team,
      'childTeam': instance.childTeam,
      'time': instance.time,
    };

Grade _$GradeFromJson(Map<String, dynamic> json) => Grade(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      positionName: json['positionName'] as String?,
      order: (json['order'] as num?)?.toInt(),
      groupOrder: (json['groupOrder'] as num?)?.toInt(),
      active: json['active'] as bool?,
    );

Map<String, dynamic> _$GradeToJson(Grade instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'positionName': instance.positionName,
      'order': instance.order,
      'groupOrder': instance.groupOrder,
      'active': instance.active,
    };
