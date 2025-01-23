import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/remoteData/account_remote_data.dart';
import '../../../util/model/loadstate.dart';

final UserInfoProvider = ChangeNotifierProvider.autoDispose<UserInfoViewModel>((ref) {
  return UserInfoViewModel();
});

class UserInfoViewModel with ChangeNotifier {

}