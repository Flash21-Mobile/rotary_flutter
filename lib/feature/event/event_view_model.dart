
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/remoteData/event_remote_data.dart';
import '../../util/model/loadstate.dart';

final EventProvider = ChangeNotifierProvider.autoDispose<_ViewModel>((ref) {
  return _ViewModel();
});

class _ViewModel with ChangeNotifier {
  LoadState eventState = Loading();

  Future getEvent() async{
    eventState  = Loading();
    notifyListeners();

    var data = await EventAPI().getEvent();
    eventState = data;
    notifyListeners();
  }
}