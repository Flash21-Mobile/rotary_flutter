import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';
import 'package:rotary_flutter/util/global_color.dart';

import '../home_view_model.dart';

class AdvertiseDetailScreen extends ConsumerStatefulWidget {
  final String imagePath;

  const AdvertiseDetailScreen({super.key, required this.imagePath});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Widget();
}

class _Widget extends ConsumerState<AdvertiseDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('K-로타리 앱'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              ref.read(HomeProvider).popCurrentWidget();
            },
          ),
        ),
        backgroundColor: GlobalColor.black,
        body: InteractiveViewer(
            minScale: 1.0,
            maxScale: 6.0,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.network(widget.imagePath,
                  headers: {'cheat': 'showmethemoney'},
                loadingBuilder: (context, child, loadingProgress){
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },)
            ])));
  }
}
