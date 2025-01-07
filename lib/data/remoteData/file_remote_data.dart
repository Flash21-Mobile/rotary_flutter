
import 'package:dio/dio.dart';

import '../../util/common/common.dart';
import '../../util/model/loadstate.dart';
import '../model/file_model.dart';
import '../repostitory/event_repository.dart';
import '../repostitory/file_repository.dart';

class FileAPI {
  String serverUrl = "${BASE_URL}";
  Dio dio = Dio()
    ..options.connectTimeout = const Duration(seconds: 60)
    ..options.receiveTimeout = const Duration(seconds: 60)
    ..options.headers['Content-Type'] = 'application/json'
    ..options.headers['accept-Type'] = 'application/json'
    ..options.headers['cheat'] = 'showmethemoney';

  late FileRepository repository;

  FileAPI() {
    // dio.interceptors.add(LogInterceptor(
        // request: true, // 요청 데이터 로깅
        // requestHeader: true, // 요청 헤더 로깅
        // requestBody: true, // 요청 바디 로깅
        // responseHeader: true, // 응답 헤더 로깅
        // responseBody: true, // 응답 바디 로깅
        // error: true, // 에러 로깅
        // ));
    repository = FileRepository(dio, baseUrl: serverUrl);
  }

  Future<FileModel?> getAccountFile(int? fileApiPK) async {
    try {
      final result = await repository.getFile('account', fileApiPK);
      return result?.first;
    } catch (e) {
      return null;
    }
  }
}
