import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/data/model/article_model.dart';
import 'package:rotary_flutter/data/remoteData/article_remote_data.dart';
import 'package:rotary_flutter/data/remoteData/file_remote_data.dart';

import '../../../../util/model/loadstate.dart';
import 'dart:math';

final AdvertiseProvider =
    ChangeNotifierProvider.autoDispose<AdvertiseViewModel>((ref) {
  return AdvertiseViewModel();
});

class AdvertiseViewModel with ChangeNotifier {
  LoadState advertiseState = Loading();

  List<int> banners = [];

  Future<int?> getAdvertiseFile(int? fileApiPK) async {
    var data = await FileAPI().getAdvertiseFile(fileApiPK);
    return data?.id;
  }

  Future<LoadState> getAdvertiseAll({int? page, String? query}) async {
    var temp = await ArticleAPI().getAdvertiseAll(
        page: page,
        title: query,
        content: query,
        accountName: query,
        or: true,
        gradeName: query);

    if (temp == null) {
      advertiseState = Error('exception');
      notifyListeners();
      return advertiseState;
    } else {
      // 본문과 썸네일 리스트 분리
      final List<ArticleModel> advertiseData = temp;

      // 결과를 상태로 설정
      advertiseState = Success(advertiseData);
      banners = advertiseData.map((value) => value.id ?? 0).toList();
      notifyListeners();

      return advertiseState;
    }
  }

  Future<int?> getAdvertiseAllCount({String? query}) async {
    return await ArticleAPI().getAdvertiseCount(
        title: query,
        content: query,
        accountName: query,
        or: true,
        gradeName: query);
  }
}
