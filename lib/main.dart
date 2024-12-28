import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/util/global_color.dart';
import 'feature/home_screen.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'rotary',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: GlobalColor.primaryColor,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          elevation: 0.0,
          backgroundColor: GlobalColor.white,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: GlobalColor.primaryColor),
        useMaterial3: false,
      ),
      home: HomeScreen(),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.linear(1.0),
        ),
        child: child!,
      ),
    );
  }
}