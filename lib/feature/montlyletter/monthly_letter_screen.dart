import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/data/model/article_model.dart';
import 'package:rotary_flutter/feature/advertise/advertise_component.dart';
import 'package:rotary_flutter/feature/home_component.dart';
import 'package:rotary_flutter/feature/montlyletter/detail/monthly_letter_detail.dart';
import 'package:rotary_flutter/feature/montlyletter/monthly_letter_component.dart';
import 'package:rotary_flutter/feature/montlyletter/monthly_letter_view_model.dart';
import 'package:rotary_flutter/feature/userSearch/list/user_search_list_component.dart';
import 'package:rotary_flutter/util/common/common.dart';
import 'package:rotary_flutter/util/fontSize.dart';

import '../../../../data/model/article_model.dart';
import '../../../../util/global_color.dart';
import '../../util/logger.dart';
import '../../util/model/loadstate.dart';
import '../../util/secure_storage.dart';
import '../event/page/advertise_page_screen.dart';
import '../home/home_main_component.dart';
import '../home_view_model.dart';

class MonthlyLetter extends ConsumerStatefulWidget {
  const MonthlyLetter({super.key});

  @override
  ConsumerState<MonthlyLetter> createState() => _Widget();
}

class _Widget extends ConsumerState<MonthlyLetter> {
  late bool hasMore;

  late int currentPage;

  late String query;

  late List<ArticleModel> items;
  late ScrollController controller;

  var isAdmin = false;

  void checkAdmin() async {
    var data = (await globalStorage.read(key: 'admin')) == 'admin';

    setState(() => isAdmin = data);
  }

  Future<String?> pickPdfFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    return result?.files.single.path;
  }

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    query = '';
    initData();

    ref.read(MonthlyLetterProvider).monthlyLetterPostState = End();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(MonthlyLetterProvider).getAdvertiseCount();
      checkAdmin();
    });
  }

  Future<void> fetchData() async {
    var userSearchListProvider = ref.read(MonthlyLetterProvider);
    if (userSearchListProvider.monthlyLetterState is Loading && !hasMore)
      return;

    var loadState = await userSearchListProvider.getMonthlyLetterAll(
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
    setState(() {
      currentPage = 0;
      items = [];
      hasMore = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = ref.watch(MonthlyLetterProvider);

    Log.d('데이터 state: ${viewModel.monthlyLetterPostState}');

    loadStateFunction(
        loadState: viewModel.monthlyLetterPostState,
        onSuccess: (data) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('업로드에 성공하였습니다'),
                duration: Duration(milliseconds: 1500),
              ),
            );
          });
          viewModel.monthlyLetterPostState = End();
          SchedulerBinding.instance.addPostFrameCallback((_) {
            initData();
          });
          Navigator.of(context, rootNavigator: true).pop();
        },
        onLoading: () {
          viewModel.monthlyLetterPostState = End();
          SchedulerBinding.instance.addPostFrameCallback((_) {
            LoadingWidget.show(context, '파일을 업로드 중입니다');
          });
        },
        onError: (e) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('업로드에 실패하였습니다'),
                duration: Duration(milliseconds: 1500),
                backgroundColor: Colors.red,
              ),
            );
          });

          viewModel.monthlyLetterPostState = End();
          Navigator.of(context, rootNavigator: true).pop();
        });

    return Scaffold(
      backgroundColor: GlobalColor.white,
      appBar: AppBar(
        title: Text('총재월신'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            ref.read(HomeProvider).popCurrentWidget();
          },
        ),
      ),
      body: Stack(children: [
        Padding(
            padding: EdgeInsets.only(top: 30),
            child: CustomScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                controller: controller,
                slivers: [
                  SliverAppBar(
                    snap: true,
                    automaticallyImplyLeading: false,
                    floating: true,
                    flexibleSpace: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
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
                        if (viewModel.monthlyLetterState is Loading) {
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
                                '더 이상 검색된 총재월신이 없습니다',
                                textAlign: TextAlign.center,
                              ));
                        }
                      }
                      return MonthlyLetterListTile(
                        data: items[index],
                        onTap: () {
                          FocusScope.of(context).unfocus();

                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return MonthlyLetterDetail(
                                data: items[
                                    index]); //todo r: 윤용택 740 article 추가 바른이엔씨
                          }));
                        },
                      );
                    }, //todo r: 에러일시 로직
                    separatorBuilder: (_, $) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child:
                          Container(height: 1, color: GlobalColor.dividerColor),
                    ),
                  )
                ])),
      ]),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              onPressed: () async {
                var data = await pickPdfFile();
                if (data != null) {
                  showFileDialog(data);
                }
              },
              backgroundColor: GlobalColor.primaryColor,
              child: const Icon(
                Icons.add_rounded,
              ))
          : null,
    );
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

  void showFileDialog(
    String data,
  ) {
    showDialog(
        context: context,
        builder: (context) => CustomDialog(
              title: '선택된 파일',
              subTitle: data.split('/').last,
              onConfirm: () async {
                Navigator.of(context).pop();
                await ref.read(MonthlyLetterProvider).postMonthlyLetter(data);
              },
              onCancel: () {
                Navigator.of(context).pop();
              },
              confirmText: '업로드',
              cancelText: '취소',
            ));
  }
}
