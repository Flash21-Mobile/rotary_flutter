import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/data/model/event_model.dart';

import '../../../util/global_color.dart';
import '../../home/home_main_component.dart';
import '../../home_view_model.dart';

class EventDetailScreen extends ConsumerStatefulWidget {
  final EventModel event;

  const EventDetailScreen({super.key, required this.event});

  @override
  ConsumerState<EventDetailScreen> createState() => _EventDetailScreen();

}

class _EventDetailScreen extends ConsumerState<EventDetailScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalColor.white,
        appBar: AppBar(
          title: Text('행사일정'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              ref.read(HomeProvider).popCurrentWidget();
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IndexThumbTitle(widget.event.title),
                    IndexText(widget.event.content),
                    SizedBox(
                      height: 30,
                    ),
                    Divider(height: 0.5,thickness: 0.5,color: GlobalColor.greyFontColor,),
                    SizedBox(height: 5,),
                    IndexMinText('2023-02-24 업데이트',textColor: GlobalColor.greyFontColor,)
                  ])),
        ));
  }
}