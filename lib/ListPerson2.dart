import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:blantt_love_test/testView.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:blantt_love_test/myConn.dart';
import 'package:blantt_love_test/routesPage.dart';
import 'Model/Model1.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'load/loading_screen.dart';

void main() {
  runApp(MyListPerson2());
}

class listSch2 extends StatefulWidget {
  listSch2({Key? key}) : super(key: key);

  @override
  _PageState2 createState() => _PageState2();
}

List<Modal_PsersonSch> list_Modal_PsersonSch_new = [
  Modal_PsersonSch(
    name1: '',
    name2: '',
  )
];

class _PageState2 extends State<listSch2> {
  String _ddd = "aa2";

  Future<Null> getUserDetails() async {
    final response = await Dio().get(m_PersonSch + '/admin');

    setState(() {
      list_Modal_PsersonSch_new = (response.data as List<dynamic>)
          .map((e) => Modal_PsersonSch.fromJson((e as Map<String, dynamic>)))
          .toList();
    });
    LoadingScreen().show(
      context: context,
      text: 'Please wait a momenttt',
    );

    if (response.statusCode == HttpStatus.ok) {
      LoadingScreen().hide();
      print(list_Modal_PsersonSch.length.toString());
    } else {
      print('dddd33');
      // LoadingScreen().hide();
    }
  }

  // @override
  void initState() {
    // setState(() {
    //
    //   _ddd = 'ccc';
    // });
    super.initState();
    print('init');
    getUserDetails();
  }

  void _incrementCounter(BuildContext context) async {
    // Call LoadingScreen().show() to SHOW  Loading Dialog
    LoadingScreen().show(
      context: context,
      text: 'Please wait a moment',
    );

    // await for 2 seconds to Mock Loading Data
    await Future.delayed(const Duration(seconds: 2));
    setState(() {});

    // Call LoadingScreen().hide() to HIDE  Loading Dialog
    LoadingScreen().hide();
  }

  onSearch(String search) {
    setState(() {
      list_Modal_PsersonSch_new = list_Modal_PsersonSch
          .where((user2) => user2.name1.toLowerCase().contains(search))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_ddd),
          //leading: Icon(Icons.arrow_back),
          backgroundColor: Color.fromRGBO(56, 163, 210, 1.0),
        ),
        // body: Text('ddd'),

        body: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    //onSearch(value);
                    //_incrementCounter(context);
                  },

                  // controller: editingController,
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Expanded(
                child: list_Modal_PsersonSch_new.length > 0
                    ? _buildList()
                    : Center(
                        child: Text(
                        "No users found",
                        style: TextStyle(color: Colors.white),
                      )),
              ),
            ],
          ),
        ));
  }
}

class MyListPerson2 extends StatelessWidget {
  @override
  void initState() {
    print('gotin2');
  }

  // 接收的參數是由建構子接收在這裡!!
  MyListPerson2();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'listview測試',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new listSch2(),
    );
  }
}

Widget _body(BuildContext context) {
  // final ItemPositionsListener itemPositionsListener =
  //     ItemPositionsListener.create();

  return FutureBuilder<String>(
    future: GetDatePersonSch(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      // 请求已结束
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          // 请求失败，显示错误
          return Text("Error: ${snapshot.error}");
          //  return CircularProgressIndicator();
        } else {
          // 请求成功，显示数据
          //return Text('dd');
          return _buildList();
        }
      } else {
        // 请求未结束，显示loading
        //  itemScrollController.jumpTo(index: 50);

        return new Center(child: CircularProgressIndicator());
        // return CircularProgressIndicator();
      }
    },
  );
}

Future<String> GetDatePersonSch() async {
  final response = await Dio().get(m_PersonSch + '/admin');
  String sss = "";
  //if (response.statusCode == HttpStatus.ok) {
  list_Modal_PsersonSch = (response.data as List<dynamic>)
      .map((e) => Modal_PsersonSch.fromJson((e as Map<String, dynamic>)))
      .toList();
  if (response.statusCode == HttpStatus.ok) {
  } else {}

  return "";
}

Widget _buildList() {
  //原來是 ListView.builder
  print('nowlen' + list_Modal_PsersonSch_new.length.toString());
  return ScrollablePositionedList.builder(
      itemCount: list_Modal_PsersonSch_new.length,
      //initialScrollIndex: 3,
      // key: const PageStorageKey('104259'),
      // itemScrollController: itemScrollController,
      itemBuilder: (context, index) {
        final user = list_Modal_PsersonSch_new[index];
        var row = list_Modal_PsersonSch_new[index];


        return Card(
          child: ListTile(
              title: Container(
            child: Row(
              children: [
                IconButton(
                  onPressed: () => {

                    Navigator.pop(context, row.name1 + '/' + row.name2)
                  },
                  icon: Icon(
                    Icons.touch_app_sharp,
                    color: Color.fromRGBO(51, 207, 222, 1.0),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(row.name1),
                SizedBox(
                  width: 60,
                ),
                Text(row.name2),
              ],
            ),
          )),
        );
      });
}

Future<String> GetDatePersonSch2(BuildContext context) async {
  print('999');

  // print('test' + list_Modal_PsersonSch_new.length.toString());
  //
  // if (list_Modal_PsersonSch_new.length < 2) {
  //   return "";
  // }

  final response = await Dio().get(m_PersonSch + '/admin');
  String sss = "";

  //if (response.statusCode == HttpStatus.ok) {
  list_Modal_PsersonSch = (response.data as List<dynamic>)
      .map((e) => Modal_PsersonSch.fromJson((e as Map<String, dynamic>)))
      .toList();

  list_Modal_PsersonSch_new = list_Modal_PsersonSch;

  LoadingScreen().show(
    context: context,
    text: 'Please wait a momenttt',
  );

  if (response.statusCode == HttpStatus.ok) {
    LoadingScreen().hide();
    print(list_Modal_PsersonSch.length.toString());
  } else {
    print('dddd33');
    // LoadingScreen().hide();
  }

  return "";
}
