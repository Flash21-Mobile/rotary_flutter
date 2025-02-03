import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/data/model/article/response/article_model.dart';
import 'package:rotary_flutter/data/remoteData/article_remote_data.dart';
import 'package:rotary_flutter/data/remoteData/file_remote_data.dart';

import '../../../../util/model/loadstate.dart';
import 'dart:math';

final AdvertiseProvider =
    ChangeNotifierProvider.autoDispose<AdvertiseViewModel>((ref) {
  return AdvertiseViewModel();
});

class AdvertiseViewModel with ChangeNotifier {
  LoadState advertiseState = End();

  Future<int?> getAdvertiseFile(int? fileApiPK) async {
    var data = await FileAPI().getAdvertiseFile(fileApiPK);
    return data?.id;
  }

  Future getAdvertiseAll({int? page, String? query}) async {
    advertiseState = Loading();
    notifyListeners();

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
    } else {
      final List<ArticleModel> advertiseData = temp;

      // 결과를 상태로 설정
      advertiseState = Success(advertiseData);
      allAdvertiseList = advertiseData;
      notifyListeners();
      sortData();
    }
  }

  List<ArticleModel> allAdvertiseList = [];
  List<ArticleModel> _advertiseList = [];

  List<ArticleModel> get advertiseList => _advertiseList;

  set advertiseList(List<ArticleModel> data) {
    _advertiseList = data;
    notifyListeners();
  }

  void sortData({String? query}) async {
    var temp = allAdvertiseList;
    advertiseState = Loading();
    notifyListeners();
    if (advertiseList.isNotEmpty) advertiseList = [];

    await Future.delayed(Duration(milliseconds: 100));

    if (query != null) {
      temp = temp.where((value) {
        return (value.title?.contains(query) ?? false) || // title에 query 포함 여부
            (value.content?.contains(query) ?? false) || // content에 query 포함 여부
            (value.account?.name?.contains(query) ?? false) ||
            (value.account?.grade?.name?.contains(query) ??
                false); // name에 query 포함 여부
      }).toList();
    }

    advertiseCount = temp.length;
    advertiseList = temp;
    advertiseState = Success([]);
    notifyListeners();
  }

  String query = '';

  int? advertiseCount = 0;
}
