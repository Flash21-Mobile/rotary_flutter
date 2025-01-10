import 'package:rotary_flutter/data/model/advertise_model.dart';
import 'package:rotary_flutter/data/repostitory/account_repository.dart';
import 'package:dio/dio.dart';
import 'package:rotary_flutter/data/repostitory/advertise_repository.dart';
import '../../util/model/loadstate.dart';
import '../../util/common/common.dart';
import '../model/account_model.dart';

class AdvertiseAPI {
  String serverUrl = "${BASE_URL}";
  Dio dio = Dio()
    ..options.connectTimeout = const Duration(seconds: 60)
    ..options.receiveTimeout = const Duration(seconds: 60)
    ..options.headers['Content-Type'] = 'application/json'
    ..options.headers['accept-Type'] = 'application/json'
    ..options.headers['cheat'] = 'showmethemoney';

  late AdvertiseRepository repository;

  AdvertiseAPI() {
    dio.interceptors.add(LogInterceptor(
      request: true, // 요청 데이터 로깅
      requestHeader: true, // 요청 헤더 로깅
      requestBody: true, // 요청 바디 로깅
      responseHeader: true, // 응답 헤더 로깅
      responseBody: true, // 응답 바디 로깅
      error: true, // 에러 로깅
    ));
    repository = AdvertiseRepository(dio, baseUrl: serverUrl);
  }

  Future<List<AdvertiseModel>?> getAdvertiseAll(int? page, String? title) async {
    try {
      final result = await repository.getArticle(1, page, 10, title);
      return result;
    } catch (e) {
      return null;
    }
  }

  Future<List<AdvertiseModel>?> getAdvertiseRandom() async {
    try {
      final result = await repository.getArticleRandom();
      return result;
    } catch (e) {
      return null;
    }
  }
}