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
  late bool hasMore;

  late int currentPage;

  late String query;

  late List<ArticleModel> items;
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    items = [];
    query = '';
    currentPage = 0;
    hasMore = true;

    fetchData();
    ref.read(AdvertiseProvider).getAdvertiseCount();
  }

  Future<void> fetchData() async {
    var userSearchListProvider = ref.read(AdvertiseProvider);
    if (userSearchListProvider.advertiseState is Loading && !hasMore) return;

    var loadState = await userSearchListProvider.getAdvertiseAll(
        page: currentPage, query: query);

    if (loadState is Success) {
      final List<ArticleModel> data = loadState.data;
      print('hello: ioio ${loadState.data}');

      if (data.isNotEmpty) {
        setState(() {
          items.addAll(data);
          currentPage++;
        });
      } else {
        setState(() {
          hasMore = false;
        });
      }
    } else {
      setState(() {
        hasMore = false;
      });
      print('hello: else $hasMore');
    }
  }

  Future<void> initData() async {
    var userSearchListProvider = ref.read(AdvertiseProvider);
    if (userSearchListProvider.advertiseState is Loading && !hasMore) return;

    setState(() {
      currentPage = 0;
      items = [];
      hasMore = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = ref.watch(AdvertiseProvider);

    Log.d('데이터: ${items}');

    return Scaffold(
        backgroundColor: GlobalColor.white,
        appBar: AppBar(
          title: Text('광고협찬'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              ref.read(HomeProvider).popCurrentWidget();
            },
          ),
        ),
        body:
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Stack(children: [
              Padding(
                  padding: EdgeInsets.only(top: 30),
                  child:
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
                                    query = data;
                                    initData();
                                  })),
                        ),
                        SliverToBoxAdapter(
                            child: SizedBox(
                          height: 15,
                        )),
                        SliverList.separated(
                          itemCount: items.length + 1,
                          itemBuilder: (context, index) {
                            if (index == items.length) {
                              if (viewModel.advertiseState is Loading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (hasMore) {
                                fetchData();
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else {
                                return Container(
                                    padding: EdgeInsets.only(
                                      bottom: 30,
                                    ),
                                    child: Text(
                                      '더 이상 검색된 홍보물이 없습니다',
                                      textAlign: TextAlign.center,
                                    ));
                              }
                            }
                            return AdvertiseListTile(
                              data: items[index],
                              onTap: () {
                                FocusScope.of(context).unfocus();

                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return AdvertiseDetailScreen(
                                      data: items[index]);
                                }));
                              },
                            );
                          },
                          separatorBuilder: (_, $) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                                height: 1, color: GlobalColor.dividerColor),
                          ),
                        )
                      ]))])));
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
