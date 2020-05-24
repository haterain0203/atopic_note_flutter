import 'package:atopicnote/screens/input_condition.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Atopic-Note",
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: InputCondition(),
    );
  }
}
