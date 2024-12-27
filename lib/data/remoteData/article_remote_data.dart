import 'package:rotary_flutter/data/repostitory/account_repository.dart';
import 'package:dio/dio.dart';
import 'package:rotary_flutter/data/repostitory/article_repository.dart';
import '../../util/model/state.dart';
import '../../util/common/common.dart';
import '../model/account_model.dart';

class ArticleAPI {
  String serverUrl = "${BASE_URL}";
  Dio dio = Dio()
    ..options.connectTimeout = const Duration(seconds: 60)
    ..options.receiveTimeout = const Duration(seconds: 60)
    ..options.headers['Content-Type'] = 'application/json'
    ..options.headers['accept-Type'] = 'application/json'
    ..options.headers['Authorization'] = 'Bearer showmethemoney';

  late ArticleRepository articledRepository;

  ArticleAPI() {
    // dio.interceptors.add(LogInterceptor(
    //   request: true, // 요청 데이터 로깅
    //   requestHeader: true, // 요청 헤더 로깅
    //   requestBody: true, // 요청 바디 로깅
    //   responseHeader: true, // 응답 헤더 로깅
    //   responseBody: true, // 응답 바디 로깅
    //   error: true, // 에러 로깅
    // ));
    articledRepository = ArticleRepository(dio, baseUrl: serverUrl);
  }

  Future<LoadState> getArticle({int? id}) async {
    try {
      final result = await articledRepository.getArticle(id);
      return Success(result);
    } catch (e) {
      return Error(e);
    }
  }
}