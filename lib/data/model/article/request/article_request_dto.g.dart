// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleRequestDto _$ArticleRequestDtoFromJson(Map<String, dynamic> json) =>
    ArticleRequestDto(
      account: (json['account'] as num?)?.toInt(),
      board: (json['board'] as num?)?.toInt(),
      content: json['content'] as String?,
      time: json['time'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$ArticleRequestDtoToJson(ArticleRequestDto instance) =>
    <String, dynamic>{
      'account': instance.account,
      'board': instance.board,
      'content': instance.content,
      'time': instance.time,
      'title': instance.title,
    };
