import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:rotary_flutter/data/model/advertise_model.dart';


part 'advertise_repository.g.dart';

@RestApi()
abstract class AdvertiseRepository {
  factory AdvertiseRepository(Dio dio, {String baseUrl}) = _AdvertiseRepository;

  @GET("/article")
  Future<List<AdvertiseModel>> getArticle(
      @Query('board') int? board,
      @Query('page') int? page,
      @Query('size') int? size,
      @Query('title') String? title,
      );

  @GET("/article/random")
  Future<List<AdvertiseModel>> getArticleRandom();

  @GET("/article/count")
  Future<int> getArticleCount();
}