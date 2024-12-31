import 'package:json_annotation/json_annotation.dart';

part 'event_model.g.dart';

@JsonSerializable()
class EventModel {
  int? id;
  Calendar? calendar;
  String? time;
  String? title;
  String? content;

  EventModel({this.id, this.calendar, this.time, this.title, this.content});

  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    calendar = json['calendar'] != null
        ? new Calendar.fromJson(json['calendar'])
        : null;
    time = json['time'];
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.calendar != null) {
      data['calendar'] = this.calendar!.toJson();
    }
    data['time'] = this.time;
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}

class Calendar {
  int? id;
  String? name;

  Calendar({this.id, this.name});

  Calendar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
