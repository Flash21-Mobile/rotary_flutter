import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/data/model/article_model.dart';
import 'package:rotary_flutter/data/remoteData/article_remote_data.dart';
import 'package:rotary_flutter/data/remoteData/file_remote_data.dart';
import 'package:rotary_flutter/util/logger.dart';

import '../../../data/remoteData/account_remote_data.dart';
import '../../../util/model/loadstate.dart';

final UserSearchListProvider =
    ChangeNotifierProvider<UserSearchListViewModel>((ref) {
  return UserSearchListViewModel();
});

class UserSearchListViewModel with ChangeNotifier {
  LoadState userListState = End();

  set setUserListState(LoadState state) {
    userListState = state;
    notifyListeners();
  }

  Future<LoadState> getAccountList(
      {String? grade, String? region, int? page, String? name}) async {
    userListState = Loading();
    notifyListeners();

    userListState = await AccountAPI()
        .getAccount(grade: grade, region: region, page: page, name: name);
    notifyListeners();

    return userListState;
  }

  Future<int?> getAccountListCount(
      {String? grade, String? region, String? name}) async {
    return await AccountAPI()
        .getAccountCount(name: name, grade: grade, region: region);
  }

  Future<int?> getAccountFile(int? fileApiPK) async {
    var data = await FileAPI().getAccountFile(fileApiPK);
    return data?.id;
  }

  LoadState<List<ArticleModel>?> accountAdvertiseState = End();

  Future getArticleByAccount(int? id) async {
    accountAdvertiseState = Loading();
    notifyListeners();

    var result = await ArticleAPI().getAdvertiseAll(account: id);
    if (result == null || result.isEmpty) {
      accountAdvertiseState = Success([]);
    } else {
      accountAdvertiseState = Success(result);
    }
    notifyListeners();
  }
}
