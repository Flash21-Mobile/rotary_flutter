import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../model/event_model.dart';

part 'event_repository.g.dart';

@RestApi()
abstract class EventRepository {
  factory EventRepository(Dio dio, {String baseUrl}) = _EventRepository;

  @GET("/schedule")
  Future<List<EventModel>> getEvent();
}