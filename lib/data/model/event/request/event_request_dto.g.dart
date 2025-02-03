// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventRequestDto _$EventRequestDtoFromJson(Map<String, dynamic> json) =>
    EventRequestDto(
      calendar: (json['calendar'] as num?)?.toInt(),
      time: json['time'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$EventRequestDtoToJson(EventRequestDto instance) =>
    <String, dynamic>{
      'calendar': instance.calendar,
      'time': instance.time,
      'title': instance.title,
      'content': instance.content,
    };
