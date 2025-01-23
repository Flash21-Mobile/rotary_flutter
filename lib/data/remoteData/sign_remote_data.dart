import 'package:dio/dio.dart';
import 'package:rotary_flutter/data/model/sign_model.dart';
import 'package:rotary_flutter/data/model/token.dart';
import 'package:rotary_flutter/util/model/loadstate.dart';

import '../../util/common/common.dart';
import '../../util/logger.dart';
import '../../util/secure_storage.dart';
import '../repostitory/file_repository.dart';
import '../repostitory/sign_repository.dart';

class SignAPI {
  String serverUrl = BASE_HEADER;
  Dio dio = Dio()
    ..options.connectTimeout = const Duration(seconds: 60)
    ..options.receiveTimeout = const Duration(seconds: 60)
    ..options.headers['Content-Type'] = 'application/json'
    ..options.headers['accept-Type'] = 'application/json'
    ..options.headers['cheat'] = 'showmethemoney';


  late SignRepository repository;

  SignAPI() {
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
    repository = SignRepository(dio, baseUrl: serverUrl);
  }

  Future setUpToken() async {
    var token = await globalStorage.read(key: 'token');
    dio.options.headers['Authorization'] = 'bearer $token';
  }

  Future<LoadState<TokenModel>> signIn({String? cellphone, String? name}) async {
    await setUpToken();
    try {
      var response = await repository.signIn(SignModel(cellphone: cellphone, name: name));
      return Success(response);
    } on DioException catch (e) {
      return Error(e);
    }
  }


}
