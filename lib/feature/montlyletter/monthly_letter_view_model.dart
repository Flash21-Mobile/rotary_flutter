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
import '../../util/model/pair.dart';
import '../../util/secure_storage.dart';

final MonthlyLetterProvider = ChangeNotifierProvider<_ViewModel>((ref) {
  return _ViewModel();
});

class _ViewModel with ChangeNotifier {
  LoadState monthlyLetterState = End();

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

  List<ArticleModel> allMonthlyLetterList = [];
  List<ArticleModel> _monthlyLetterList = [];

  List<ArticleModel> get monthlyLetterList => _monthlyLetterList;

  set monthlyLetterList(List<ArticleModel> data) {
    _monthlyLetterList = data;
    notifyListeners();
  }

  Future<LoadState> getMonthlyLetterAll({String? query}) async {
    monthlyLetterState = Loading();
    notifyListeners();

    var temp = await ArticleAPI().getMonthlyLetterAll(query, query);

    if (temp == null) {
      monthlyLetterState = Error(Exception);
      notifyListeners();
      return monthlyLetterState;
    } else {
      final List<ArticleModel> advertiseData = temp;

      allMonthlyLetterList = temp;
      sortData();

      monthlyLetterState = Success(advertiseData);
      monthlyLetterCount = advertiseData.length;
      notifyListeners();

      return monthlyLetterState;
    }
  }

  void sortData({String? query}) async {
    var temp = allMonthlyLetterList;
    monthlyLetterState = Loading();
    notifyListeners();
    if (monthlyLetterList.isNotEmpty) monthlyLetterList = [];

    await Future.delayed(Duration(milliseconds: 100));

    if (query != null) {
      temp = temp.where((value) {
        return (value.title?.contains(query) ?? false) || // title에 query 포함 여부
            (value.content?.contains(query) ?? false) || // content에 query 포함 여부
            (value.account?.name?.contains(query) ?? false) ||
            (value.account?.grade?.name?.contains(query) ??
                false); // name에 query 포함 여부
      }).toList();
    }

    monthlyLetterCount = temp.length;
    monthlyLetterList = temp;

    monthlyLetterState = Success([]);
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
        onSuccess: (data) async {
          var firstResponseState =
              await ArticleAPI().postMonthlyLetterAll(data.first, file);

          loadStateFunction<ArticleModel>(
              loadState: firstResponseState,
              onSuccess: (data) async {
                monthlyLetterPostState =
                    await FileAPI().postMonthlyLetterFile(data.id, file);
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

  String query = '';

  int? monthlyLetterCount = 0;
}
