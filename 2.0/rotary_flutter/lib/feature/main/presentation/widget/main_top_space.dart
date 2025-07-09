import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainTopSpace extends StatelessWidget {

  const MainTopSpace({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData? mediaQuery = MediaQuery.maybeOf(context);
    if (mediaQuery == null) {
      return SizedBox();
    }
    return SizedBox(
      height: mediaQuery.padding.top,
    );
  }
}
