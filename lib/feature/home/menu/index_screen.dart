import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rotary_flutter/feature/announcement/announcement_screen.dart';
import 'package:rotary_flutter/feature/userSearch/user_search_screen.dart';

import '../../../util/global_color.dart';
import '../../../util/logger.dart';
import '../../home_provider.dart';
import '../home_main_screen.dart';

class IndexScreen extends ConsumerStatefulWidget {
  const IndexScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IndexScreen();
}

class _IndexScreen extends ConsumerState<IndexScreen> {
  @override
  Widget build(BuildContext context) {
    var homeProvider = ref.watch(HomeProvider);

    Log.d('NavigateScope: ${homeProvider.currentWidget}');

    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          var widget = homeProvider.popCurrentWidget();
          if(widget == null) SystemNavigator.pop();
        },
        child: Scaffold(
            backgroundColor: GlobalColor.white,
            appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: GlobalColor.white,
                title:InkWell(
                    onTap: (){
                      homeProvider.pushCurrentWidget = HomeMainScreen();
                    },
                    child:  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: GlobalColor.indexBoxColor,
                    ),
                    child: Row(children: [
                      SvgPicture.asset(
                        height: 20,
                        'asset/images/main_logo.svg',
                        fit: BoxFit.contain,
                      )
                    ])))),
            body: homeProvider.currentWidget??currentWidgetIsNull()));
  }

  HomeMainScreen currentWidgetIsNull(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 1500),
          content: Text('뒤로 가기 버튼을 한 번 더 누르면 앱이 종료됩니다.'),
        ),
      );
    });
    addHomeScreen();
    return const HomeMainScreen();
  }

  Future addHomeScreen()async{
    await Future.delayed(const Duration(milliseconds: 1500)).then((onValue){
      Log.d('NavigateScope: Add HomeMainScreen');
      ref.read(HomeProvider).setCurrentWidget = const HomeMainScreen();
    });
    return;
  }
}
