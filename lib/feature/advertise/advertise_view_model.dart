import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/data/model/advertise_model.dart';
import 'package:rotary_flutter/data/remoteData/article_remote_data.dart';

import '../../../../util/model/loadstate.dart';

final AdvertiseProvider = ChangeNotifierProvider.autoDispose<AdvertiseViewModel>((ref) {
  return AdvertiseViewModel();
});

class AdvertiseViewModel with ChangeNotifier {
  LoadState advertiseState = Loading();

  void getAdvertiseAll()async {
    advertiseState = await AdvertiseAPI().getAdvertiseAll();
    notifyListeners();
  }
}