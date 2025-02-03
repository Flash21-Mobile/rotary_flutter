import 'package:json_annotation/json_annotation.dart';

part 'file_model.g.dart';

@JsonSerializable()
class FileModel {
  int? id;
  String? name;
  String? saveName;
  String? path;
  int? size;
  String? type;
  String? extension;
  int? order;
  String? api;
  int? pk;

  FileModel(
      {this.id,
        this.name,
        this.saveName,
        this.path,
        this.size,
        this.type,
        this.extension,
        this.order,
        this.api,
        this.pk});

  factory FileModel.fromJson(Map<String, dynamic> json) => _$FileModelFromJson(json);

  Map<String, dynamic> toJson() => _$FileModelToJson(this);
}