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
  LoadState accountState = Loading();

  Future getMyAccount() async {
    var cellphone = await globalStorage.read(key: 'phone');

    accountState = await AccountAPI().getAccount(cellphone: cellphone);
    notifyListeners();
  }
}
