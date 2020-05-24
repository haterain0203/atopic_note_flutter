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
      body: Column(
        children: <Widget>[
          _conditionDate(),
          _inputNumbers("肌の調子は？", _numberOfSkin),
          _inputNumbers("食生活は？", _numberOfMeal),
          _inputNumbers("お通じは？", _numberOfDefecation),
          _inputNumbers("睡眠は？", _numberOfSleep),
          _inputNumbers("運動は？", _numberOfExercise),
          _inputNumbers("ストレスは？", _numberOfStress),
          _inputComment(),
        ],
      ),
    );
  }

  Widget _conditionDate() {
    return Row(
      children: <Widget>[
        Text(_inputDate),
        RaisedButton(
          child: Text("日付入力"),
          onPressed: () => _datePicker(context), //TODO datepicker実装
        ),
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
        _inputDate = DateFormat("yyyy/MM/dd").format(datetime);
      });
    }
  }

  Widget _inputNumbers(String text, int value) {
    return Row(
      children: <Widget>[
        Text(text),
        DropdownButton(
          items: _menuItems,
          value: value,
          onChanged: (selectedValue) {
            setState(() {
              value = selectedValue;
            });
          },
        )
      ],
    );
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
