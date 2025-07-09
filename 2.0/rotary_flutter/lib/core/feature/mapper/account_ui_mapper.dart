import 'package:function_system/domain/account/entity/account/account_entity.dart';
import 'package:function_system/domain/aricle/entity/article/article_entity.dart';

import '../model/account_detail/account_thumb_ui_model.dart';
import '../model/account_search/account_search_ui_model.dart';
import '../model/account_thumb/account_detail_ui_model.dart';


class AccountUiMapper {
  static AccountThumbUiModel toThumb(AccountEntity entity) {
    return AccountThumbUiModel(
      id: entity.id,
      name: entity.name,
      grade: entity.grade?.name ?? '',
      nickname: entity.nickname,
      firstGrade: entity.firstGrade?.name ?? '',
      secondGrade: entity.secondGrade?.name ?? '',
      time: entity.time,
      isFavorite: entity.isFavorite,
    );
  }

  static AccountDetailUiModel toDetail(AccountEntity entity, List<ArticleEntity> advertises) {
    return AccountDetailUiModel(
      id: entity.id,
      name: entity.name,
      grade: entity.grade?.name ?? '',
      nickname: entity.nickname,
      secondGrade: entity.secondGrade?.name ?? '',
      time: entity.time,
      workName: entity.workName,
      workPositionName: entity.workPositionName,
      telephone: entity.telephone,
      faxNumber: entity.faxNumber,
      workAddress: entity.workAddress,
      workAddressSub: entity.workAddressSub,
      email: entity.email,
      isFavorite: entity.isFavorite,
      advertises: advertises
    );
  }

  static AccountSearchUiModel toSearchFromThumb(AccountThumbUiModel entity) {
    return AccountSearchUiModel(
      id: entity.id,
      name: entity.name,
      grade: entity.grade,
      contents: [entity.nickname, entity.firstGrade, entity.secondGrade],
    );
  }
}
