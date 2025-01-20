import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/util/global_color.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../home/home_main_component.dart';
import '../home_view_model.dart';

class IntroduceFoundationScreen extends ConsumerStatefulWidget {
  const IntroduceFoundationScreen({super.key});

  @override
  ConsumerState<IntroduceFoundationScreen> createState() => IntroduceFoundationScreenState();
}

class IntroduceFoundationScreenState extends ConsumerState<IntroduceFoundationScreen> {
  late WebViewController _controller = WebViewController();

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('http://rotary3700.or.kr/bsbbs/list?tn=governor&menuid=4&sub_menuid=13'));
  }

  Future<bool> _onWillPop() async {
    if(await _controller.canGoBack()) {
      await _controller.goBack();
      return false;
    }
    return true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(const Duration(milliseconds: 300)).then((value)=> setState(() =>()));
    Future.delayed(const Duration(milliseconds: 500)).then((value)=> setState(() =>()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: GlobalColor.white,
        appBar: AppBar(
          title: IndexMaxTitle('총재단소개'),
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
