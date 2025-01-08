import 'package:json_annotation/json_annotation.dart';

import 'account_model.dart';

part 'advertise_model.g.dart';

@JsonSerializable()
class AdvertiseModel {
  String? content;

  AdvertiseModel({this.content});

  AdvertiseModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    return data;
  }
}