import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/data/model/advertise_model.dart';
import 'package:rotary_flutter/data/remoteData/advertise_remote_data.dart';
import 'package:rotary_flutter/data/remoteData/file_remote_data.dart';

import '../../../../util/model/loadstate.dart';
import 'dart:math';

final AdvertiseProvider =
    ChangeNotifierProvider.autoDispose<AdvertiseViewModel>((ref) {
  return AdvertiseViewModel();
});

class AdvertiseViewModel with ChangeNotifier {
  LoadState advertiseState = Loading();

  List<int> banners = [];

  Future<int?> getAdvertiseFile(int? fileApiPK) async {
    var data = await FileAPI().getAdvertiseFile(fileApiPK);
    return data?.id;
  }

  Future<LoadState> getAdvertiseAll({int? page, String? title}) async {
    var temp = await AdvertiseAPI().getAdvertiseAll(page, title);

    if (temp == null) {
      advertiseState = Error('exception');
      notifyListeners();
      return advertiseState;
    } else {
      // 본문과 썸네일 리스트 분리
      final List<AdvertiseModel> advertiseData = temp;

      // 결과를 상태로 설정
      advertiseState = Success(advertiseData);
      banners = advertiseData.map((value)=>value.id??0).toList();
      notifyListeners();

      return advertiseState;
    }
  }
}