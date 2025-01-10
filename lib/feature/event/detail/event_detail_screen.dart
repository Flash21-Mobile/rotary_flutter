import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/data/model/event_model.dart';
import 'package:rotary_flutter/feature/event/event_view_model.dart';
import 'package:rotary_flutter/util/model/loadstate.dart';
import 'package:rotary_flutter/util/secure_storage.dart';

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
  var isAdmin = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkAdmin();
    });
  }

  void checkAdmin() async {
    var data = (await globalStorage.read(key: 'admin')) == 'admin';

    setState(() => isAdmin = data);
  }

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
              Navigator.pop(context);
            },
          ),
          actions: [
            ...?isAdmin
                ? [
                    Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: InkWell(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: GlobalColor.primaryColor),
                            child: Text(
                              '삭제',
                              style: TextStyle(color: GlobalColor.white),
                            ),
                          ),
                          onTap: () async {
                            var response = await ref
                                .read(EventProvider)
                                .deleteEvent(widget.event.id ?? 0);
                            if (response is Success) {
                              Navigator.pop(context);
                            }
                          },
                        ))
                  ]
                : null
          ],
        ),
        body: Column(children: [
          Expanded(
              child: Column(
            children: [
              ScrollablePinchView(
                child: Padding(
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
                          Divider(
                            height: 0.5,
                            thickness: 0.5,
                            color: GlobalColor.greyFontColor,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          IndexMinText(
                            '${formatDateTime(widget.event.time)}',
                            textColor: GlobalColor.greyFontColor,
                          )
                        ])),
              )
            ],
          ))
        ]));
  }

  String formatDateTime(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) return ''; // null이나 빈 값 처리
    DateTime parsedDate = DateTime.parse(dateTime);
    return "${parsedDate.year}.${parsedDate.month.toString().padLeft(2, '0')}.${parsedDate.day.toString().padLeft(2, '0')} - "
        "${parsedDate.hour.toString().padLeft(2, '0')}:${parsedDate.minute.toString().padLeft(2, '0')}";

  }
}
