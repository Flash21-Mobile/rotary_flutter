import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/remoteData/account_remote_data.dart';
import '../../../util/model/loadstate.dart';

final UserSearchListProvider = ChangeNotifierProvider.autoDispose<UserSearchListViewModel>((ref) {
  return UserSearchListViewModel();
});

class UserSearchListViewModel with ChangeNotifier {
  LoadState userListState = Loading();

  Future getAccountList({int? cardinal, int? groupCardinal}) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      userListState = Loading();
      notifyListeners();

      userListState = await AccountAPI().getAccount(cardinal: cardinal, groupCardinal: groupCardinal);
      notifyListeners();
    });
  }
}