import 'package:json_annotation/json_annotation.dart';

part 'sign_verify_model.g.dart';

@JsonSerializable()
class SignVerifyModel {
  String? phone;
  String? code;

  SignVerifyModel({this.phone, this.code});

  factory SignVerifyModel.fromJson(Map<String, dynamic> json) =>
      _$SignVerifyModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignVerifyModelToJson(this);
}
