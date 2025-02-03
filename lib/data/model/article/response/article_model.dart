import 'package:json_annotation/json_annotation.dart';

import '../../account/response/account_model.dart';

part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel {
  int? id;
  Account? account;
  Board? board;
  String? title;
  String? content;
  String? time;

  ArticleModel({this.id, this.account, this.board, this.title, this.content, this.time});

  factory ArticleModel.fromJson(Map<String, dynamic> json) => _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}

@JsonSerializable()
class Board {
  int? id;
  String? name;

  Board({this.id, this.name});

  factory Board.fromJson(Map<String, dynamic> json) => _$BoardFromJson(json);
  Map<String, dynamic> toJson() => _$BoardToJson(this);
}