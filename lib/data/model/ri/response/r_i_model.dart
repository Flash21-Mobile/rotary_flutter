import 'package:json_annotation/json_annotation.dart';

import '../../account/response/account_model.dart';

part 'r_i_model.g.dart';

@JsonSerializable()
class RI {
  int? number;
  Account? account;
  String? nickname;
  String? job;
  String? time;

  RI({this.number, this.account, this.nickname, this.job, this.time});

  factory RI.fromJson(Map<String, dynamic> json) => _$RIFromJson(json);
  Map<String, dynamic> toJson() => _$RIToJson(this);
}
