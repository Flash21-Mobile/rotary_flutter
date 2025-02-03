import 'package:json_annotation/json_annotation.dart';

part 'article_request_dto.g.dart';

@JsonSerializable()
class ArticleRequestDto {
  int? account;
  int? board;
  String? content;
  String? time;
  String? title;

  ArticleRequestDto(
      {this.account, this.board, this.content, this.time, this.title});

  factory ArticleRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ArticleRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleRequestDtoToJson(this);
}
