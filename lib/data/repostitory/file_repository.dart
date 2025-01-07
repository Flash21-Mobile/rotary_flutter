import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:rotary_flutter/data/model/file_model.dart';

import '../model/account_model.dart';

part 'file_repository.g.dart';

@RestApi()
abstract class FileRepository {
  factory FileRepository(Dio dio, {String baseUrl}) = _FileRepository;

  @GET("/file")
  Future<List<FileModel>?> getFile(
      @Query('fileApiName') String? fileApiName,
      @Query('fileApiPK') int? fileApiPK,
  );
}
