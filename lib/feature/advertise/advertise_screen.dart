import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/data/model/advertise_model.dart';
import 'package:rotary_flutter/feature/advertise/advertise_component.dart';
import 'package:rotary_flutter/feature/home_component.dart';
import 'package:rotary_flutter/feature/userSearch/list/user_search_list_component.dart';
import 'package:rotary_flutter/util/common/common.dart';
import 'package:rotary_flutter/util/fontSize.dart';

import '../../../../data/model/advertise_model.dart';
import '../../../../util/global_color.dart';
import '../../util/logger.dart';
import '../../util/model/loadstate.dart';
import '../home/home_main_component.dart';
import '../home_view_model.dart';
import 'advertise_view_model.dart';

class AdvertiseScreen extends ConsumerStatefulWidget {
  const AdvertiseScreen({super.key});

  @override
  ConsumerState<AdvertiseScreen> createState() => _AdvertiseScreen();
}

class _AdvertiseScreen extends ConsumerState<AdvertiseScreen> {
  bool hasMore = true;
  int currentPage = 0;
  String query = '';
  List<AdvertiseModel> items = [];

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  Future<void> fetchData() async {
    var userSearchListProvider = ref.read(AdvertiseProvider);
    if (userSearchListProvider.advertiseState is Loading && !hasMore) return;

    var loadState = await userSearchListProvider.getAdvertiseAll(page: currentPage, title: query);

    if (loadState is Success) {
      final List<AdvertiseModel> data = loadState.data;
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
        body: Column(children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: SearchBox(
                hint: '회원검색',
                onChanged: (data){
                  query = data;
                  initData();
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
                    child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 15),
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
                          return const SizedBox();
                        }
                      }
                      return AdvertiseListTile(data: items[index]);
                    },
                    separatorBuilder: (_, $) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: 1,
                        color: GlobalColor.dividerColor
                      ),
                    ),
                  ))]));
  }
}
