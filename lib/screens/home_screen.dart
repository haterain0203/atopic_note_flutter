import 'package:flutter/material.dart';
import 'package:foodmanagement/screens/list_screen.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:path/path.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("食材管理"),
//          backgroundColor: Colors,
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
          Center(child: Image.asset("assets/images/refrigerator_white.png", width: double.infinity, height: double.infinity,)),
//            Padding(
//              padding: const EdgeInsets.all(20.0),
//              child: Center(child: Image.asset("assets/images/refrigerator_gray.png")),
//            ),
//            Center(child: Image.asset("assets/images/refrigerator_gray_2.png")),
            Center(
              child: Column(
                children: <Widget>[
//                  SizedBox(height: 150.0,),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: FlatButton(
                        child: Text(""),
                        onPressed: () => _goToListScreen(context),
                      ),
                    ),
                  ),
//                  _buttonOfVegetables(context),
//                  SizedBox(height: 150.0,),
//                  _buttonOfVegetables(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//  Widget _buttonOfOthers() {
//    return Padding(
//      padding: const EdgeInsets.symmetric(horizontal: 100.0),
//      child: SizedBox(
//        width: double.infinity,
//        child: RaisedButton(
//          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//          child: Text("タップ", style: TextStyle(fontSize: 30.0),),
//          color: Colors.amberAccent,
//          onPressed: () => print("OK"),
//        ),
//      ),
//    );
//  }

  Widget _buttonOfVegetables(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 150.0),
      child: ImageButton(
        children: <Widget>[],
        width: 120,
        height: 80,
        paddingTop: 5,
        pressedImage: Image.asset(
          "assets/images/tap.png",
        ),
        unpressedImage: Image.asset("assets/images/tap.png"),
        onTap: () => _goToListScreen(context),
      ),
    );
//    return Padding(
//      padding: const EdgeInsets.symmetric(horizontal: 100.0),
//      child: SizedBox(
//        width: double.infinity,
//        child: RaisedButton(
//          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
//          child: Text("tap", style: TextStyle(fontSize: 30.0),),
//          color: Colors.lightGreen,
//          onPressed: () => print("OK"),
//        ),
//      ),
//    );
  }

  _goToListScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ListScreen()));
  }
}
