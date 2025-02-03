import 'package:rotary_flutter/data/model/article/request/article_request_dto.dart';
import 'package:rotary_flutter/data/model/article/response/article_model.dart';
import 'package:rotary_flutter/data/repostitory/account_repository.dart';
import 'package:dio/dio.dart';
import 'package:rotary_flutter/util/logger.dart';
import '../../util/model/loadstate.dart';
import '../../util/common/common.dart';
import '../../util/secure_storage.dart';
import '../interceptor/zstd_interceptor.dart';
import '../model/account/response/account_model.dart';
import '../repostitory/article_repository.dart';

class ArticleAPI {
  String serverUrl = "${BASE_URL}";
  Dio dio = Dio()
    ..options.connectTimeout = const Duration(seconds: 60)
    ..options.receiveTimeout = const Duration(seconds: 60)
    ..options.headers['Content-Type'] = 'application/json'
    ..options.headers['accept-Type'] = 'application/json'
    ..options.headers['cheat'] = 'showmethemoney';

  late ArticleRepository repository;

  ArticleAPI() {
    dio.interceptors.add(LogInterceptor(
      request: true,
      // 요청 데이터 로깅
      requestHeader: true,
      // 요청 헤더 로깅
      requestBody: true,
      // 요청 바디 로깅
      responseHeader: true,
      // 응답 헤더 로깅
      responseBody: true,
      // 응답 바디 로깅
      error: true, // 에러 로깅
    ));
    repository = ArticleRepository(dio, baseUrl: serverUrl);
  }

  Future setUpToken() async {
    var token = await globalStorage.read(key: 'token');
    dio.options.headers['Authorization'] = 'bearer $token';
  }

  Future<List<ArticleModel>?> getAdvertiseAll(
      {int? page,
      String? title,
      String? content,
      String? accountName,
      String? gradeName,
      bool? or,
      int? account}) async {
    try {
      await setUpToken();
      return await repository.getArticle(
        board: 1,
        size: 100000,
        title: title,
        content: content,
        accountName: accountName,
        gradeName: gradeName,
        account: account,
        matchType: 'orLike',
        // orderBy: 'date'
      );
    } catch (e) {
      Log.e('hello $e');
      return null;
    }
  }

  Future<List<ArticleModel>?> getAdvertiseRandom() async {
    await setUpToken();
    try {
      final result = await repository.getArticleRandom();
      return result;
    } catch (e) {
      return null;
    }
  }

  Future<int?> getAdvertiseCount(
      {String? title,
      String? content,
      String? accountName,
      String? gradeName,
      bool? or}) async {
    try {
      await setUpToken();
      final result = await repository.getArticleCount(
          board: 1,
          title: title,
          content: content,
          accountName: accountName,
          gradeName: gradeName,
          or: or);
      return result;
    } catch (e) {
      return null;
    }
  }

  Future<List<ArticleModel>?> getMonthlyLetterAll(
      String? title, String? content) async {
    await setUpToken();
    try {
      final result = await repository.getArticle(
          board: 3,
          size: 10000,
          title: title,
          content: content,
          matchType: 'orLike');
      return result;
    } catch (e) {
      return null;
    }
  }

  Future<LoadState<ArticleModel>> postMonthlyLetterAll(int? accountId, String? file) async {
    await setUpToken();
    try {
      final date = DateTime.now().toIso8601String();
      final dto = ArticleRequestDto(
        account: accountId,
        board: 3,
        title: file?.split('/').last.replaceAll('.pdf', ''),
        content: formatDataToDTO(),
        time: date
      );

      final data = await repository.postArticle(dto);

      return Success(data);
    } on DioException catch (e) {
      return Error(e);
    }
  }

  Future<int?> getMonthlyLetterCount(
      {String? title,
      String? content,
      String? accountName,
      String? gradeName,
      bool? or}) async {
    await setUpToken();
    try {
      final result = await repository.getArticleCount(
          board: 3,
          title: title,
          content: content,
          accountName: accountName,
          gradeName: gradeName,
          or: or);
      return result;
    } catch (e) {
      return null;
    }
  }

  String formatDataToDTO() {
    DateTime now = DateTime.now();
    return now.toIso8601String();
  }

  Future<LoadState> deleteMonthlyLetter(int? id) async {
    await setUpToken();
    try {
      await repository.deleteArticle(id);
      return Success('success');
    } on DioException catch (e) {
      return Error(e);
    }
  }
}
