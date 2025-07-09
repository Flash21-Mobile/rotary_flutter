import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:function_system/domain/aricle/entity/article/article_entity.dart';

part 'account_detail_ui_model.freezed.dart';

@freezed
abstract class AccountDetailUiModel with _$AccountDetailUiModel {
  const factory AccountDetailUiModel({
    required int id,
    required String name,
    required String grade,
    required String nickname,
    required String secondGrade,
    required DateTime? time,
    required bool isFavorite,

    required String workName,
    required String workPositionName,
    required String telephone,
    required String faxNumber,
    required String workAddress,
    required String workAddressSub,
    required String email,
    required List<ArticleEntity> advertises
  }) = _AccountDetailUiModel;
}
