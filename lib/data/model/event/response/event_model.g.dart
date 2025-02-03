// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) => EventModel(
      id: (json['id'] as num?)?.toInt(),
      calendar: json['calendar'] == null
          ? null
          : CalendarModel.fromJson(json['calendar'] as Map<String, dynamic>),
      time: json['time'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'calendar': instance.calendar,
      'time': instance.time,
      'title': instance.title,
      'content': instance.content,
    };

CalendarModel _$CalendarModelFromJson(Map<String, dynamic> json) =>
    CalendarModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CalendarModelToJson(CalendarModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
