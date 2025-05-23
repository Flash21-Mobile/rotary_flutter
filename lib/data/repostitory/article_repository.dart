import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:rotary_flutter/data/model/article/request/article_request_dto.dart';
import 'package:rotary_flutter/data/model/article/response/article_model.dart';

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
    @Query('account') int? account,

    @Query('board') int? board,
    @Query('size') int? size,
    @Query('matchType') String? matchType,

    // @Query('orderBy') String? orderBy
  });

  @POST("/article")
  Future<ArticleModel> postArticle(
    @Body() ArticleRequestDto data,
  );

  @GET("/article/random")
  Future<List<ArticleModel>> getArticleRandom();

  @GET("/article/count")
  Future<int> getArticleCount({
    @Query('title') String? title,
    @Query('content') String? content,
    @Query('accountName') String? accountName,
    @Query('gradeName') String? gradeName,
    @Query('board') int? board,
    @Query('or') bool? or,
  });

  @DELETE('/article/{id}')
  Future deleteArticle(
    @Path("id") int? id,
  );
}
