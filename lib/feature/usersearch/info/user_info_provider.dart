import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/remoteData/account_remote_data.dart';
import '../../../util/model/loadstate.dart';

final UserInfoProvider = ChangeNotifierProvider.autoDispose<UserInfoViewModel>((ref) {
  return UserInfoViewModel();
});

class UserInfoViewModel with ChangeNotifier {
  LoadState userInfoState = Loading();

  Future getUserInfo(int id) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      userInfoState = Loading();
      notifyListeners();

      userInfoState = await AccountAPI().getAccount(id: id);
      notifyListeners();
    });
  }
}