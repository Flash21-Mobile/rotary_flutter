import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/feature/home/home_main_component.dart';
import 'package:rotary_flutter/util/fontSize.dart';
import 'package:rotary_flutter/util/global_color.dart';

import '../../home_provider.dart';

class AllocationTableScreen extends ConsumerStatefulWidget {
  const AllocationTableScreen({super.key});

  @override
  ConsumerState<AllocationTableScreen> createState() =>
      _AllocationTableScreen();
}

class _AllocationTableScreen extends ConsumerState<AllocationTableScreen> {
  final List<int> events = [];
  bool isPinch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalColor.white,
        appBar: AppBar(
          title: Text('배점표'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              ref.read(HomeProvider).popCurrentWidget();
            },
          ),
        ),
        body: ScrollablePinchView(
            child: Stack(children: [
          Container(height: 600, child: Center(child: CircularProgressIndicator())),
          Image.asset(
            'asset/images/menu/allocation_table_image.jpg',
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          )])));
  }
}
