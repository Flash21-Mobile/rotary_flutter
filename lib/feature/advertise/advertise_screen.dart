import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/data/model/article_model.dart';
import 'package:rotary_flutter/feature/advertise/advertise_component.dart';
import 'package:rotary_flutter/feature/home_component.dart';
import 'package:rotary_flutter/feature/userSearch/list/user_search_list_component.dart';
import 'package:rotary_flutter/util/common/common.dart';
import 'package:rotary_flutter/util/fontSize.dart';

import '../../../../data/model/article_model.dart';
import '../../../../util/global_color.dart';
import '../../util/logger.dart';
import '../../util/model/loadstate.dart';
import '../event/page/advertise_page_screen.dart';
import '../home/home_main_component.dart';
import '../home_view_model.dart';
import 'advertise_view_model.dart';

class AdvertiseScreen extends ConsumerStatefulWidget {
  const AdvertiseScreen({super.key});

  @override
  ConsumerState<AdvertiseScreen> createState() => _AdvertiseScreen();
}

class _AdvertiseScreen extends ConsumerState<AdvertiseScreen> {
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();

    ref.read(AdvertiseProvider).advertiseState = End();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(AdvertiseProvider).getAdvertiseAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = ref.watch(AdvertiseProvider);

    Log.d('hello ${viewModel.advertiseState}');
    return Scaffold(
        backgroundColor: GlobalColor.white,
        appBar: AppBar(
          title: IndexMaxTitle('\광고협찬'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              ref.read(HomeProvider).popCurrentWidget();
            },
          ),
          actions: [
            Center(
                child: Row(children: [
              Icon(
                Icons.article,
                color: GlobalColor.greyFontColor,
                size: 20,
              ),
              IndexMinText(
                '${viewModel.advertiseCount}',
                textColor: GlobalColor.greyFontColor,
              ),
              SizedBox(width: 15)
            ]))
          ],
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Stack(alignment: Alignment.topCenter, children: [
              CustomScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  controller: controller,
                  slivers: [
                    SliverAppBar(
                      snap: true,
                      automaticallyImplyLeading: false,
                      floating: true,
                      flexibleSpace: Container(
                          color: GlobalColor.white,
                          child: SearchBox(
                              hint: '검색',
                              onChanged: (data) {
                                viewModel.query = data;
                                viewModel.sortData(query: viewModel.query);
                              })),
                    ),
                    SliverToBoxAdapter(
                        child: SizedBox(
                      height: 15,
                    )),
                    LoadStateWidgetFun(
                        loadState: viewModel.advertiseState,
                        successWidget: (_) {
                          return SliverList.separated(
                            itemCount: viewModel.advertiseList.length + 1,
                            itemBuilder: (context, index) {
                              if (index == viewModel.advertiseList.length) {
                                return Container(
                                    padding: const EdgeInsets.only(bottom: 30),
                                    child: const IndexText('더 이상 검색된 목록이 없습니다',
                                        textAlign: TextAlign.center));
                              }
                              return AdvertiseListTile(
                                data: viewModel.advertiseList[index],
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return AdvertiseDetailScreen(
                                        data: viewModel.advertiseList[index]);
                                  }));
                                },
                              );
                            },
                            separatorBuilder: (_, $) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                  height: 1, color: GlobalColor.dividerColor),
                            ),
                          );
                        },
                        loadingWidget: () {
                          return SliverToBoxAdapter(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                        errorWidget: (e) {
                          return SliverToBoxAdapter(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                        elseWidget: SliverToBoxAdapter())
                  ])
            ])));
    // Container(
    //     color: GlobalColor.white,
    //     height: 30,
    //     alignment: Alignment.center,
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.end,
    //       children: [
    //         IndexMinText('전체 광고 수: ${viewModel.advertiseCount}'),
    //       ],
  }
}
