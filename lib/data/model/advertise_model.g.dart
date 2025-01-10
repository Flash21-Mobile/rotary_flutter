// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advertise_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvertiseModel _$AdvertiseModelFromJson(Map<String, dynamic> json) =>
    AdvertiseModel(
      id: (json['id'] as num?)?.toInt(),
      account: json['account'] == null
          ? null
          : Account.fromJson(json['account'] as Map<String, dynamic>),
      board: json['board'] == null
          ? null
          : Board.fromJson(json['board'] as Map<String, dynamic>),
      title: json['title'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$AdvertiseModelToJson(AdvertiseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'account': instance.account,
      'board': instance.board,
      'title': instance.title,
      'content': instance.content,
    };

Board _$BoardFromJson(Map<String, dynamic> json) => Board(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$BoardToJson(Board instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
