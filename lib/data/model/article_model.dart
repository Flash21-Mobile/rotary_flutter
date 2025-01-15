import 'package:json_annotation/json_annotation.dart';

import 'account_model.dart';

part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel {
  int? id;
  Account? account;
  Board? board;
  String? title;
  String? content;

  ArticleModel({this.id, this.account, this.board, this.title, this.content});

  ArticleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    account =
    json['account'] != null ? new Account.fromJson(json['account']) : null;
    board = json['board'] != null ? new Board.fromJson(json['board']) : null;
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.account != null) {
      data['account'] = this.account!.toJson();
    }
    if (this.board != null) {
      data['board'] = this.board!.toJson();
    }
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}

@JsonSerializable()
class Board {
  int? id;
  String? name;

  Board({this.id, this.name});

  Board.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}