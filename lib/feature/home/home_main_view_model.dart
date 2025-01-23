import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/data/model/article_model.dart';

import '../../data/remoteData/article_remote_data.dart';
import '../../data/remoteData/file_remote_data.dart';
import '../../util/model/loadstate.dart';

final HomeMainProvider = ChangeNotifierProvider.autoDispose<_ViewModel>((ref) {
  return _ViewModel();
});

class _ViewModel with ChangeNotifier {

}
