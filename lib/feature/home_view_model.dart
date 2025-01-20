import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/data/remoteData/account_remote_data.dart';
import 'package:rotary_flutter/data/remoteData/sign_remote_data.dart';
import 'package:rotary_flutter/feature/home/home_main_screen.dart';
import 'package:rotary_flutter/util/model/loadstate.dart';

import '../util/logger.dart';

final HomeProvider = ChangeNotifierProvider.autoDispose<HomeViewmodel>((ref) {
  return HomeViewmodel();
});

class HomeViewmodel with ChangeNotifier {
  int _navigationIndex = 0;
  int get navigationIndex => _navigationIndex;
  int setNavigationIndex(int index) => _navigationIndex = index;

  LoadState loginState = End();

  void iOSLogin(String phone, String name) async{
    loginState  = Loading();
    notifyListeners();


    loginState =await AccountAPI().postIOSLogin(phone, name);

    Log.d('phone State: $loginState');
    notifyListeners();
  }

  LoadState authenticateState = Loading();

  void postAuthenticate(String phone, String code) async{
    authenticateState  = Loading();
    notifyListeners();

    authenticateState = await SignAPI().postSMSVerify(phone, code);
    notifyListeners();
  }

  List<Widget> _currentWidget = [HomeMainScreen()];

  Widget? get currentWidget {
    if(_currentWidget.isNotEmpty){
      return _currentWidget.last;
    }else {
      return null;
    }
  }
  set pushCurrentWidget(Widget? widget) {
    Log.d('print: $currentWidget $widget');

    if(widget != null && currentWidget.runtimeType != widget.runtimeType){
      _currentWidget.add(widget);
      notifyListeners();
    }
  }

  set setCurrentWidget(Widget? widget) {
    if(widget != null){
      _currentWidget.insert(0,widget);
      notifyListeners();
    }
  }

  Widget? popCurrentWidget() {
    if(_currentWidget.isNotEmpty){
      var result = _currentWidget.last;
      _currentWidget.removeLast();
      notifyListeners();

      return result;
    }else {
      Log.d('NavigateScope: setNull');

      return null;
    }
  }
}