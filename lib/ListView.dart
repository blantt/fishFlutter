import 'package:blantt_love_test/ListView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blantt_love_test/testView.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:blantt_love_test/myConn.dart';

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

//假單查詢
List<Modal_LeaveSch> list_Modal_LeaveSch = [
  Modal_LeaveSch(
    BatchID: '',
    UserName: '',
    UserNameN: '',
    LeaveTypeN: '',
    DeptID: '',
    LeaveType: '',
    ClassType: '',
    Reason: '',
    ReturnReason: '',
  )
];

//TODO Modal_LeaveSch
//Modal_LeaveSch 假單查詢
class Modal_LeaveSch {
  Modal_LeaveSch({
    required this.BatchID,
    required this.UserName,
    required this.UserNameN,
    required this.LeaveTypeN,
    required this.DeptID,
    required this.LeaveType,
    required this.ClassType,
    required this.Reason,
    required this.ReturnReason,
  });

  String BatchID;
  String UserName;
  String UserNameN;
  String LeaveTypeN;
  String DeptID;
  String LeaveType;
  String ClassType;
  String Reason;
  String ReturnReason;

  factory Modal_LeaveSch.fromJson(Map<String, dynamic> json) => Modal_LeaveSch(
        BatchID: json["BatchID"] ?? '',
        UserName: json["UserName"] ?? '',
        UserNameN: json["UserNameN"] ?? '',
        LeaveTypeN: json["LeaveTypeN"] ?? '',
        DeptID: json["DeptID"] ?? '',
        LeaveType: json["LeaveType"] ?? '',
        ClassType: json["ClassType"] ?? '',
        Reason: json["Reason"] ?? '',
        ReturnReason: json["ReturnReason"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "BatchID": BatchID,
        "UserName": UserName,
        "UserNameN": UserNameN,
        "LeaveTypeN": LeaveTypeN,
        "DeptID": DeptID,
        "LeaveType": LeaveType,
        "ClassType": ClassType,
        "Reason": Reason,
        "ReturnReason": ReturnReason,
      };
}

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

//TODO 假單查詢
Future<String> GetDateLeaveSch() async {
  // return Future.delayed(Duration(seconds: 2), () => "我是从互联网上获取的数据");
  // getHttp();
  //return Future.delayed(Duration(seconds: 5), () => "我是从互联网上获取的数据");
  final response = await Dio().get(m_url_LeaveSch);
  String sss = "";
  //if (response.statusCode == HttpStatus.ok) {
  list_Modal_LeaveSch = (response.data as List<dynamic>)
      .map((e) => Modal_LeaveSch.fromJson((e as Map<String, dynamic>)))
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

//TODO 測試FutureBuilder 讀取資料
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

//TODO 測試將listview拉出來
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
              itemCount: list_Modal_LeaveSch.length,
              itemBuilder: (context, index) {
                final user = list_Modal_LeaveSch[index];
                return Card(
                  child: ListTile(
                    title: Text(user.BatchID),
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

Widget buildLivtView_Kind(BuildContext context) {
  // String ttt = '[{"name1":"0","name2":"特休"},{"name1":"1","name2":"特休2"}]';
  // List<Nametry> list = (ttt as List<dynamic>)
  //     .map((e) => Nametry.fromJson((e as Map<String, dynamic>)))
  //     .toList();

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

//TODO listview TEST
class _MyHomePageState2 extends State<MyHomePage2> {
  @override
  Widget build(BuildContext context) {
    // String ttt = '[{"name1":"0","name2":"特休"},{"name1":"1","name2":"特休2"}]';
    // List<Nametry> list = (ttt as List<dynamic>)
    //     .map((e) => Nametry.fromJson((e as Map<String, dynamic>)))
    //     .toList();

    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter GridView build new"),
        ),
        // body: buildLivtView_Kind(context));
        body: buildLivtView_LeaveSch(context));
  }
}

//TODO listview basic
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
