import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rotary_flutter/data/remoteData/account_remote_data.dart';
import 'package:rotary_flutter/util/secure_storage.dart';

import '../../util/model/loadstate.dart';

final MyInfoProvider =
    ChangeNotifierProvider.autoDispose<_ViewModel>((ref) {
  return _ViewModel();
});

class _ViewModel with ChangeNotifier {
  LoadState _accountState = Loading();
  LoadState get accountState => _accountState;
  set accountState(LoadState state) {
    _accountState = state;
    notifyListeners();
  }

  Future getMyAccount() async {
    var cellphone = await globalStorage.read(key: 'phone');

    _accountState = await AccountAPI().getAccount(cellphone: cellphone, size: 1, matchType: 'andEquals');
    notifyListeners();
  }
}
