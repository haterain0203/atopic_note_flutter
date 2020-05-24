import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputCondition extends StatefulWidget {
  @override
  _InputConditionState createState() => _InputConditionState();
}

class _InputConditionState extends State<InputCondition> {
  String _inputDate = "";
  DateTime datetime;

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
    _menuItems
      ..add(DropdownMenuItem(
        value: _menuItem_0,
        child: Text("ー"),
      ))
      ..add(DropdownMenuItem(
          value: _menuItem_1, child: Text(_menuItem_1.toString())))
      ..add(DropdownMenuItem(
          value: _menuItem_2, child: Text(_menuItem_2.toString())))
      ..add(DropdownMenuItem(
          value: _menuItem_3, child: Text(_menuItem_3.toString())))
      ..add(DropdownMenuItem(
          value: _menuItem_4, child: Text(_menuItem_4.toString())))
      ..add(DropdownMenuItem(
          value: _menuItem_5, child: Text(_menuItem_5.toString())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("記録"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: null, //TODO
            tooltip: "登録",
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            _conditionDate(),
            //TODO 以下のメソッドをリファクタリングしたい。引数で_numbeOfSkinとか渡せればできそうなのに、変数ではなく、値として処理されるため思った挙動にならない。不服だけど今はこのまま進。
            _inputSkinCondition(),
            _inputMealCondition(),
            _inputDefecation(),
            _inputSleep(),
            _inputExercise(),
            _inputStress(),
            _inputComment(),
          ],
        ),
      ),
    );
  }

  Widget _conditionDate() {
    return Column(
      children: <Widget>[
        RaisedButton(
          child: Text("日付入力"),
          onPressed: () => _datePicker(context),
        ),
        Text(_inputDate, style: TextStyle(fontSize: 30.0),),
        SizedBox(height: 20.0,)
      ],
    );
  }

  Future<void> _datePicker(BuildContext context) async {
    datetime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 6),
    );

    if (datetime != null) {
      setState(() {
        _inputDate = DateFormat("yyyy/MM/dd/(EEE)").format(datetime);
      });
    }
  }

  Widget _inputSkinCondition() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: <Widget>[
          _textPart("肌の調子は？"),
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

  Widget _inputMealCondition() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: <Widget>[
          _textPart("食生活は？"),
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

  Widget _inputDefecation() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: <Widget>[
          _textPart("排便は？"),
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

  Widget _inputSleep() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: <Widget>[
          _textPart("睡眠は？"),
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

  Widget _inputExercise() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: <Widget>[
          _textPart("運動は？"),
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

  Widget _inputStress() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: <Widget>[
          _textPart("ストレスは？"),
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
        child: Center(
            child: Text(
          text,
          style: TextStyle(fontSize: 20.0),
        )));
  }

  Widget _inputComment() {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        keyboardType: TextInputType.text,
        controller: _controller,
      ),
    );
  }
}
