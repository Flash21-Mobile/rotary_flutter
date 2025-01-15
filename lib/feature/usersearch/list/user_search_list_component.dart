import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/feature/usersearch/list/user_search_list_view_model.dart';

import '../../../data/model/account_model.dart';
import '../../../util/common/common.dart';
import '../../../util/global_color.dart';
import '../../home/home_main_component.dart';
import '../../home_view_model.dart';
import '../../userSearch/info/user_info_screen.dart';

class FutureImage extends ConsumerStatefulWidget {
  const FutureImage(this.futureId,
      {super.key, this.itemKey,this.width, this.height, this.onError});

  final Future<int?> futureId;
  final double? width;
  final GlobalKey? itemKey;
  final double? height;
  final Widget? onError;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NetworkImage();
}

class _NetworkImage extends ConsumerState<FutureImage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int? imagePK = -3999021222202;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getFile();
    });
  }

  void getFile() async {
    var data = await widget.futureId;
    if (mounted) {
      setState(() {
        imagePK = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var placeHolder = widget.onError ??
        Container(
            width: widget.width,
            height: widget.height,
            color: GlobalColor.indexBoxColor,
            child: const Icon(
              Icons.person_rounded,
              color: GlobalColor.indexColor,
              size: 60,
            ));

    var image = Image.network(
        key: widget.itemKey,
        '$BASE_URL/file/$imagePK',
        fit: widget.height == null ? BoxFit.fitWidth : BoxFit.cover,
        headers: const {'cheat': 'showmethemoney'},
        width: widget.width,
        height: widget.height,
        loadingBuilder: (context, child, progress) {
          if (progress == null) {
            return child;
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
        errorBuilder: (context, error, stackTrace) => Center(
              child: CircularProgressIndicator(),
            ));

    return imagePK != -3999021222202
        ? imagePK != null
            ? Container(
                width: widget.width,
                height: widget.height,
                alignment: Alignment.center,
                child: widget.height == null
                    ? LayoutBuilder(builder: (context, constrains) => image)
                    : image,
              )
            : placeHolder
        : Container(
            width: widget.width,
            height: widget.height,
            child: Center(
              child: CircularProgressIndicator(),
            ));
  }
}

class UserSearchListTile extends ConsumerStatefulWidget {
  final Account account;

  const UserSearchListTile({super.key, required this.account});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserSearchListTile();
}

class _UserSearchListTile extends ConsumerState<UserSearchListTile> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(UserSearchListProvider);

    return InkWell(
        onTap: () {
          // ref.read(HomeProvider).pushCurrentWidget =
          //     UserInfoScreen(id: widget.account.id ?? 0);

          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return UserInfoScreen(account: widget.account);
          }));
        },
        child: Container(
          decoration: BoxDecoration(
              color: GlobalColor.white,
              borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: FutureImage(
                    viewModel.getAccountFile(widget.account.id),
                    width: 120,
                    height: 160,
                  )),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    IndexThumbTitle(widget.account.name),
                    SizedBox(
                      width: 5,
                    ),
                    IndexMinText(
                      widget.account.grade?.name,
                      overFlowFade: true,
                    )
                  ]),
                  SizedBox(
                    height: 5,
                  ),
                  IndexText(widget.account.groupGrade?.name),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      width: 165,
                      child: Row(children: [
                        IndexMinText('직책'),
                        Spacer(),
                        IndexMinTitle(widget.account.pastGrade?.name),
                      ])),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      width: 165,
                      child: Row(children: [
                        //todo r: 직책 배경주고 색상
                        IndexMinText('입회일'),
                        Spacer(),
                        IndexMinTitle(
                          widget.account.time != null
                              ? formatDateTime(widget.account.time)
                              : '',
                        ),
                      ])),
                  SizedBox(
                    height: 5,
                  ),
                  IndexText('010-****-****'),
                ],
              )
            ],
          ),
        ));
  }

  String formatDateTime(String? dateTime) {
    DateTime parsedDate = DateTime.parse(dateTime ?? '');
    return "${parsedDate.year}.${parsedDate.month.toString().padLeft(2, '0')}.${parsedDate.day.toString().padLeft(2, '0')}";
  }
}
