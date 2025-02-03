import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:rotary_flutter/data/model/event/request/event_request_dto.dart';

import '../model/event/response/event_model.dart';

part 'event_repository.g.dart';

@RestApi()
abstract class EventRepository {
  factory EventRepository(Dio dio, {String baseUrl}) = _EventRepository;

  @GET("/schedule")
  Future<List<EventModel>> getEvent();

  @POST("/schedule")
  Future postEvent(@Body() EventRequestDto data);

  @DELETE("/schedule/{id}")
  Future deleteEvent(@Path("id") int id);
}
//todo r: 사진 추가
//todo r: 날짜 기간 추가