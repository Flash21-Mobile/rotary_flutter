import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rotary_flutter/data/model/event_model.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';
import 'package:rotary_flutter/util/global_color.dart';

class EventTile extends StatelessWidget {
  final EventModel event;
  final Function() onTap;

  const EventTile({super.key, required this.onTap, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: GlobalColor.indexBoxColor,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Row(children: [
        IndexText(event.title, textColor: GlobalColor.black,),
        Spacer(),
        Icon(Icons.arrow_forward_ios_rounded,size: 15,)
      ],),
    );
  }
}