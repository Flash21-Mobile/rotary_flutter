import 'package:daum_postcode_search/daum_postcode_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/util/global_color.dart';
import 'package:rotary_flutter/util/logger.dart';

import '../feature/home/home_main_component.dart';

class GetAddressScreen extends ConsumerStatefulWidget {
  const GetAddressScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _Widget();
  }
}

class _Widget extends ConsumerState {
  bool _isError = false;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    DaumPostcodeSearch daumPostcodeSearch =
        DaumPostcodeSearch(onConsoleMessage: (_, message) => Log.d('$message'));

    return Scaffold(
        backgroundColor: GlobalColor.white,
        appBar: AppBar(
          backgroundColor: GlobalColor.white,
          elevation: 0,
          title: IndexMaxTitle('주소검색'),
          foregroundColor: GlobalColor.black,
        ),
        body: Container(
            child: Column(children: [
          Expanded(
            child: daumPostcodeSearch,
          ),
          Visibility(
              visible: _isError,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(errorMessage ?? ""),
                  ElevatedButton(
                    child: Text("Refresh"),
                    onPressed: () {
                      daumPostcodeSearch.controller?.reload();
                    },
                  ),
                ],
              ))
        ])));
  }
}
