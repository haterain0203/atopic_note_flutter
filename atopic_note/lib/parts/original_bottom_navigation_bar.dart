import 'package:atopicnote/screens/chart_screen.dart';
import 'package:atopicnote/screens/input_condition.dart';
import 'package:atopicnote/screens/list_screen.dart';
import 'package:flutter/material.dart';

//TODO bottomNavigationBarはclassで外出しして作成（本来の実装方法ではないっぽいが）
//TODO このままの作り方だと、画面遷移時のアニメーションが残っていることが課題

class OriginalBottomNavigationBar extends StatelessWidget {
  final int screens;

  OriginalBottomNavigationBar({@required this.screens});

  List<BottomNavigationBarItem> myBottomNavigationBar() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.create),
        title: Text("入力"),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.format_list_bulleted),
        title: Text("リスト"),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.show_chart),
        title: Text("グラフ"),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: myBottomNavigationBar(),
      currentIndex: screens,
      onTap: (index) {
        if (index == 0) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => InputCondition()));
        }
        if (index == 1) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ListScreen()));
        }
        if (index == 2) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChartScreen()));
        }
      },
    );
  }
}
