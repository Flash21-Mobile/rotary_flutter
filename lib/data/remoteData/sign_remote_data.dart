import 'package:dio/dio.dart';
import 'package:rotary_flutter/data/model/sign_verify_model.dart';
import 'package:rotary_flutter/util/model/loadstate.dart';

import '../../util/common/common.dart';
import '../../util/logger.dart';
import '../repostitory/file_repository.dart';
import '../repostitory/sign_repository.dart';

class SignAPI {
  String serverUrl = "${BASE_URL}";
  Dio dio = Dio()
    ..options.connectTimeout = const Duration(seconds: 60)
    ..options.receiveTimeout = const Duration(seconds: 60)
    ..options.headers['Content-Type'] = 'application/json'
    ..options.headers['accept-Type'] = 'application/json'
    ..options.headers['cheat'] = 'showmethemoney';

  late SignRepository repository;

  SignAPI() {
    // dio.interceptors.add(LogInterceptor(
    // request: true, // 요청 데이터 로깅
    // requestHeader: true, // 요청 헤더 로깅
    // requestBody: true, // 요청 바디 로깅
    // responseHeader: true, // 응답 헤더 로깅
    // responseBody: true, // 응답 바디 로깅
    // error: true, // 에러 로깅
    // ));
    repository = SignRepository(dio, baseUrl: serverUrl);
  }

  Future<LoadState> postSMS(String? cellphone) async {
    try {
      repository.postSMS(cellphone);

      return Success("success");  //todo r: 수정
    } on DioException catch (e) {
      Log.e('error post');
      return Error(e);
    }
  }

  Future<LoadState> postSMSVerify(String cellphone, String code) async {
    try {
      repository.postSMSVerify(SignVerifyModel(phone: cellphone, code: code));
      return Success('success');
    } on DioException catch (e) {
      return Error(e);
    }
  }
}
