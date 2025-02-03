import 'package:json_annotation/json_annotation.dart';

part 'sign_model.g.dart';

@JsonSerializable()
class SignModel {
  String? name;
  String? cellphone;

  SignModel({this.name, this.cellphone});

  factory SignModel.fromJson(Map<String, dynamic> json) =>
      _$SignModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignModelToJson(this);
}
