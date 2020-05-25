import 'package:atopicnote/parts/original_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputCondition extends StatefulWidget {
  @override
  _InputConditionState createState() => _InputConditionState();
}

class _InputConditionState extends State<InputCondition> {
  String _inputDate = "日付入力";
  DateTime datetime;

//TODO bottomNavigationBarはclassで外出しして作成（本来の実装方法ではないっぽいが）
  //TODO このままの作り方だと、画面遷移時のアニメーションが残っていることが課題
//  int _screens = 0;
//  List<BottomNavigationBarItem> myBottomNavigationBar() {
//    return [
//      BottomNavigationBarItem(
//        icon: Icon(Icons.create),
//            title: Text("入力"),
//      ),
//      BottomNavigationBarItem(
//        icon: Icon(Icons.format_list_bulleted),
//        title: Text("リスト"),
//      ),
//      BottomNavigationBarItem(
//        icon: Icon(Icons.show_chart),
//        title: Text("グラフ"),
//      ),
//    ];
//  }

  TextEditingController _controller;

  List<DropdownMenuItem<int>> _menuItems = List();
  int _menuItem_0 = 0;
  int _menuItem_1 = 1;
  int _menuItem_2 = 2;
  int _menuItem_3 = 3;
  int _menuItem_4 = 4;
  int _menuItem_5 = 5;

  int _numberOfSkin = 0;
  int _numberOfMeal = 0;
  int _numberOfDefecation = 0;
  int _numberOfSleep = 0;
  int _numberOfExercise = 0;
  int _numberOfStress = 0;

  @override
  void initState() {
    super.initState();
    _setMenuItems();
    _numberOfSkin = _menuItems[0].value;
    _numberOfMeal = _menuItems[0].value;
    _numberOfDefecation = _menuItems[0].value;
    _numberOfSleep = _menuItems[0].value;
    _numberOfExercise = _menuItems[0].value;
    _numberOfStress = _menuItems[0].value;
  }

  void _setMenuItems() {
    _menuItems..add(DropdownMenuItem(
      value: _menuItem_0,
      child: Text("ー", style: TextStyle(color: Colors.black),),
    ))..add(DropdownMenuItem(
        value: _menuItem_1,
        child: Text(_menuItem_1.toString(),
          style: TextStyle(color: Colors.black),)))..add(DropdownMenuItem(
        value: _menuItem_2,
        child: Text(_menuItem_2.toString(),
          style: TextStyle(color: Colors.black),)))..add(DropdownMenuItem(
        value: _menuItem_3,
        child: Text(_menuItem_3.toString(),
          style: TextStyle(color: Colors.black),)))..add(DropdownMenuItem(
        value: _menuItem_4,
        child: Text(_menuItem_4.toString(),
          style: TextStyle(color: Colors.black),)))..add(DropdownMenuItem(
        value: _menuItem_5,
        child: Text(
          _menuItem_5.toString(), style: TextStyle(color: Colors.black),)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SizedBox(
          width: 250.0,
          child: FlatButton.icon(
            shape: StadiumBorder(),
            color: Colors.black45,
            icon: Icon(Icons.today, color: Colors.white,),
            label: Text(
              _inputDate,
              style: TextStyle(fontSize: 15.0, color: Colors.white),
            ),
            onPressed: () => _datePicker(context),
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: null, //TODO
            tooltip: "登録",
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
//            _conditionDate(),
              //TODO 以下のメソッドをリファクタリングしたい。引数で_numbeOfSkinとか渡せればできそうなのに、変数ではなく、値として処理されるため思った挙動にならない。不服だけど今はこのまま進。,
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: _inputSkin("肌の調子は？"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: _inputMeal("食生活は？"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: _inputDefecation("排便は？"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: _inputSleep("睡眠は？"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: _inputExercise("運動は？"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: _inputStress("ストレスは？"),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 30.0),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "メモ",
                    style: TextStyle(fontSize: 15.0),
                  )),
              _inputComment(),
              SizedBox(height: 45.0,),
              _buttonOfRegister(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: OriginalBottomNavigationBar(screens: 0,),
//      bottomNavigationBar: bottomNavigationBar(),
    );
  }

//  Widget _conditionDate() {
//    return Column(
//      children: <Widget>[
//        RaisedButton(
//          child: Text("日付入力"),
//          onPressed: () => _datePicker(context),
//        ),
//        Text(_inputDate, style: TextStyle(fontSize: 30.0),),
//        SizedBox(height: 20.0,)
//      ],
//    );
//  }

  Future<void> _datePicker(BuildContext context) async {
    datetime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime
          .now()
          .year),
      lastDate: DateTime(DateTime
          .now()
          .year + 6),
    );

    if (datetime != null) {
      setState(() {
        _inputDate = DateFormat("yyyy/MM/dd/EEE").format(datetime);
      });
    }
  }

  Widget _inputSkin(String text) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Icon(Icons.face),
          _textPart(text),
          Expanded(
            flex: 1,
            child: Center(
              child: DropdownButton(
                items: _menuItems,
                value: _numberOfSkin,
                style: TextStyle(fontSize: 20.0),
                onChanged: (selectedValue) {
                  setState(() {
                    _numberOfSkin = selectedValue;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _inputMeal(String text) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Icon(Icons.fastfood),
          _textPart(text),
          Expanded(
            flex: 1,
            child: Center(
              child: DropdownButton(
                items: _menuItems,
                value: _numberOfMeal,
                style: TextStyle(fontSize: 20.0),
                onChanged: (selectedValue) {
                  setState(() {
                    _numberOfMeal = selectedValue;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _inputDefecation(String text) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Icon(Icons.airline_seat_legroom_normal),
          _textPart(text),
          Expanded(
            flex: 1,
            child: Center(
              child: DropdownButton(
                items: _menuItems,
                value: _numberOfDefecation,
                style: TextStyle(fontSize: 20.0),
                onChanged: (selectedValue) {
                  setState(() {
                    _numberOfDefecation = selectedValue;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _inputSleep(String text) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Icon(Icons.local_hotel),
          _textPart(text),
          Expanded(
            flex: 1,
            child: Center(
              child: DropdownButton(
                items: _menuItems,
                value: _numberOfSleep,
                style: TextStyle(fontSize: 20.0),
                onChanged: (selectedValue) {
                  setState(() {
                    _numberOfSleep = selectedValue;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _inputExercise(String text) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Icon(Icons.directions_run),
          _textPart(text),
          Expanded(
            flex: 1,
            child: Center(
              child: DropdownButton(
                items: _menuItems,
                value: _numberOfExercise,
                style: TextStyle(fontSize: 20.0),
                onChanged: (selectedValue) {
                  setState(() {
                    _numberOfExercise = selectedValue;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _inputStress(String text) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Icon(Icons.cloud),
          _textPart(text),
          Expanded(
            flex: 1,
            child: Center(
              child: DropdownButton(
                items: _menuItems,
                value: _numberOfStress,
                style: TextStyle(fontSize: 20.0),
                onChanged: (selectedValue) {
                  setState(() {
                    _numberOfStress = selectedValue;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _textPart(String text) {
    return Expanded(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text(
            text,
            style: TextStyle(fontSize: 15.0),
          ),
        ));
  }

  Widget _inputComment() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: SizedBox(
        width: double.infinity,
        child: TextField(
          keyboardType: TextInputType.text,
          controller: _controller,
        ),
      ),
    );
  }

  Widget _buttonOfRegister() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton.icon(
            shape: StadiumBorder(),
            color: Colors.red,
            onPressed: () => print("登録"),
            icon: Icon(Icons.done_outline, color: Colors.white,),
            label: Text("登録", style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w600),)),
      ),
    );
  }

//TODO bottomNavigationBarはclassで外出しして
//  Widget bottomNavigationBar() {
//    return BottomNavigationBar(
//      items: myBottomNavigationBar(),
//      currentIndex: _screens,
//      onTap: (index) {
//        if (index == 0) return;
//        if (index == 1) {
//          Navigator.push(context, MaterialPageRoute(builder: (context) => ListScreen()));
//        }
//        if (index == 2) {
//          Navigator.push(context, MaterialPageRoute(builder: (context) => ChartScreen()));
//        }
//      },
//    );
//  }


//TODO リファクタリングできたと思ったけど思った通り動かず・・・いつか解決したい
//  Widget _inputNumbers(String text, int data) {
//    return SizedBox(
//      width: double.infinity,
//      child: Row(
//        children: <Widget>[
//          _textPart(text),
//          Expanded(
//            flex: 1,
//            child: Center(
//              child: DropdownButton(
//                items: _menuItems,
//                value: data,
//                style: TextStyle(fontSize: 20.0),
//                onChanged: (selectedValue) {
//                  if (data == _numberOfSkin) {
//                    _numberOfSkin = selectedValue;
//                    return;
//                  }
//                  if (data == _numberOfMeal){
//                    _numberOfMeal = selectedValue;
//                    return;
//                  }
//                  if (data == _numberOfDefecation) {
//                    _numberOfDefecation = selectedValue;
//                    return;
//                  }
//                  print(data);
//                  setState(() {
//                  });
//                },
//              ),
//            ),
//          )
//        ],
//      ),
//    );
//  }

}