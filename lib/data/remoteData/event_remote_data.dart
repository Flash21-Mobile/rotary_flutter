import 'package:dio/dio.dart';
import 'package:rotary_flutter/data/model/event_model.dart';
import 'package:rotary_flutter/util/logger.dart';

import '../../util/common/common.dart';
import '../../util/model/loadstate.dart';
import '../../util/secure_storage.dart';
import '../interceptor/zstd_interceptor.dart';
import '../repostitory/event_repository.dart';

class EventAPI {
  String serverUrl = "${BASE_URL}";
  Dio dio = Dio()
    ..options.connectTimeout = const Duration(seconds: 60)
    ..options.receiveTimeout = const Duration(seconds: 60)
    ..options.headers['Content-Type'] = 'application/json'
    ..options.headers['accept-Type'] = 'application/json'
    ..options.headers['cheat'] = 'showmethemoney';

  late EventRepository repository;

  EventAPI() {
    // dio.interceptors.add(LogInterceptor(
    //   request: true, // 요청 데이터 로깅
    //   requestHeader: true, // 요청 헤더 로깅
    //   requestBody: true, // 요청 바디 로깅
    //   responseHeader: true, // 응답 헤더 로깅
    //   responseBody: true, // 응답 바디 로깅
    //   error: true, // 에러 로깅
    // ));
    repository = EventRepository(dio, baseUrl: serverUrl);
  }

  Future setUpToken() async {
    var token = await globalStorage.read(key: 'token');
    dio.options.headers['Authorization'] = 'bearer $token';
  }

  Future<LoadState> getEvent() async {
    await setUpToken();
    try {
      final result = await repository.getEvent();
      return Success(result);
    } catch (e) {
      List<EventModel> data = [];
      return Success(data);
    }
  }

  Future<LoadState> postEvent(String title, String content, String date) async {
    await setUpToken();
    try {
      final result = await repository.postEvent(
        EventModel(
          id: null,
          calendar: Calendar(
            id: 1,
            name: 'event'
          ),
          time: date,
          title: title,
          content: content
        )
      );
      return Success(result);
    } catch (e) {
      return Error(e);
    }
  }

  Future<LoadState> deleteEvent(int id) async {
    await setUpToken();
    try {
      await repository.deleteEvent(id);
      return Success('success');
    } catch (e) {
      return Error(e);
    }
  }
}