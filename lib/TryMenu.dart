import 'package:blantt_love_test/dt_image.dart';
import 'package:flutter/material.dart';
import 'package:blantt_love_test/testView.dart';
import 'package:blantt_love_test/BarView.dart';
import 'package:blantt_love_test/ListView.dart';
import 'package:blantt_love_test/dt_rounter.dart';
import 'package:blantt_love_test/myConn.dart';
import 'package:blantt_love_test/dt_Dialog.dart';
import 'package:blantt_love_test/selectTime.dart';
import 'package:blantt_love_test/selectDate.dart';
import 'package:blantt_love_test/testButton.dart';
import 'package:blantt_love_test/dt_layout.dart';
import 'package:blantt_love_test/textForm.dart';
import 'package:blantt_love_test/testForm2.dart';
import 'package:blantt_love_test/testconn.dart';
import 'ListPerson.dart';
import 'BScreen.dart';
import 'package:blantt_love_test/testListSch.dart';
import 'package:blantt_love_test/ListPerson2.dart';

void main() {
  runApp(MyTryMenu());
}

class MyTryMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ccc',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _PageState2 createState() => _PageState2();
}

class _PageState2 extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // void onPressToNextScreen() {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => MyListPerson(value: "我是從 A 傳來的資料2!"),
    //     ),
    //   );
    // }

    void onPressToNextScreen() async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyListPerson(value: "我是從 A 傳來的資料2!"),
        ),
      );
      //從 B 畫面回傳後更新畫面資料
      setState(() {
        if (result != null) {
          print(result);
        }
      });
    }

    return Scaffold(
        appBar: AppBar(
          //leading: Icon(Icons.arrow_back),
          backgroundColor: Color.fromRGBO(56, 163, 210, 1.0),
          title: Text(
            'testmenu',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                // color: Colors.black54,
                fontSize: 18),
          ),
        ),
        // body: buildLivtView_Kind(context));
        //  body: _body(context));
        body: SingleChildScrollView(
          child: Center(
              child: Column(children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 65, 0, 0),
            ),
            OutlinedButton(
              child: Text(
                'listviewSch2',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => listSch2()));
              },
            ),
            OutlinedButton(
              child: Text(
                '人員選單',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: onPressToNextScreen,
            ),
            OutlinedButton(
              child: Text(
                'login in',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => testview()));
              },
            ),
            OutlinedButton(
              child: Text(
                'menu bar',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => barview()));
              },
            ),
            OutlinedButton(
              child: Text(
                'listview',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyListView()));
              },
            ),
            OutlinedButton(
              child: Text(
                'MyRunter',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyRunter()));
              },
            ),
            OutlinedButton(
              child: Text(
                'MyRImage',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Myimage()));
              },
            ),
            OutlinedButton(
              child: Text(
                '連線測試',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => menu_conn()));
              },
            ),
            OutlinedButton(
              child: Text(
                '彈跳視窗',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => classDialog()));
              },
            ),
            OutlinedButton(
              child: Text(
                'selectTime',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => classSelectTime()));
              },
            ),
            OutlinedButton(
              child: Text(
                'selectDate',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => selectDate()));
              },
            ),
            OutlinedButton(
              child: Text(
                'testbutton',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => testButton()));
              },
            ),
            OutlinedButton(
              child: Text(
                'layout',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => templayout()));
              },
            ),
            OutlinedButton(
              child: Text(
                'testconn',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RandomArticle()));
              },
            ),
            OutlinedButton(
              child: Text(
                '測試表單',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => testform()));
              },
            ),
            OutlinedButton(
              child: Text(
                '測試表單2',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => testform2()));
              },
            ),
            OutlinedButton(
              child: Text(
                'listviewSch',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage_list()));
              },
            ),
          ])),
        ));
  }
}
