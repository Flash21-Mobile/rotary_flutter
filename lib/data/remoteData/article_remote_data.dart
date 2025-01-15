import 'package:rotary_flutter/data/model/article_model.dart';
import 'package:rotary_flutter/data/repostitory/account_repository.dart';
import 'package:dio/dio.dart';
import '../../util/model/loadstate.dart';
import '../../util/common/common.dart';
import '../model/account_model.dart';
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
    // dio.interceptors.add(LogInterceptor(
    // request: true,
    // // 요청 데이터 로깅
    // requestHeader: true,
    // // 요청 헤더 로깅
    // requestBody: true,
    // // 요청 바디 로깅
    // responseHeader: true,
    // // 응답 헤더 로깅
    // responseBody: true,
    // // 응답 바디 로깅
    // error: true, // 에러 로깅
    // ));
    repository = ArticleRepository(dio, baseUrl: serverUrl);
  }

  Future<List<ArticleModel>?> getAdvertiseAll(
      {int? page,
      String? title,
      String? content,
      String? accountName,
      String? gradeName}) async {
    try {
      final result = await repository.getArticle(
          board: 1,
          page: page,
          size: 10,
          title: title,
          content: content,
          accountName: accountName,
          gradeName: gradeName,
          or: true);
      return result;
    } catch (e) {
      return null;
    }
  }

  Future<List<ArticleModel>?> getAdvertiseRandom() async {
    try {
      final result = await repository.getArticleRandom();
      return result;
    } catch (e) {
      return null;
    }
  }

  Future<int?> getAdvertiseCount() async {
    try {
      final result = await repository.getArticleCount();
      return result;
    } catch (e) {
      return null;
    }
  }

  Future<List<ArticleModel>?> getMonthlyLetterAll(
      int? page, String? title, String? content) async {
    try {
      final result = await repository.getArticle(
          board: 3, page: page, size: 10, title: title, content: content, or: true);
      return result;
    } catch (e) {
      return null;
    }
  }

  Future<LoadState> postMonthlyLetterAll(Account account, String? file) async {
    try {
      final data = await repository.postArticle(ArticleModel(
          id: 1,
          account: account,
          board: Board(id: 3, name: 'monthlyletter'),
          title: file?.split('/').last.replaceAll('.pdf', ''),
          content: formatDataToDTO()));

      return Success(data);
    } on DioException catch (e) {
      return Error(e);
    }
  }

  String formatDataToDTO() {
    DateTime now = DateTime.now();
    return now.toIso8601String();
  }

  Future<LoadState> deleteMonthlyLetter(int? id) async {
    try {
      repository.deleteArticle(id);
      return Success('success');
    } on DioException catch (e) {
      return Error(e);
    }
  }
}
