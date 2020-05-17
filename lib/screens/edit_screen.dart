import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodmanagement/db/database.dart';
import 'package:foodmanagement/main.dart';
import 'package:foodmanagement/screens/list_screen.dart';
import 'package:toast/toast.dart';
import 'package:moor_ffi/database.dart';
import 'package:intl/intl.dart';

enum EditStatus { ADD, EDIT }

class EditScreen extends StatefulWidget {
  final EditStatus status;
  final Word word;

  EditScreen({@required this.status, this.word});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController _inputFoodController = TextEditingController();
  DateTime datetime;

  String _pageTitle = "";
  String _dateText = "";
  bool _isEnabledInput = false;

  @override
  void initState() {
    super.initState();
    if (widget.status == EditStatus.ADD) {
      _pageTitle = "新規登録";
      _isEnabledInput = true;
      return;
    }
    if (widget.status == EditStatus.EDIT) {
      _pageTitle = "編集";
      _inputFoodController.text = widget.word.strFoodName;
      _dateText = DateFormat("yyyy/MM/dd").format(widget.word.dateFoodOfLimit);
      _isEnabledInput = false;
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => _backToListScreen(),
        ),
        title: Text(_pageTitle),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            tooltip: "登録",
            onPressed: () => _registerWord(),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            _inputFood(),
            SizedBox(
              height: 50.0,
            ),
            _inputLimitOfFood(),
          ],
        ),
      ),
    );
  }

  _backToListScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ListScreen()));
  }

  Widget _inputFood() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Text(
            "食材",
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextField(
            decoration: InputDecoration(hintText: "食材を入力して下さい", hintStyle: TextStyle(fontSize: 15.0)),
            enabled: _isEnabledInput,
            keyboardType: TextInputType.text,
            controller: _inputFoodController,
            style: TextStyle(fontSize: 30.0),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Widget _inputLimitOfFood() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Text(
            "賞味期限",
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(child: Text(_dateText, style: TextStyle(fontSize: 30.0),)),
          SizedBox(height: 20.0,),
          SizedBox(
//            width: double.infinity,
            child: RaisedButton(
              child: Text("日付入力"),
              onPressed: () => _selectDate(context), //TODO
            ),
          ),
//          TextField(
//            keyboardType: TextInputType.text,
//            controller: _inputLimitController,
//            style: TextStyle(fontSize: 20.0),
//            textAlign: TextAlign.center,
//          )
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
        datetime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2100));

    if (datetime != null) {
      setState(() {
        _dateText = DateFormat("yyyy/MM/dd").format(datetime);
      });
    }
  }

  _registerWord() {
    if (widget.status == EditStatus.ADD) {
      _insertWord();
      return;
    }
    if (widget.status == EditStatus.EDIT) {
      _editWord();
      return;
    }
  }

  _insertWord() async {
    if (_inputFoodController.text == "" || _dateText == "") {
      //TODO NGの時の対応
      Toast.show("食材名と賞味期限を両方入力してください", context, duration: Toast.LENGTH_LONG);
      return;
    }
//    datetime = DateTime.parse(_inputLimitController.text);
    var word = Word(
      strFoodName: _inputFoodController.text,
      dateFoodOfLimit: datetime,
    );

    //食材名をプライマリキーに設定しているため、同じ食材名は登録できない
    try {
      await database.addWord(word);
      _inputFoodController.clear();
      _dateText = "";
      //登録完了メッセージ
      Toast.show("登録完了しました", context, duration: Toast.LENGTH_LONG);
      setState(() {

      });
    } on SqliteException catch (e) {
      Toast.show("この食材はすでに登録されています", context, duration: Toast.LENGTH_LONG);
    }
  }

  void _editWord() async {
    if (_inputFoodController.text == "" || _dateText == "") {
      //TODO NGの時の対応
      Toast.show("食材と賞味期限を両方入力してください", context, duration: Toast.LENGTH_LONG);
      return;
    }

    var word = Word(
      strFoodName: _inputFoodController.text,
      dateFoodOfLimit: datetime,
    );

    try {
      await database.updateWord(word);
      Toast.show("修正が完了しました", context, duration: Toast.LENGTH_LONG);
      _backToListScreen();
    } on SqliteException catch (e) {
      Toast.show("何かのエラーにより登録できませんでした", context, duration: Toast.LENGTH_LONG);
      return;
    }
  }


  }

//  Widget _inputFoodName(TextEditingController controller, String inputTitle) {
//    return Padding(
//      padding: const EdgeInsets.symmetric(horizontal: 20.0),
//      child: Column(
//        children: <Widget>[
//          Text("食材名", style: TextStyle(fontSize: 20.0),),
//          SizedBox(height: 20.0,),
//          TextField(
//            keyboardType: TextInputType.text,
//            controller: _inputFoodController,
//            style: TextStyle(fontSize: 20.0),
//            textAlign: TextAlign.center,
//          )
//        ],
//      ),
//    );
//  }

//  Widget _inputLimitOfFood() {
//    return Padding(
//      padding: const EdgeInsets.symmetric(horizontal: 20.0),
//      child: Column(
//        children: <Widget>[
//          Text("賞味期限", style: TextStyle(fontSize: 20.0)),
//          SizedBox(height: 20.0,),
//          TextField(
//            keyboardType: TextInputType.datetime,
//            controller: _inputLimitController,
//            style: TextStyle(fontSize: 20.0),
//            textAlign: TextAlign.center,
//          ),
//        ],
//      ),
//    );
//  }
