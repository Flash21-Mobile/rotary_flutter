import 'package:json_annotation/json_annotation.dart';

part 'file_model.g.dart';

@JsonSerializable()
class FileModel {
  int? id;
  String? fileName;
  String? fileID;
  String? filePath;
  int? fileSize;
  String? fileType;
  String? fileExtension;
  int? fileOrder;
  String? fileApiName;
  int? fileApiPK;

  FileModel(
      {this.id,
        this.fileName,
        this.fileID,
        this.filePath,
        this.fileSize,
        this.fileType,
        this.fileExtension,
        this.fileOrder,
        this.fileApiName,
        this.fileApiPK});

  FileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileName = json['fileName'];
    fileID = json['fileID'];
    filePath = json['filePath'];
    fileSize = json['fileSize'];
    fileType = json['fileType'];
    fileExtension = json['fileExtension'];
    fileOrder = json['fileOrder'];
    fileApiName = json['fileApiName'];
    fileApiPK = json['fileApiPK'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fileName'] = this.fileName;
    data['fileID'] = this.fileID;
    data['filePath'] = this.filePath;
    data['fileSize'] = this.fileSize;
    data['fileType'] = this.fileType;
    data['fileExtension'] = this.fileExtension;
    data['fileOrder'] = this.fileOrder;
    data['fileApiName'] = this.fileApiName;
    data['fileApiPK'] = this.fileApiPK;
    return data;
  }
}