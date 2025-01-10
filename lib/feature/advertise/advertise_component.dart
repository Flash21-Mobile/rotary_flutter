import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/data/model/advertise_model.dart';
import 'package:rotary_flutter/feature/advertise/advertise_view_model.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';
import 'package:rotary_flutter/feature/userSearch/list/user_search_list_component.dart';
import 'package:rotary_flutter/util/global_color.dart';
import '../usersearch/list/user_search_list_view_model.dart';

class AdvertiseDetailScreen extends ConsumerStatefulWidget {
  final AdvertiseModel data;

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
        body: Stack(children: [
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
                        onError: SizedBox())
                  ])),
          Container(
              child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: FutureImage(ref.read(UserSearchListProvider).getAccountFile(widget.data.id), width: 50, height: 50),
                  )
                ],
              )
            ],
          ))
        ]));
  }
}

class AdvertiseListTile extends ConsumerStatefulWidget {
  const AdvertiseListTile({super.key, required this.data});

  final AdvertiseModel data;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AdvertiseListTile();
  }
}

class _AdvertiseListTile extends ConsumerState<AdvertiseListTile> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(AdvertiseProvider);
    return Row(
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
                        width: MediaQuery.of(context).size.width - 145,
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
                '${widget.data.account?.grade?.name} / ${widget.data.account?.name}')
          ],
        )
      ],
    );
  }
}
