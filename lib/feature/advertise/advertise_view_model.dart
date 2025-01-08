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

  List<List<String>?> banners = [];

  Future getAdvertiseAll() async {
    var temp = await AdvertiseAPI().getAdvertiseAll();

    if (temp == null) {
      advertiseState = Error('exception');
      notifyListeners();
      return;
    } else {
      // 본문과 썸네일 리스트 분리
      final List<List<String>> advertiseData = temp.expand((value) {
        final contentList =
            value.content?.replaceAll('content:', '').split(',') ?? [];
        if (contentList.isNotEmpty) {
          final mainImage = contentList.first; // 본문 사진
          final thumbnails = contentList.sublist(1); // 썸네일 사진들

          // 본문과 각 썸네일을 매핑하여 새로운 리스트 생성
          return thumbnails.map((thumbnail) => [mainImage, thumbnail]).toList();
        }
        return <List<String>>[]; // 빈 리스트 반환
      }).toList();

      // 결과를 상태로 설정
      advertiseState = Success(advertiseData);
      banners = advertiseData;
      notifyListeners();
    }
  }

  Future getAdvertiseRandom() async {
    var temp = await AdvertiseAPI().getAdvertiseAll();

    if (temp == null) {
      advertiseState = Error('exception');
      notifyListeners();
      return;
    } else {
      // 본문과 썸네일 리스트 분리
      final List<List<String>> advertiseData = temp.expand((value) {
        final contentList =
            value.content?.replaceAll('content:', '').split(',') ?? [];
        if (contentList.isNotEmpty) {
          final mainImage = contentList.first; // 본문 사진
          final thumbnails = contentList.sublist(1); // 썸네일 사진들

          // 본문과 각 썸네일을 매핑하여 새로운 리스트 생성
          return thumbnails.map((thumbnail) => [mainImage, thumbnail]).toList();
        }
        return <List<String>>[]; // 빈 리스트 반환
      }).toList();


      // 랜덤으로 5개의 항목 선택
      final random = Random();
      const int itemsToSelect = 5;
      final randomAdvertiseData = (advertiseData.toList()..shuffle(random))
          .take(itemsToSelect)
          .toList();

      advertiseState = Success(randomAdvertiseData);
      banners = randomAdvertiseData;
      notifyListeners();
    }
  }
}