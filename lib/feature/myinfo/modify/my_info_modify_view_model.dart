import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rotary_flutter/util/logger.dart';

import '../../../data/remoteData/file_remote_data.dart';

final MyInfoModifyProvider =
    ChangeNotifierProvider.autoDispose<_ViewModel>((ref) {
  return _ViewModel();
});

class _ViewModel with ChangeNotifier {
  File? image;
  final ImagePicker _picker = ImagePicker();

  Future pickImage() async {
    final XFile? pickedImage =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      notifyListeners();
      Log.d('i am got image $image');
    }
  }

  int? _imagePath;
  int? get imagePath => _imagePath;

  Future getAccountFile(int? fileApiPK) async {
    var data = await FileAPI().getAccountFile(fileApiPK);
    _imagePath = data?.id;
    notifyListeners();
  }
}
