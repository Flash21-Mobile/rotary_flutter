import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/data/remoteData/file_remote_data.dart';
import 'package:rotary_flutter/util/logger.dart';

import '../../../data/remoteData/account_remote_data.dart';
import '../../../util/model/loadstate.dart';

final UserSearchListProvider =
    ChangeNotifierProvider.autoDispose<UserSearchListViewModel>((ref) {
  return UserSearchListViewModel();
});

class UserSearchListViewModel with ChangeNotifier {
  LoadState userListState = Loading();

  Future<LoadState> getAccountList({String? grade, String? region, int? page, String? name}) async {
    userListState = Loading();
    notifyListeners();

    userListState = await AccountAPI()
        .getAccount(grade: grade, region: region, page: page, name: name);
    notifyListeners();

    return userListState;
  }

  Future<int?> getAccountFile(int? fileApiPK) async {
    var data = await FileAPI().getAccountFile(fileApiPK);
    return data?.id;
  }
}
