import 'dart:ffi';

import 'package:blantt_love_test/ListView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:blantt_love_test/testView.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:blantt_love_test/myConn.dart';
import 'package:blantt_love_test/testButton.dart';
import 'package:blantt_love_test/routesPage.dart';
import 'Model/Model1.dart';

//我喜歡這種表單樣式,先紀錄起來
//https://www.kindacode.com/article/adding-borders-to-cards-in-flutter/
//不錯的做法! https://www.youtube.com/watch?v=4tG8M4wK4F0
void main() {
  runApp(MyListView());
}

class MyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter App Learning',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        routes: RoutePath,
        home: MyHomePage2());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class MyHomePage2 extends StatefulWidget {
  MyHomePage2({Key? key}) : super(key: key);
  @override
  _MyHomePageState2 createState() => _MyHomePageState2();
}

class User {
  final String username;
  final String email;
  final String myUrl;

  const User(
      {required this.username, required this.email, required this.myUrl});
}

List<User> users = [
  const User(username: 'PP', email: 'dd', myUrl: 'MM'),
  const User(username: 'PP2', email: 'dd', myUrl: 'MM')
];

//Modal_Kind 假別
List<Modal_Kind> list_Modal_Kind = [Modal_Kind(name1: 'aaa', name2: 'aaa')];

//Modal_Kind 假別
class Modal_Kind {
  Modal_Kind({
    required this.name1,
    required this.name2,
  });

  String name1;
  String name2;

  factory Modal_Kind.fromJson(Map<String, dynamic> json) => Modal_Kind(
        name1: json["name1"],
        name2: json["name2"],
      );

  Map<String, dynamic> toJson() => {
        "name1": name1,
        "name2": name2,
      };
}

Future<String> GetDateLeaveSch() async {
  // return Future.delayed(Duration(seconds: 2), () => "我是从互联网上获取的数据");
  // getHttp();
  //return Future.delayed(Duration(seconds: 5), () => "我是从互联网上获取的数据");
  final response = await Dio().get(m_url_LeaveSch + '/all');
  String sss = "";
  //if (response.statusCode == HttpStatus.ok) {
  list_Modal_LeaveSch2 = (response.data as List<dynamic>)
      .map((e) => Modal_LeaveSch2.fromJson((e as Map<String, dynamic>)))
      .toList();

  //print(list[1].name2);
  //  return "";
  //}
  return "";
}

Future<String> GetDataKind() async {
  // return Future.delayed(Duration(seconds: 2), () => "我是从互联网上获取的数据");
  // getHttp();
  //return Future.delayed(Duration(seconds: 5), () => "我是从互联网上获取的数据");
  final response = await Dio().get(m_url_ClocjClass);
  String sss = "";
  //if (response.statusCode == HttpStatus.ok) {
  list_Modal_Kind = (response.data as List<dynamic>)
      .map((e) => Modal_Kind.fromJson((e as Map<String, dynamic>)))
      .toList();
  //print(list[1].name2);
  //  return "";
  //}
  return "";
}

Widget build2(BuildContext context) {
  return Center(
    child: FutureBuilder<String>(
      future: GetDataKind(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // 请求已结束
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            // 请求失败，显示错误
            return Text("Error: ${snapshot.error}");
          } else {
            // 请求成功，显示数据
            return Text("Contents: ${snapshot.data}");
          }
        } else {
          // 请求未结束，显示loading
          return CircularProgressIndicator();
        }
      },
    ),
  );
}

Widget buildCell(
    int itype, double ww, double hh, String _value, double borderWidth) {
  Color _borderColor;
  Color _textColor;
  double _fontSize;
  FontWeight _fontweight;
  if (itype == 0) {
    _borderColor = Colors.amber;
    _textColor = Colors.white;
    _fontSize = 16;
    _fontweight = FontWeight.w600;
  } else {
    _borderColor = Colors.black12;
    _textColor = Color.fromRGBO(35, 86, 105, 1.0);
    _fontSize = 16;
    _fontweight = FontWeight.w500;
  }

  return Container(
    height: ww,
    width: hh,
    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),

    alignment: Alignment.centerRight,
    // padding: const EdgeInsets.only(
    //     top: 20, bottom: 20, left: 30, right: 70),
    decoration: BoxDecoration(
      //borderRadius: BorderRadius.all(Radius.circular(2)),
      border: Border(
        right: BorderSide(color: _borderColor, width: borderWidth),
      ),
    ),
    // child: Text(
    //   _value,
    //   style: TextStyle(
    //       fontSize: _fontSize, color: _textColor, fontWeight: _fontweight),
    // ),
    child: RichText(
      text: TextSpan(
        //outer span
        style: TextStyle(
            fontWeight: FontWeight.w400,
            color: _textColor,
            fontSize: _fontSize),
        text: _value,
      ),
    ),
  );
}

Widget buildLivtView_basic(BuildContext context) {
  return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Card(
          child: ListTile(
            title: Text(user.username),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => testview()));
            },
          ),
        );
      });
}

Widget _listCard_title(BuildContext context, String BatchID, String LeaveTypeN,
    String UserNameN, String MStatusN) {
  return Column(children: <Widget>[
    Container(
        padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
        //margin: EdgeInsets.fromLTRB(0, 120, 0, 0),
        height: 70,
        width: double.infinity,
        decoration: new BoxDecoration(
          // borderRadius: BorderRadius.circular(10.0),
          borderRadius: new BorderRadius.only(
            bottomRight: const Radius.circular(10.0),
            bottomLeft: const Radius.circular(10.0),
          ),
          border: Border(
              // left: BorderSide(width: 16.0, color: Colors.lightBlue.shade600),
              // bottom: BorderSide(width: 16.0, color: Colors.lightBlue.shade900),
              ),
          color: Colors.cyan,
        ),
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            buildCell(0, 30, 136, '單據號碼', 4),
            buildCell(0, 30, 85, '人員', 4),
            buildCell(0, 30, 70, '假別', 4),
            Expanded(child: buildCell(0, 30, 100, '單況', 0)),
            // Expanded(child: FlutterLogo()),
          ]),
          Row(children: <Widget>[
            buildCell(0, 30, 95, '傳送日期', 4),
            buildCell(0, 30, 95, '審核日期', 4),
            Expanded(child: buildCell(0, 30, 100, '請假日期', 0)),
            // Expanded(child: FlutterLogo()),
          ]),
        ])

        // child: Row(children: <Widget>[
        //   buildCell(0, 50, 136, '單據號碼', 2),
        //   buildCell(0, 50, 85, '人員', 2),
        //   buildCell(0, 50, 70, '假別', 2),
        //   Expanded(child: buildCell(0, 50, 100, '單況', 0)),
        //   // Expanded(child: FlutterLogo()),
        // ])
        ),
    _listCard_row(context, BatchID, LeaveTypeN, UserNameN, MStatusN)
    // _listCard(context, BatchID),
  ]);
}

//TODO cardrow
Widget _listCard_row(BuildContext context, String BatchID, String LeaveTypeN,
    String UserNameN, String MStatusN) {
  return Column(children: <Widget>[
    InkWell(
      child: Container(
        width: double.infinity,
        height: 70,
        alignment: Alignment.center,
        //padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.fromLTRB(0, 2, 0, 6),
        decoration: new BoxDecoration(
          //color: Colors.white,
          gradient: LinearGradient(
              colors: [Colors.white, Color.fromRGBO(197, 241, 248, 1)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.8,
                1,
              ]),
          //borderRadius: BorderRadius.all(Radius.circular(10.0)),
          border: new Border.all(
            width: 1,
            color: Colors.green,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: Offset(0, 6), // changes position of shadow
              spreadRadius: -3,
              blurRadius: 7,
            )
          ],
        ),

        child: Column(children: <Widget>[
          Row(children: <Widget>[
            buildCell(1, 30, 136, BatchID, 1),
            buildCell(1, 30, 85, UserNameN, 1),
            buildCell(1, 30, 70, LeaveTypeN, 1),
            Expanded(child: buildCell(1, 30, 100, MStatusN, 0)),
            // Expanded(child: FlutterLogo()),
          ]),
          Row(children: <Widget>[
            buildCell(1, 30, 95, '2022/01/01', 1),
            buildCell(1, 30, 95, '2022/03/01', 1),
            Expanded(child: buildCell(1, 30, 100, '2022/01/01~2022/05/05', 0)),
            // Expanded(child: FlutterLogo()),
          ]),
        ]),
      ),
      //TODO row點選時
      onTap: () {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => testButton()));
        Navigator.pushNamed(context, page3, arguments: PageSend(BatchID));
      },
    )

    // _listCard(context, BatchID),
  ]);
}

class PageSend {
  String BatchID;
  PageSend(this.BatchID);
}

Widget _listCard(BuildContext context, String BatchID) {
  return Card(
    child: ListTile(
      title: Text(BatchID),
      trailing: const Icon(Icons.arrow_forward),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => testview()));
      },
    ),
  );
}

//TODO now listview
Widget buildLivtView_LeaveSch(BuildContext context) {
  return FutureBuilder<String>(
    future: GetDateLeaveSch(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      // 请求已结束
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          // 请求失败，显示错误
          return Text("Error: ${snapshot.error}");
          //  return CircularProgressIndicator();
        } else {
          // 请求成功，显示数据
          return ListView.builder(
              itemCount: list_Modal_LeaveSch2.length,
              itemBuilder: (context, index) {
                final user = list_Modal_LeaveSch2[index];
                var row = list_Modal_LeaveSch2[index];
                if (index == 0) {
                  return _listCard_title(context, row.BatchID, row.LeaveTypeN,
                      row.UserNameN, row.MStatusN);
                } else {
                  return _listCard_row(context, row.BatchID, row.LeaveTypeN,
                      row.UserNameN, row.MStatusN);
                }
              });
        }
      } else {
        // 请求未结束，显示loading
        return new Center(child: CircularProgressIndicator());
        // return CircularProgressIndicator();
      }
    },
  );
}

Widget buildLivtView_Kind(BuildContext context) {
  return FutureBuilder<String>(
    future: GetDataKind(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      // 请求已结束
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          // 请求失败，显示错误
          return Text("Error: ${snapshot.error}");
          // return CircularProgressIndicator();
        } else {
          // 请求成功，显示数据
          return ListView.builder(
              itemCount: list_Modal_Kind.length,
              itemBuilder: (context, index) {
                final user = list_Modal_Kind[index];
                return Card(
                  child: ListTile(
                    title: Text(user.name2),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => testview()));
                    },
                  ),
                );
              });
        }
      } else {
        // 请求未结束，显示loading
        return new Center(child: CircularProgressIndicator());
        // return CircularProgressIndicator();
      }
    },
  );
}

void getHttp() async {
  try {
    Response response = await Dio().get(m_url_ClocjClass);
    String sss = "";
    if (response.statusCode == HttpStatus.ok) {
      list_Modal_Kind = (response.data as List<dynamic>)
          .map((e) => Modal_Kind.fromJson((e as Map<String, dynamic>)))
          .toList();
      //print(list[1].name2);
    }
  } catch (e) {
    print(e);
  }
}

class _MyHomePageState2 extends State<MyHomePage2> {
  @override
  Widget build(BuildContext context) {
    // String ttt = '[{"name1":"0","name2":"特休"},{"name1":"1","name2":"特休2"}]';
    // List<Nametry> list = (ttt as List<dynamic>)
    //     .map((e) => Nametry.fromJson((e as Map<String, dynamic>)))
    //     .toList();

    return Scaffold(
        appBar: AppBar(
          //leading: Icon(Icons.arrow_back),
          backgroundColor: Color.fromRGBO(56, 163, 210, 1.0),
          title: Text(
            "請假單",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                // color: Colors.black54,
                fontSize: 18),
          ),
        ),
        // body: buildLivtView_Kind(context));
        body: buildLivtView_LeaveSch(context));
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // String ttt = '[{"name1":"0","name2":"特休"},{"name1":"1","name2":"特休2"}]';
    // List<Nametry> list = (ttt as List<dynamic>)
    //     .map((e) => Nametry.fromJson((e as Map<String, dynamic>)))
    //     .toList();

    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter GridView basic3"),
        ),
        body: buildLivtView_basic(context));
  }
}
