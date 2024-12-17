import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/feature/home/home_component.dart';
import 'package:rotary_flutter/util/fontSize.dart';
import 'package:rotary_flutter/util/global_color.dart';

class OrganizationScreen extends ConsumerStatefulWidget {
  const OrganizationScreen({super.key});

  @override
  ConsumerState<OrganizationScreen> createState() => _OrganizationScreen();
}

class _OrganizationScreen extends ConsumerState<OrganizationScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalColor.white,
        appBar: AppBar(
          title: Text('지구임원'),
          centerTitle: true,
        ),
        body:ScrollablePinchView(
    child: Image.asset(
    'asset/images/menu/organization_image.jpg',
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,),));
  }
}
