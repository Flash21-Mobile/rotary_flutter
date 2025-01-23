// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      id: (json['id'] as num?)?.toInt(),
      userId: json['userId'] as String?,
      userPassword: json['userPassword'] as String?,
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
      firstGrade: json['firstGrade'] == null
          ? null
          : Grade.fromJson(json['firstGrade'] as Map<String, dynamic>),
      secondGrade: json['secondGrade'] == null
          ? null
          : Grade.fromJson(json['secondGrade'] as Map<String, dynamic>),
      thirdGrade: json['thirdGrade'] == null
          ? null
          : Grade.fromJson(json['thirdGrade'] as Map<String, dynamic>),
      fourthGrade: json['fourthGrade'] == null
          ? null
          : Grade.fromJson(json['fourthGrade'] as Map<String, dynamic>),
      fifthGrade: json['fifthGrade'] == null
          ? null
          : Grade.fromJson(json['fifthGrade'] as Map<String, dynamic>),
      android: json['android'] as bool?,
      ios: json['ios'] as bool?,
      active: json['active'] as bool?,
      permission: json['permission'] as bool?,
      clubRi: (json['clubRi'] as num?)?.toInt(),
      memberRi: (json['memberRi'] as num?)?.toInt(),
      nickname: json['nickname'] as String?,
      englishName: json['englishName'] as String?,
      memo: json['memo'] as String?,
      job: json['job'] as String?,
      time: json['time'] as String?,
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userPassword': instance.userPassword,
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
      'firstGrade': instance.firstGrade,
      'secondGrade': instance.secondGrade,
      'thirdGrade': instance.thirdGrade,
      'fourthGrade': instance.fourthGrade,
      'fifthGrade': instance.fifthGrade,
      'android': instance.android,
      'ios': instance.ios,
      'active': instance.active,
      'permission': instance.permission,
      'clubRi': instance.clubRi,
      'memberRi': instance.memberRi,
      'nickname': instance.nickname,
      'englishName': instance.englishName,
      'memo': instance.memo,
      'job': instance.job,
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
