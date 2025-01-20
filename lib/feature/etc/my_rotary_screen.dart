import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../util/global_color.dart';
import '../home/home_main_component.dart';
import '../home_view_model.dart';

class MyRotaryScreen extends ConsumerStatefulWidget {
  const MyRotaryScreen({super.key});

  @override
  ConsumerState<MyRotaryScreen> createState() => _MyRotaryScreen();
}

class _MyRotaryScreen extends ConsumerState<MyRotaryScreen> {
  late WebViewController _controller = WebViewController();

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://my.rotary.org/ko'));
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(const Duration(milliseconds: 300)).then((value)=> setState(() =>()));
    Future.delayed(const Duration(milliseconds: 500)).then((value)=> setState(() =>()));
  }

  Future<bool> _onWillPop() async {
    if(await _controller.canGoBack()) {
      await _controller.goBack();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: GlobalColor.white,
        appBar: AppBar(
          title: IndexMaxTitle('내 로타리'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              ref.read(HomeProvider).popCurrentWidget();
            },
          ),
        ),
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}
