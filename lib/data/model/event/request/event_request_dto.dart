import 'package:json_annotation/json_annotation.dart';

part 'event_request_dto.g.dart';

@JsonSerializable()
class EventRequestDto {
  int? calendar;
  String? time;
  String? title;
  String? content;

  EventRequestDto({this.calendar, this.time, this.title, this.content});

  factory EventRequestDto.fromJson(Map<String, dynamic> json) => _$EventRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EventRequestDtoToJson(this);
}