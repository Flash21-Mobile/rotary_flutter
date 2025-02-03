// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'r_i_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RI _$RIFromJson(Map<String, dynamic> json) => RI(
      number: (json['number'] as num?)?.toInt(),
      account: json['account'] == null
          ? null
          : Account.fromJson(json['account'] as Map<String, dynamic>),
      nickname: json['nickname'] as String?,
      job: json['job'] as String?,
      time: json['time'] as String?,
    );

Map<String, dynamic> _$RIToJson(RI instance) => <String, dynamic>{
      'number': instance.number,
      'account': instance.account,
      'nickname': instance.nickname,
      'job': instance.job,
      'time': instance.time,
    };
