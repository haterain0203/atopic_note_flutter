import 'package:atopicnote/parts/original_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("リスト"),
      ),
      body: Container(
        color: Colors.red,
        width: double.infinity,
        height: double.infinity,
      ),
      bottomNavigationBar: OriginalBottomNavigationBar(screens: 1,),
    );
  }

}
