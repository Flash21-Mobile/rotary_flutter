import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/data/remoteData/account_remote_data.dart';
import 'package:rotary_flutter/data/model/account_model.dart';

final MyInfoModifyProvider = ChangeNotifierProvider.autoDispose<MyInfoModifyViewModel>((ref) {
  return MyInfoModifyViewModel();
});

class MyInfoModifyViewModel with ChangeNotifier {

}