import 'dart:async';
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
import 'package:rotary_flutter/util/model/pair.dart';

import '../../../data/model/account/response/account_model.dart';
import '../../../util/global_color.dart';
import '../../../util/model/loadstate.dart';
import '../../home/home_main_component.dart';
import '../../home_view_model.dart';
import '../info/user_info_screen.dart';

class UserSearchListScreen extends ConsumerStatefulWidget {
  final int? initialRegion;

  const UserSearchListScreen({super.key, required this.initialRegion});

  @override
  ConsumerState<UserSearchListScreen> createState() => _ViewModel();
}

class _ViewModel extends ConsumerState<UserSearchListScreen> {
  final TextEditingController _searchController = TextEditingController();
  late GlobalKey itemKey;

  late FocusNode focusNode;

  String query = '';
  bool hasMore = true;
  int currentPage = 0;

  late int accountCount;

  @override
  void initState() {
    super.initState();
    accountCount = 0;
    focusNode = FocusNode();

    itemKey = GlobalKey();

    ref.read(UserSearchListProvider).userListState = End();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(UserSearchListProvider).selectedRegion =
          widget.initialRegion ?? 0;
      ref.read(UserSearchListProvider).selectedGrade = 0;
      ref.read(UserSearchListProvider).sortAccountList();

    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void sortAccount() {
    final viewModel = ref.read(UserSearchListProvider);

    viewModel.sortAccountList(query: query);
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = ref.watch(UserSearchListProvider);

    return Scaffold(
        backgroundColor: GlobalColor.indexBoxColor,
        appBar: AppBar(
          title: IndexMaxTitle('회원검색'),
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
                Icons.account_box_rounded,
                color: GlobalColor.greyFontColor,
                size: 20,
              ),
              IndexMinText(
                '${viewModel.accountCount}',
                textColor: GlobalColor.greyFontColor,
              ),
              SizedBox(
                width: 15,
              )
            ]))
          ],
        ),
        body: Column(children: [
          SizedBox(
            height: 10,
          ),
          Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Row(
                children: [
                  CustomDropdown(
                    isLoading: viewModel.userListState is Loading,
                    items: AccountRegion.regions
                        .map((value) => value.name)
                        .toList(),
                    selectedValue: viewModel.selectedRegion,
                    onChanged: (value) {
                      if (value != null && value != viewModel.selectedRegion) {
                        if (viewModel.selectedRegion != value) {
                          viewModel.selectedRegion = value;
                          viewModel.selectedGrade = 0;
                        }
                      }
                      sortAccount();
                    },
                    onTap: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        focusNode.unfocus();
                      });
                    },
                  ),
                  if (viewModel.selectedRegion != 13) SizedBox(width: 10),
                  if (viewModel.selectedRegion != 13)
                    CustomGradeDropdown(
                        isLoading: viewModel.userListState is Loading,
                        items: AccountRegion
                            .regions[viewModel.selectedRegion].grades,
                        selectedValue: viewModel.selectedGrade,
                        onChanged: (value) {
                          if (value != null &&
                              value != viewModel.selectedGrade) {
                            viewModel.selectedGrade = value;
                            sortAccount();
                          }
                        },
                        onTap: () {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            focusNode.unfocus();
                          });
                        }),

                  SizedBox(width: 10),
                  // 검색 텍스트필드
                  Expanded(
                      child: Container(
                    height: 40,
                    child: SearchBox(
                      focusNode: focusNode,
                      hint: '회원검색',
                      borderColor: GlobalColor.transparent,
                      backgroundColor: GlobalColor.white,
                      onChanged: (queryData) {
                        query = queryData;

                        sortAccount();
                      },
                    ),
                  )) //
                ],
              )),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: LoadStateWidget(
                  loadState: viewModel.userListState,
                  successWidget: (_) {
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      itemCount: viewModel.accountList.length + 1,
                      itemBuilder: (context, index) {
                        if (index == viewModel.accountList.length) {
                          return Container(
                              padding: EdgeInsets.only(
                                bottom: 30,
                              ),
                              child: IndexText(
                                '더 이상 검색된 회원이 없습니다',
                                textAlign: TextAlign.center,
                              ));
                        }
                        return InkWell(
                            onTap: () {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                focusNode.unfocus();
                              });
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return UserInfoScreen(
                                    account: viewModel.accountList[index]);
                              }));
                            },
                            child: UserSearchListTile(
                                account: viewModel.accountList[index]));
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
                    );
                  }))
        ]));
  }
}
