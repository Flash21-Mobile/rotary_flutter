import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rotary_flutter/data/remoteData/file_remote_data.dart';
import 'package:rotary_flutter/feature/home_component.dart';
import 'package:rotary_flutter/feature/usersearch/list/user_search_list_component.dart';
import 'package:rotary_flutter/feature/usersearch/list/user_search_list_view_model.dart';
import 'package:rotary_flutter/util/common/common.dart';
import 'package:rotary_flutter/util/logger.dart';
import 'package:rotary_flutter/util/model/account_region.dart';
import 'package:rotary_flutter/util/model/account_grade.dart';

import '../../../data/model/account_model.dart';
import '../../../util/global_color.dart';
import '../../../util/model/loadstate.dart';
import '../../home/home_main_component.dart';
import '../../home_view_model.dart';
import '../info/user_info_screen.dart';

class UserSearchListScreen extends ConsumerStatefulWidget {
  final int? initialRegion;

  const UserSearchListScreen({super.key, required this.initialRegion});

  @override
  ConsumerState<UserSearchListScreen> createState() => _UserSearchLIstScreen();
}

class _UserSearchLIstScreen extends ConsumerState<UserSearchListScreen> {
  late int _selectedGrade;
  late int _selectedRegion;
  final TextEditingController _searchController = TextEditingController();

  List<Account> items = [];
  String query = '';
  bool hasMore = true;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _selectedGrade = 0;
    _selectedRegion = widget.initialRegion??0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
  }

  // 서버에서 데이터를 페이징으로 받아오는 함수
  Future<void> fetchData() async {
    var userSearchListProvider = ref.read(UserSearchListProvider);
    if (userSearchListProvider.userListState is Loading && !hasMore) return;


    var loadState = await userSearchListProvider.getAccountList(
        page: currentPage,
        grade: AccountGrade.all[_selectedGrade] == '전체RC' ? null: AccountGrade.all[_selectedGrade],
        region: AccountRegion.all[_selectedRegion] == '전체' ? null: AccountRegion.all[_selectedRegion],
        name: query);

    print('hello: ${loadState}');

    if (loadState is Success) {
      final List<Account> data = loadState.data;
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
    Log.d('hello: initData');
    var userSearchListProvider = ref.read(UserSearchListProvider);
    if (userSearchListProvider.userListState is Loading && !hasMore) return;

    setState(() {
      currentPage = 0;
      items = [];
      hasMore = true;
    });
  }

  // void getAccountList() {
  //   ref.read(UserSearchListProvider).getAccountList(
  //       cardinal: CardinalLocation.all[_selectedLocation].id,
  //       groupCardinal: CardinalRC.all[_selectedRC].id);
  // }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = ref.watch(UserSearchListProvider);

    print('isLoading is ${viewModel.userListState}');

    return Scaffold(
        backgroundColor: GlobalColor.indexBoxColor,
        appBar: AppBar(
          title: Text('회원검색'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              ref.read(HomeProvider).popCurrentWidget();
            },
          ),
        ),
        body: Column(children: [
          SizedBox(
            height: 15,
          ),
          Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Row(
                children: [
                  CustomDropdown(
                    isLoading: viewModel.userListState is Loading,
                      items: AccountRegion.all
                          .map((value) => value)
                          .toList(),
                      selectedValue: _selectedRegion,
                      onChanged: (value) {
                        if (value != null && value != _selectedRegion) {
                          setState(() => _selectedRegion = value);
                          initData();
                        }
                      }),

                  SizedBox(width: 10),
                  CustomDropdown(
                    isLoading: viewModel.userListState is Loading,
                      items: AccountGrade.all.map((value) => value).toList(),
                      selectedValue: _selectedGrade,
                      onChanged: (value) {
                        if (value != null && value != _selectedGrade) {
                          setState(() => _selectedGrade = value);
                          initData();
                        }
                      }),

                  SizedBox(width: 10),
                  // 검색 텍스트필드
                  Expanded(
                      child: Container(
                    height: 40,
                    child: SearchBox(
                      hint: '회원검색',
                      borderColor: GlobalColor.transparent,
                      backgroundColor: GlobalColor.white,
                      onSearch: (queryData){
                        query = queryData;
                        initData();
                      },
                    ),
                  )) //
                ],
              )),
          SizedBox(
            height: 15,
          ),
          Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 15),
                itemCount: items.length + 1,
                itemBuilder: (context, index) {
                  if (index == items.length) {
                    if (viewModel.userListState is Loading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (hasMore) {
                      fetchData();
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Container(
                      padding: EdgeInsets.only(bottom: 30,top: 10),
                          child:Text('더 이상 검색된 회원이 없습니다', textAlign: TextAlign.center,));
                    }
                  }
                  return UserSearchListTile(account: items[index]);
                },
                separatorBuilder: (_, $) => const SizedBox(height: 10),

            // errorWidget: const Expanded(
            //     child: Column(
            //   children: [
            //     SizedBox(height: 150),
            //     Text(
            //       'ⓘ',
            //       style: TextStyle(fontSize: 40),
            //     ),
            //     IndexText('조회된 데이터가 없습니다.'),
            //   ],
            // ))
          ))
        ]));
  }
}
