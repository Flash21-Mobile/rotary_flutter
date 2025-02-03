import 'package:json_annotation/json_annotation.dart';

part 'event_model.g.dart';

@JsonSerializable()
class EventModel {
  int? id;
  CalendarModel? calendar;
  String? time;
  String? title;
  String? content;

  EventModel({this.id, this.calendar, this.time, this.title, this.content});

  factory EventModel.fromJson(Map<String, dynamic> json) => _$EventModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventModelToJson(this);
}

@JsonSerializable()
class CalendarModel {
  int? id;
  String? name;

  CalendarModel({this.id, this.name});

  factory CalendarModel.fromJson(Map<String, dynamic> json) =>_$CalendarModelFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarModelToJson(this);
}
