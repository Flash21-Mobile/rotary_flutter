import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  LoadState phoneState = Loading();

  void postPhone(String phone) async{
    phoneState  = Loading();
    notifyListeners();

    phoneState = Success(null);
    notifyListeners();
  }

  LoadState authenticateState = Loading();

  void postAuthenticate(String phone) async{
    authenticateState  = Loading();
    notifyListeners();

    authenticateState = Success(null);
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
    if(widget != null){
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