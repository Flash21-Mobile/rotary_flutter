import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/data/model/article_model.dart';
import 'package:rotary_flutter/feature/advertise/advertise_view_model.dart';
import 'package:rotary_flutter/feature/event/page/advertise_page_screen.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';
import 'package:rotary_flutter/feature/home_view_model.dart';
import 'package:rotary_flutter/feature/myInfo/modify/my_info_modify_view_model.dart';
import 'package:rotary_flutter/feature/userSearch/info/user_info_screen.dart';
import 'package:rotary_flutter/feature/userSearch/list/user_search_list_component.dart';
import 'package:rotary_flutter/util/global_color.dart';
import '../usersearch/list/user_search_list_view_model.dart';

class UserSearchViewer extends ConsumerStatefulWidget {
  final int? id;

  const UserSearchViewer({super.key, required this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Widget();
}

class _Widget extends ConsumerState<UserSearchViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('회원정보'),
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
                        ref.read(UserSearchListProvider).getAccountFile(widget.id),
                        onError: Center(child: CircularProgressIndicator(),),)
                  ])),
        ]));
  }
}
