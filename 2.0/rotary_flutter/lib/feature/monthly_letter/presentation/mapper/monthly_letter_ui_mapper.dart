import 'package:function_system/domain/aricle/entity/article/article_entity.dart';

import '../model/monthly_letter/monthly_letter_ui_model.dart';

class MonthlyLetterUiMapper {
  static MonthlyLetterUiModel toThumb(ArticleEntity entity) {
    return MonthlyLetterUiModel(
      id: entity.id,
      title: entity.title,
      date: entity.time,
    );
  }
}