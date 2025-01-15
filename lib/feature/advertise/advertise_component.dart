import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/data/model/article_model.dart';
import 'package:rotary_flutter/feature/advertise/advertise_view_model.dart';
import 'package:rotary_flutter/feature/event/page/advertise_page_screen.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';
import 'package:rotary_flutter/feature/home_view_model.dart';
import 'package:rotary_flutter/feature/userSearch/info/user_info_screen.dart';
import 'package:rotary_flutter/feature/userSearch/list/user_search_list_component.dart';
import 'package:rotary_flutter/util/global_color.dart';
import '../usersearch/list/user_search_list_view_model.dart';

class AdvertiseDetailScreen extends ConsumerStatefulWidget {
  final ArticleModel data;

  const AdvertiseDetailScreen({super.key, required this.data});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Widget();
}

class _Widget extends ConsumerState<AdvertiseDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('광고협찬'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: GlobalColor.black,
        body: Stack(alignment: Alignment.bottomLeft, children: [
          InteractiveViewer(
              minScale: 1.0,
              maxScale: 6.0,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureImage(
                        ref
                            .read(AdvertiseProvider)
                            .getAdvertiseFile(widget.data.id),
                        onError: Center(
                          child: CircularProgressIndicator(),
                        ))
                  ])),
          InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                widget.data.account != null
                    ? Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        UserInfoScreen(account: widget.data.account!)))
                    : () {};
              },
              child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 30, left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: FutureImage(
                              ref
                                  .read(UserSearchListProvider)
                                  .getAccountFile(widget.data.account?.id),
                              width: 30,
                              height: 30,
                              onError: Container(
                                  width: 30,
                                  height: 30,
                                  color: GlobalColor.indexBoxColor,
                                  child: const Icon(
                                    Icons.person_rounded,
                                    color: GlobalColor.indexColor,
                                    size: 18,
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          IndexTitle(
                            '${widget.data.account?.name} / ${widget.data
                                .account?.grade?.name}',
                            textColor: GlobalColor.white,
                          )
                        ],
                      ),
                      ...widget.data.content != '설명없음'
                          ? [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            padding: EdgeInsets.only(right: 15),
                            child: IndexMinText(
                              widget.data.content,
                              textColor: GlobalColor.white,
                            ))
                      ]
                          : [SizedBox()]
                    ],
                  )))
        ]));
  }
}

class AdvertiseListTile extends ConsumerStatefulWidget {
  const AdvertiseListTile({super.key, required this.data, required this.onTap});

  final ArticleModel data;
  final VoidCallback onTap;

  @override
  ConsumerState<AdvertiseListTile> createState() {
    return _AdvertiseListTile();
  }
}

class _AdvertiseListTile extends ConsumerState<AdvertiseListTile> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(AdvertiseProvider);
    return InkWell(
        onTap: widget.onTap,
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FutureImage(viewModel.getAdvertiseFile(widget.data.id),
                    width: 100, height: 100)),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IndexTitle('${widget.data.title}'),
                SizedBox(
                  height: 8,
                ),
                ...widget.data.content != '설명없음'
                    ? [
                  Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 145,
                      child: IndexMinText(
                        '${widget.data.content}',
                        maxLength: 2,
                        textColor: GlobalColor.indexColor,
                      )),
                  SizedBox(
                    height: 5,
                  )
                ]
                    : [SizedBox()],
                IndexMinText(
                    '${widget.data.account?.name} / ${widget.data.account?.grade
                        ?.name}')
              ],
            )
          ],
        ));
  }
}

class AdvertiseSearchBoxDelegate extends SliverPersistentHeaderDelegate {
  @override
  final double minExtent;
  @override
  final double maxExtent;

  final  Function (String) onChanged;

  AdvertiseSearchBoxDelegate({this.minExtent = 50, this.maxExtent = 50,required this.onChanged});

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return Container(color: GlobalColor.white,child:  SearchBox(
      hint: '검색',
      onChanged: onChanged
    ));
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
