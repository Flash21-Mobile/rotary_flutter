// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileRequestDto _$FileRequestDtoFromJson(Map<String, dynamic> json) =>
    FileRequestDto(
      fileName: json['fileName'] as String?,
      fileID: json['fileID'] as String?,
      filePath: json['filePath'] as String?,
      fileSize: (json['fileSize'] as num?)?.toInt(),
      fileType: json['fileType'] as String?,
      fileExtension: json['fileExtension'] as String?,
      fileOrder: (json['fileOrder'] as num?)?.toInt(),
      fileApiName: json['fileApiName'] as String?,
      fileApiPK: (json['fileApiPK'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FileRequestDtoToJson(FileRequestDto instance) =>
    <String, dynamic>{
      'fileName': instance.fileName,
      'fileID': instance.fileID,
      'filePath': instance.filePath,
      'fileSize': instance.fileSize,
      'fileType': instance.fileType,
      'fileExtension': instance.fileExtension,
      'fileOrder': instance.fileOrder,
      'fileApiName': instance.fileApiName,
      'fileApiPK': instance.fileApiPK,
    };
