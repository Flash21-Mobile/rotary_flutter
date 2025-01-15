// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) => ArticleModel(
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

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) =>
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
