// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountRequestModel _$AccountRequestModelFromJson(Map<String, dynamic> json) =>
    AccountRequestModel(
      active: json['active'] as bool?,
      android: json['android'] as bool?,
      birthDate: json['birthDate'] as String?,
      cellphone: json['cellphone'] as String?,
      clubRi: json['clubRi'] as String?,
      email: json['email'] as String?,
      englishName: json['englishName'] as String?,
      faxNumber: json['faxNumber'] as String?,
      fifthGrade: (json['fifthGrade'] as num?)?.toInt(),
      firstGrade: (json['firstGrade'] as num?)?.toInt(),
      fourthGrade: (json['fourthGrade'] as num?)?.toInt(),
      grade: (json['grade'] as num?)?.toInt(),
      graduationYear: (json['graduationYear'] as num?)?.toInt(),
      homeAddress: json['homeAddress'] as String?,
      homeAddressSub: json['homeAddressSub'] as String?,
      homeAddressZipCode: json['homeAddressZipCode'] as String?,
      ios: json['ios'] as bool?,
      job: json['job'] as String?,
      memberRi: json['memberRi'] as String?,
      memo: json['memo'] as String?,
      name: json['name'] as String?,
      nickname: json['nickname'] as String?,
      permission: json['permission'] as bool?,
      secondGrade: (json['secondGrade'] as num?)?.toInt(),
      signupYear: (json['signupYear'] as num?)?.toInt(),
      telephone: json['telephone'] as String?,
      thirdGrade: (json['thirdGrade'] as num?)?.toInt(),
      time: json['time'] as String?,
      userId: json['userId'] as String?,
      userPassword: json['userPassword'] as String?,
      workAddress: json['workAddress'] as String?,
      workAddressSub: json['workAddressSub'] as String?,
      workAddressZipCode: json['workAddressZipCode'] as String?,
      workName: json['workName'] as String?,
      workPositionName: json['workPositionName'] as String?,
      hidden: json['hidden'] as bool?,
      fcmToken: (json['fcmToken'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AccountRequestModelToJson(
        AccountRequestModel instance) =>
    <String, dynamic>{
      'active': instance.active,
      'android': instance.android,
      'birthDate': instance.birthDate,
      'cellphone': instance.cellphone,
      'clubRi': instance.clubRi,
      'email': instance.email,
      'englishName': instance.englishName,
      'faxNumber': instance.faxNumber,
      'fifthGrade': instance.fifthGrade,
      'firstGrade': instance.firstGrade,
      'fourthGrade': instance.fourthGrade,
      'grade': instance.grade,
      'graduationYear': instance.graduationYear,
      'homeAddress': instance.homeAddress,
      'homeAddressSub': instance.homeAddressSub,
      'homeAddressZipCode': instance.homeAddressZipCode,
      'ios': instance.ios,
      'job': instance.job,
      'memberRi': instance.memberRi,
      'memo': instance.memo,
      'name': instance.name,
      'nickname': instance.nickname,
      'permission': instance.permission,
      'secondGrade': instance.secondGrade,
      'signupYear': instance.signupYear,
      'telephone': instance.telephone,
      'thirdGrade': instance.thirdGrade,
      'time': instance.time,
      'userId': instance.userId,
      'userPassword': instance.userPassword,
      'workAddress': instance.workAddress,
      'workAddressSub': instance.workAddressSub,
      'workAddressZipCode': instance.workAddressZipCode,
      'workName': instance.workName,
      'workPositionName': instance.workPositionName,
      'hidden': instance.hidden,
      'fcmToken': instance.fcmToken,
    };
