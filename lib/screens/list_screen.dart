import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodmanagement/db/database.dart';
import 'package:foodmanagement/main.dart';
import 'package:foodmanagement/screens/edit_screen.dart';
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
//  int _radioSelected = 0;
  List<Word> _wordList = List();
  bool _isLimitOfFood = false;
  bool _isSortAsc = false;

  int _nowYear = DateTime.now().year;
  int _nowMonth = DateTime.now().month;
  int _nowDay = DateTime.now().day;

  String _intDifferenceDate = "";

  @override
  void initState() {
    super.initState();
    _isSortAsc = true;
    _getAllWords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("食材リスト"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () => _changeOfSort(), //TODO
            tooltip: "降順/昇順切り替え",
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _goToEditPage(), //TODO
        backgroundColor: Colors.pink,
        tooltip: "追加",
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 8.0),
        child: _wordListWidget(),
      ),
    );
  }

//  Widget _list(String listName) {
//    return Padding(
//      padding: const EdgeInsets.symmetric(horizontal: 8.0),
//      child: SizedBox(
//        height: 80.0,
//        width: double.infinity,
//        child: Card(
//          color: Colors.white30,
//          child: ListTile(
//            title: Text(
//              listName,
//              style: TextStyle(fontSize: 20.0),
//            ),
//            onTap: () => _goToEditPage("編集"),
//            onLongPress: () => print("TODO2"),
//          ),
//        ),
//      ),
//    );
//  }

  _goToEditPage() {
    print("OK");
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => EditScreen(
                  status: EditStatus.ADD,
                )));
  }

  void _getAllWords() async {
    if (_isSortAsc) {
      _wordList = await database.allWordsAscendLimitOfFood;
    } else {
      _wordList = await database.allWordsDescendLimitOfFood;
    }
    setState(() {});
  }

  Widget _wordListWidget() {
    return ListView.builder(
      itemCount: _wordList.length,
      itemBuilder: (context, int position) => _wordItem(position),
    );
  }

  Widget _wordItem(int position) {
    //賞味期限が残り2日のものにフラグをつける。賞味期限までの残り日数を調べる。
    _limitOfFoodFlagAndDaysLeft(position);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: _isLimitOfFood ? Colors.red[300] : Colors.white30,
      child: ListTile(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "${_wordList[position].strFoodName}",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
//                  Text("${DateFormat("yyyy/MM/dd").format(_wordList[position].dateFoodOfLimit)}"),
              Row(
                children: <Widget>[
                  Text(
                    "あと",
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    _intDifferenceDate,
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    "日",
                    style: TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
            ]),
//        subtitle: Text("${DateFormat("yyyy/MM/dd").format(_wordList[position].dateFoodOfLimit)}"),
        onLongPress: () => _deleteWord(_wordList[position]),
        onTap: () => _editWord(_wordList[position]),
      ),
    );
  }

  _deleteWord(Word selectedWord) async {
    await database.deleteWord(selectedWord);
    _getAllWords();
    Toast.show("削除しました", context, duration: Toast.LENGTH_LONG);
  }

  _editWord(Word selectedWord) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => EditScreen(
                  status: EditStatus.EDIT,
                  word: selectedWord,
                )));
  }

  //TODO 賞味期限順に並び替え
  void _changeOfSort() async {
    print("OK");
    if (_isSortAsc) {
      _wordList = await database.allWordsDescendLimitOfFood;
      _isSortAsc = false;
    } else {
      _wordList = await database.allWordsAscendLimitOfFood;
      _isSortAsc = true;
    }
    setState(() {});
  }

  //1、賞味期限が残り2日のものは赤色にするために変数にtrue/falseを設定。2、賞味期限までの残り日数計算
  void _limitOfFoodFlagAndDaysLeft(position) {
    var _nowDate = DateTime(_nowYear, _nowMonth, _nowDay);
    var _addOneDayFromNow = DateTime(_nowYear, _nowMonth, _nowDay + 1);

    var _cardYear = _wordList[position].dateFoodOfLimit.year;
    var _cardMonth = _wordList[position].dateFoodOfLimit.month;
    var _cardDay = _wordList[position].dateFoodOfLimit.day;
    var _cardDate = DateTime(_cardYear, _cardMonth, _cardDay);

    if (_cardDate.isBefore(_nowDate) ||
        _cardDate == _nowDate ||
        _cardDate == _addOneDayFromNow) {
      _isLimitOfFood = true;
    } else {
      _isLimitOfFood = false;
    }

    var _differenceDate = _cardDate.difference(_nowDate);
    _intDifferenceDate = (_differenceDate.inDays).toString();
  }

//ラジオボタン
//  Widget _radioButton() {
//    return Column(
//      children: <Widget>[
//        RadioListTile(
//          value: 0,
//          groupValue: _radioSelected,
//          onChanged: (value) => _onSelectedRadio(value),
//          title: Text("選択肢1"),
//        ),
//        RadioListTile(
//          value: 1,
//          groupValue: _radioSelected,
//          onChanged: (value) => _onSelectedRadio(value),
//          title: Text("選択肢2"),
//        ),
//        RadioListTile(
//          value: 2,
//          groupValue: _radioSelected,
//          onChanged: (value) => _onSelectedRadio(value),
//          title: Text("選択肢2"),
//        ),
//      ],
//    );
//  }
//
//  _onSelectedRadio(value) {
//    setState(() {
//      _radioSelected = value;
//      print(value);
//    });
//  }
//

}
