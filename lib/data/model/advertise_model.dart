import 'package:json_annotation/json_annotation.dart';

import 'account_model.dart';

part 'advertise_model.g.dart';

@JsonSerializable()
class AdvertiseModel {
  Account? account;
  Board? board;
  String? title;
  String? content;

  AdvertiseModel({this.account, this.board, this.title, this.content});

  factory AdvertiseModel.fromJson(Map<String, dynamic> json) => _$AdvertiseModelFromJson(json);
  Map<String, dynamic> toJson() => _$AdvertiseModelToJson(this);
}

@JsonSerializable()
class Board {
  String? name;

  Board({this.name});

  factory Board.fromJson(Map<String, dynamic> json) => _$BoardFromJson(json);
  Map<String, dynamic> toJson()  => _$BoardToJson(this);
}