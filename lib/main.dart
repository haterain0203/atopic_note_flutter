import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:foodmanagement/db/database.dart';
import 'package:foodmanagement/screens/home_screen.dart';

import 'screens/list_screen.dart';

MyDatabase database;

void main() {
  database = MyDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ja', 'JP'),
      ],
      title: "食材管理ツール",
      theme: ThemeData(
        brightness: Brightness.light,
//        fontFamily: "sp",
//        fontFamily: "Boku2",
      ),
      home: HomeScreen(),
    );
  }
}
