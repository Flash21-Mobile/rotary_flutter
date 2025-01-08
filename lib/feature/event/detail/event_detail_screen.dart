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
          title: Text('행사 일정'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              ref.read(HomeProvider).popCurrentWidget();
            },
          ),
        ),
        body:Column(children:[Expanded(child: Column(children: [ScrollablePinchView(child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IndexThumbTitle(widget.event.title),
                    SizedBox(
                      height: 5,
                    ),
                    IndexText(widget.event.content),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(height: 0.5,thickness: 0.5,color: GlobalColor.greyFontColor,),
                    SizedBox(height: 5,),
                    IndexMinText('${formatDateTime(widget.event.time)}',textColor: GlobalColor.greyFontColor,)
                  ])),
        )],) )]));
  }

  String formatDateTime(String? dateTime) {
    DateTime parsedDate = DateTime.parse(dateTime??'');
    return "${parsedDate.year}.${parsedDate.month.toString().padLeft(2, '0')}.${parsedDate.day.toString().padLeft(2, '0')}";
  }
}