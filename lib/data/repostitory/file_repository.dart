import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:rotary_flutter/data/model/file/response/file_model.dart';

import '../model/account/response/account_model.dart';

part 'file_repository.g.dart';

@RestApi()
abstract class FileRepository {
  factory FileRepository(Dio dio, {String baseUrl}) = _FileRepository;

  @GET("/file")
  Future<List<FileModel>?> getFile(
      @Query('api') String? fileApiName,
      @Query('pk') int? fileApiPK,
  );

  @POST("/file")
  @MultiPart()
  Future postFile(
      @Query('api') String? fileApiName,
      @Query('pk') int? fileApiPK,
      @Part(name: 'image') List<File> file
      );
}