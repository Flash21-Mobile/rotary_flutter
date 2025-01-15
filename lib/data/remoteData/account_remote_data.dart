import 'package:rotary_flutter/data/repostitory/account_repository.dart';
import 'package:dio/dio.dart';
import '../../util/model/loadstate.dart';
import '../../util/common/common.dart';
import '../model/account_model.dart';

class AccountAPI {
  String serverUrl = "${BASE_URL}";
  Dio dio = Dio()
    ..options.connectTimeout = const Duration(seconds: 60)
    ..options.receiveTimeout = const Duration(seconds: 60)
    ..options.headers['Content-Type'] = 'application/json'
    ..options.headers['accept-Type'] = 'application/json'
    ..options.headers['cheat'] = 'showmethemoney';

  late AccountRepository accountRepository;

  AccountAPI() {
    // dio.interceptors.add(LogInterceptor(
    //   request: true, // 요청 데이터 로깅
    //   requestHeader: true, // 요청 헤더 로깅
    //   requestBody: true, // 요청 바디 로깅
    //   responseHeader: true, // 응답 헤더 로깅
    //   responseBody: true, // 응답 바디 로깅
    //   error: true, // 에러 로깅
    // ));
    accountRepository = AccountRepository(dio, baseUrl: serverUrl);
  }

  Future<LoadState> getAccount({
    String? cellphone,
    int? id,
    String? name,
    String? grade,
    String? region,
    int? page,
  }) async {
    try {
      final result = await accountRepository.getAccount(cellphone, id, name, grade, region, page, 20);
      print('success: $result');

      return Success(result);
    } catch (e) {
      print('getAccount error: $e');
      return Error(e);
    }
  }

  Future<LoadState> putAccount(Account account) async {
    try {
      final result = await accountRepository.putAccount(account.id??0, account);
      print('success: $result');
      return Success(result);
    } catch (e) {
      print('getAccount error: $e');
      return Error(e);
    }
  }
}