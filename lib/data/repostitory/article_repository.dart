import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:rotary_flutter/data/model/article_model.dart';

part 'article_repository.g.dart';

@RestApi()
abstract class ArticleRepository {
  factory ArticleRepository(Dio dio, {String baseUrl}) = _ArticleRepository;

  @GET("/article")
  Future<List<ArticleModel>> getArticle({
    @Query('title') String? title,
    @Query('content') String? content,
    @Query('accountName') String? accountName,
    @Query('gradeName') String? gradeName,

    @Query('board') int? board,
    @Query('page') int? page,
    @Query('size') int? size,
    @Query('or') bool? or
  });

  @POST("/article")
  Future<ArticleModel> postArticle(
    @Body() ArticleModel data,
  );

  @GET("/article/random")
  Future<List<ArticleModel>> getArticleRandom();

  @GET("/article/count")
  Future<int> getArticleCount();

  @DELETE('/article/{id}')
  Future deleteArticle(
    @Path("id") int? id,
  );
}
