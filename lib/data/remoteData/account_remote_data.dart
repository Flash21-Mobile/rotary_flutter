import 'package:rotary_flutter/data/interceptor/zstd_interceptor.dart';
import 'package:rotary_flutter/data/repostitory/account_repository.dart';
import 'package:dio/dio.dart';
import 'package:rotary_flutter/util/logger.dart';
import 'package:rotary_flutter/util/secure_storage.dart';
import '../../util/model/loadstate.dart';
import '../../util/common/common.dart';
import '../../util/model/pair.dart';
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
    accountRepository = AccountRepository(dio, baseUrl: serverUrl);
  }

  Future setUpToken() async {
    var token = await globalStorage.read(key: 'token');
    dio.options.headers['Authorization'] = 'bearer $token';
  }

  Future<LoadState<List<Account>>> getAccount(
      {String? cellphone, int? size, String? matchType}) async {
    await setUpToken();
    try {
      final result = await accountRepository.getAccount(
          cellphone: cellphone, size: size ?? 10000,matchType: matchType);
      return Success(result.data);
    } on DioException catch (e) {
      Log.d('Hellloioio $e');
      return Error(e);
    }
  }

  Future<LoadState<bool>> postIOSLogin(String cellphone, String name) async {
    await setUpToken();
    try {
      final result = await accountRepository.getAccount(cellphone: cellphone);
      Log.d('hello getAccount success');
      return result.data.first.name == name
          ? Success(true)
          : Error(DioException);
    } on DioException catch (e) {
      Log.e('hello getAccount error: $e');
      return Error(e);
    }
  }

  Future<int?> getAccountCount({
    String? name,
    String? grade,
    String? region,
  }) async {
    await setUpToken();
    try {
      return 0;
    } catch (e) {
      Log.d('$e');
      return null;
    }
  }

  Future<LoadState> putAccount(Account account) async {
    await setUpToken();
    try {
      final result =
          await accountRepository.putAccount(account.id ?? 0, account);
      print('success: $result');
      return Success(result);
    } catch (e) {
      print('getAccount error: $e');
      return Error(e);
    }
  }
}
