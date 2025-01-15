import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfx/pdfx.dart';
import 'package:rotary_flutter/data/model/article_model.dart';
import 'package:rotary_flutter/data/remoteData/article_remote_data.dart';
import 'package:rotary_flutter/data/remoteData/file_remote_data.dart';
import 'package:rotary_flutter/feature/home_component.dart';

import '../../../../util/model/loadstate.dart';
import 'dart:math';

import '../../data/model/account_model.dart';
import '../../data/remoteData/account_remote_data.dart';
import '../../util/secure_storage.dart';

final MonthlyLetterProvider = ChangeNotifierProvider<_ViewModel>((ref) {
  return _ViewModel();
});

class _ViewModel with ChangeNotifier {
  LoadState monthlyLetterState = End();

  List<int> banners = [];

  Future<int?> getMonthlyFileFirst(int? fileApiPK) async {
    var data = await FileAPI().getMonthlyFile(fileApiPK);
    return data?.first.id;
  }

  LoadState<List<int?>?> monthlyLetterFilesState = End();

  Future getMonthlyFiles(int? fileApiPK) async {
    monthlyLetterFilesState = Loading();
    notifyListeners();

    var data = await FileAPI().getMonthlyFile(fileApiPK);

    monthlyLetterFilesState = Success(data?.map((value) => value.id).toList());
    notifyListeners();
  }

  Future<LoadState> getMonthlyLetterAll({int? page, String? query}) async {
    monthlyLetterState = Loading();
    notifyListeners();

    var temp = await ArticleAPI().getMonthlyLetterAll(page, query, query);

    if (temp == null) {
      monthlyLetterState = Error('exception');
      notifyListeners();
      return monthlyLetterState;
    } else {
      // 본문과 썸네일 리스트 분리
      final List<ArticleModel> advertiseData = temp;

      // 결과를 상태로 설정
      monthlyLetterState = Success(advertiseData);
      banners = advertiseData.map((value) => value.id ?? 0).toList();
      notifyListeners();

      return monthlyLetterState;
    }
  }

  var monthlyCount = 0;

  Future getAdvertiseCount() async {
    monthlyCount = await ArticleAPI().getAdvertiseCount() ?? 0; //todo r: 고치기
    notifyListeners();
  }

  LoadState monthlyLetterPostState = End();

  Future postMonthlyLetter(String file) async {
    monthlyLetterPostState = Loading();
    notifyListeners();

    var cellphone = await globalStorage.read(key: 'phone');

    var accountState = await AccountAPI().getAccount(cellphone: cellphone);

    loadStateFunction<List<Account>>(
        loadState: accountState,
        onSuccess: (accounts) async {
          var firstResponseState =
              await ArticleAPI().postMonthlyLetterAll(accounts.first, file);

          loadStateFunction<ArticleModel>(
              loadState: firstResponseState,
              onSuccess: (data) async {
                monthlyLetterPostState = await FileAPI().postMonthlyLetterFile(data.id, file);
                notifyListeners();
              });
        },
        onError: (e) {
          monthlyLetterPostState = Error(e);
          notifyListeners();
        });
  }

  Future<LoadState> deleteMonthlyLetter(int id) async {
    return await ArticleAPI().deleteMonthlyLetter(id);
  }
}
