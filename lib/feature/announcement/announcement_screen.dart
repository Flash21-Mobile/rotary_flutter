import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/data/model/article_model.dart';
import 'package:rotary_flutter/feature/announcement/announcement_view_model.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';
import 'package:rotary_flutter/feature/home_component.dart';
import 'package:rotary_flutter/feature/home_provider.dart';
import 'package:rotary_flutter/util/global_color.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'detail/annoucment_detail_screen.dart';

class AnnouncementScreen extends ConsumerStatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  ConsumerState<AnnouncementScreen> createState() => _AnnouncementScreen();
}

class _AnnouncementScreen extends ConsumerState<AnnouncementScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(AnnouncementProvider).getArticle();
  }


  @override
  Widget build(BuildContext context) {
  var announcementProvider = ref.watch(AnnouncementProvider);

    return LoadStateScaffold(
        appBar: AppBar(
          title: Text('공지사항'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              ref.read(HomeProvider).popCurrentWidget();
            },
          ),
          centerTitle: true,
        ),
      backgroundColor: GlobalColor.white,
      loadState: announcementProvider.announcementState,
      successBody:(data) { data as List<Article>;
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(15),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AnnouncementDetailScreen(board: data[index],),
                  ));
                },
                child:  Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: GlobalColor.indexBoxColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IndexTitle(data[index].title),
                    IndexText(data[index].content, overFlowFade: true,),
                    SizedBox(height: 15,),
                    IndexMinText('2023-02-24 업데이트')
                  ]
              ),
            ));
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 15,);
          });
      });
  }




















  // late WebViewController _controller = WebViewController();
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _controller = WebViewController()
  //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //     ..loadRequest(Uri.parse('http://rotary3700.or.kr/bsbbs/list?page=2&tn=notice&ti=&sw=&st=&cate=0'));
  // }
  //
  // Future<bool> _onWillPop() async {
  //   if(await _controller.canGoBack()) {
  //     await _controller.goBack();
  //     return false;
  //   }
  //   return true;
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return WillPopScope(
  //     onWillPop: _onWillPop,
  //     child: Scaffold(
  //       body: WebViewWidget(controller: _controller),
  //     ),
  //   );
  // }
}

