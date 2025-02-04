import 'package:rotary_flutter/data/interceptor/zstd_interceptor.dart';
import 'package:rotary_flutter/data/model/account/request/account_request_dto.dart';
import 'package:rotary_flutter/data/repostitory/account_repository.dart';
import 'package:dio/dio.dart';
import 'package:rotary_flutter/util/logger.dart';
import 'package:rotary_flutter/util/secure_storage.dart';
import '../../util/model/loadstate.dart';
import '../../util/common/common.dart';
import '../../util/model/pair.dart';
import '../model/account/response/account_model.dart';

class AccountAPI {
  String serverUrl = "${BASE_URL}";
  Dio dio = Dio()
    ..options.connectTimeout = const Duration(seconds: 60)
    ..options.receiveTimeout = const Duration(seconds: 60)
    ..options.headers['Content-Type'] = 'application/json'
    ..options.headers['Accept-Encoding'] = 'zstd'
    ..options.responseType = ResponseType.bytes
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
    dio.interceptors.add(ZstdInterceptor());
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
          cellphone: cellphone, size: size ?? 10000, matchType: matchType);
      return Success(result);
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
      return result.first.name == name
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
      AccountRequestModel accountRequestModel = AccountRequestModel(
        active: account.active,
        android: account.android,
        birthDate: account.birthDate,
        cellphone: account.cellphone,
        clubRi: account.clubRi,
        email: account.email,
        englishName: account.englishName,
        faxNumber: account.faxNumber,
        fifthGrade: account.fifthGrade?.id,
        firstGrade: account.firstGrade?.id,
        fourthGrade: account.fourthGrade?.id,
        grade: account.grade?.id,
        graduationYear: account.graduationYear,
        homeAddress: account.homeAddress,
        homeAddressSub: account.homeAddressSub,
        homeAddressZipCode: account.homeAddressZipCode,
        ios: account.ios,
        job: account.job,
        memberRi: account.memberRi,
        memo: account.memo,
        name: account.name,
        nickname: account.nickname,
        permission : account.permission,
        secondGrade: account.secondGrade?.id,
        signupYear: account.signupYear,
        telephone: account.telephone,
        thirdGrade:account.thirdGrade?.id,
        time: account.time,
        userId: account.userId,
        userPassword: account.userPassword,
        workAddress: account.workAddress,
        workAddressSub: account.workAddressSub,
        workAddressZipCode: account.workAddressZipCode,
        workName: account.workName,
        workPositionName: account.workPositionName,
      );

      final result =
      await accountRepository.putAccount(account.id ?? 0, accountRequestModel);
      print('success: $result');
      return Success(result);
    } catch (e) {
      print('getAccount error: $e');
      return Error(e);
    }
  }
}
