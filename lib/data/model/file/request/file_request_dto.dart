import 'package:json_annotation/json_annotation.dart';

part 'file_request_dto.g.dart';

@JsonSerializable()
class FileRequestDto {
  String? fileName;
  String? fileID;
  String? filePath;
  int? fileSize;
  String? fileType;
  String? fileExtension;
  int? fileOrder;
  String? fileApiName;
  int? fileApiPK;

  FileRequestDto(
      {
        this.fileName,
        this.fileID,
        this.filePath,
        this.fileSize,
        this.fileType,
        this.fileExtension,
        this.fileOrder,
        this.fileApiName,
        this.fileApiPK});

  factory FileRequestDto.fromJson(Map<String, dynamic> json) => _$FileRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FileRequestDtoToJson(this);
}