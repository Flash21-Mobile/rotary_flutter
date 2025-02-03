import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/data/model/token/response/token.dart';
import 'package:rotary_flutter/data/remoteData/account_remote_data.dart';
import 'package:rotary_flutter/data/remoteData/sign_remote_data.dart';
import 'package:rotary_flutter/feature/home/home_main_screen.dart';
import 'package:rotary_flutter/util/model/loadstate.dart';
import 'package:rotary_flutter/util/secure_storage.dart';

import '../data/model/account/response/account_model.dart';
import '../util/logger.dart';

final HomeProvider = ChangeNotifierProvider.autoDispose<HomeViewmodel>((ref) {
  return HomeViewmodel();
});

class HomeViewmodel with ChangeNotifier {
  int _navigationIndex = 0;

  int get navigationIndex => _navigationIndex;

  int setNavigationIndex(int index) => _navigationIndex = index;

  LoadState _loginState = End();

  LoadState get loginState => _loginState;

  set loginState(LoadState state) {
    _loginState = state;
    notifyListeners();
  }

  void iOSLogin(String phone, String name) async {
    loginState = Loading();

    final data = await AccountAPI().postIOSLogin(phone, name);
    Log.w('i am received $data');
    loginState = data;
  }

  LoadState<Account> _signState = End();

  LoadState<Account> get signState => _signState;

  set signState(LoadState<Account> state) {
    _signState = state;
    notifyListeners();
  }

  void signIn({required String cellphone, String? name}) async {
    signState = Loading();
    var response = await SignAPI().signIn(cellphone: cellphone, name: name);

    if (response is Success<TokenModel>) {
      await globalStorage.write(key: 'token', value: response.data.token);

      var data = await AccountAPI().getAccount(cellphone: cellphone, size: 1, matchType: 'andEquals');
      if (data is Success<List<Account>>) {
        Log.w('data: [[: ${data}');

        signState = Success(data.data[0]);
      } else if (data is Error<List<Account>>) {
        signState = Error(data.exception);
      }
    } else if (response is Error<TokenModel>) {
      signState = Error(response.exception);
    }
  }

  List<Widget> _currentWidget = [HomeMainScreen()];

  Widget? get currentWidget {
    if (_currentWidget.isNotEmpty) {
      return _currentWidget.last;
    } else {
      return null;
    }
  }

  set pushCurrentWidget(Widget? widget) {
    Log.d('print: $currentWidget $widget');

    if (widget != null && currentWidget.runtimeType != widget.runtimeType) {
      _currentWidget.add(widget);
      notifyListeners();
    }
  }

  set setCurrentWidget(Widget? widget) {
    if (widget != null) {
      _currentWidget.insert(0, widget);
      notifyListeners();
    }
  }

  Widget? popCurrentWidget() {
    if (_currentWidget.isNotEmpty) {
      var result = _currentWidget.last;
      _currentWidget.removeLast();
      notifyListeners();

      return result;
    } else {
      Log.d('NavigateScope: setNull');

      return null;
    }
  }
}
