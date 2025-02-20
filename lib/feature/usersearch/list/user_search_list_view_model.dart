import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rotary_flutter/data/model/article/response/article_model.dart';
import 'package:rotary_flutter/data/remoteData/article_remote_data.dart';
import 'package:rotary_flutter/data/remoteData/file_remote_data.dart';
import 'package:rotary_flutter/util/logger.dart';

import '../../../data/model/account/response/account_model.dart';
import '../../../data/remoteData/account_remote_data.dart';
import '../../../util/model/account_region.dart';
import '../../../util/model/loadstate.dart';
import '../../../util/model/pair.dart';

final UserSearchListProvider =
    ChangeNotifierProvider<UserSearchListViewModel>((ref) {
  return UserSearchListViewModel();
});

class UserSearchListViewModel with ChangeNotifier {
  int _selectedGrade = 0;

  int get selectedGrade => _selectedGrade;

  set selectedGrade(int data) {
    _selectedGrade = data;
    notifyListeners();
  }

  int _selectedRegion = 0;

  int get selectedRegion => _selectedRegion;

  set selectedRegion(int data) {
    _selectedRegion = data;
    notifyListeners();
  }

  LoadState<List<Account>> userListState = End();

  set setUserListState(LoadState<List<Account>> state) {
    userListState = state;
    notifyListeners();
  }

  List<Account> allAccount = [];

  void getAccountList() async {
    if (userListState is! Loading) {
      if (allAccount.isEmpty || allAccountCount == 0) {
        userListState = Loading();
        notifyListeners();

        userListState = await AccountAPI().getAccount();

        if (userListState is Success<List<Account>>) {
          var temp = (userListState as Success<List<Account>>).data;
          temp = temp.where((value) => value.name != '개발자').toList();

          allAccount = temp;
          allAccountCount = allAccount.length;
          _accountCount = allAccount.length;
        }
      }
      userListState = Success([]);
      notifyListeners();
      sortAccountList();
    }
  }

  List<Account> _accountList = [];

  List<Account> get accountList => _accountList;

  set accountList(List<Account> accounts) {
    _accountList = accounts;
    notifyListeners();
  }

  void sortAccountList({String? query}) async {
    var temp = allAccount;
    userListState = Loading();
    notifyListeners();
    if (accountList.isNotEmpty) accountList = [];

    await Future.delayed(const Duration(milliseconds: 100));

    final region = AccountRegion.regions[selectedRegion].id;
    final grade =
        AccountRegion.regions[selectedRegion].grades[selectedGrade].id;

    if (region != null)
      temp = temp.where((value) => value.thirdGrade?.id == region).toList();
    if (grade != null)
      temp = temp.where((value) => value.grade?.id == grade).toList();
    if (query != null && query.isNotEmpty)
      temp =
          temp.where((value) => value.name?.contains(query) ?? false).toList();
    temp = temp.where((value) => value.name != '개발자').toList();

    temp.sort((a, b) {

      if (a.time == '미입력' || a.time == null) return 1; // a가 null이면 뒤로
      if (b.time == '미입력' || b.time == null) return -1; // b가 null이면 앞으로

      return a.time!.compareTo(b.time!);
    });

    // todo 초성 검색
    accountCount = temp.length;
    accountList = temp;

    userListState = Success([]);
    notifyListeners();
  }

  DateTime? formatToDateTime(String? time) {
    try {
      return DateTime.parse(time ?? '');
    } catch (e) {
      try {
        time?.replaceAll('-', '.');
        DateTime dateTime = DateFormat('yyyy.MM.dd').parse(time ?? '');
        return dateTime;
      } catch (e) {
        return null;
      }
    }
  }

  int _accountCount = 0;

  int get accountCount => _accountCount;

  set accountCount(int count) {
    _accountCount = count;
    notifyListeners();
  }

  int allAccountCount = 0;

  Future<int?> getAccountFile(int? fileApiPK) async {
    var data = await FileAPI().getAccountFile(fileApiPK);
    return data?.id;
  }

  LoadState<List<ArticleModel>?> accountAdvertiseState = End();

  Future getArticleByAccount(int? id) async {
    accountAdvertiseState = Loading();
    notifyListeners();

    var result = await ArticleAPI().getAdvertiseAll(account: id);
    if (result == null || result.isEmpty) {
      accountAdvertiseState = Success([]);
    } else {
      accountAdvertiseState = Success(result);
    }
    notifyListeners();
  }
}
