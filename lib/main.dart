import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rotary_flutter/util/global_color.dart';
import 'feature/home_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  initializeDateFormatting()
      .then((_) => runApp(const ProviderScope(child: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('ko', 'KR'),
      supportedLocales: const [
        Locale('ko', 'KR'),
      ],
      title: 'rotary',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
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
        // data: MediaQuery.of(context).copyWith(
        //   textScaler: MediaQuery.textScalerOf(context).clamp(
        //     minScaleFactor: 1.0, // 최소 스케일 팩터
        //     maxScaleFactor: 1.0, // 최대 스케일 팩터
        //   ),
        // ),
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.linear(1.0),
        ),
        child: child!,
      ),
    );
  }
}
