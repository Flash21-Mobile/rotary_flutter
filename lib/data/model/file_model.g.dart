// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileModel _$FileModelFromJson(Map<String, dynamic> json) => FileModel(
      id: (json['id'] as num?)?.toInt(),
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

Map<String, dynamic> _$FileModelToJson(FileModel instance) => <String, dynamic>{
      'id': instance.id,
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
