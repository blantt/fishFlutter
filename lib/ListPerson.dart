import 'dart:ffi';

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
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
//參收參數參考 https://fightwennote.blogspot.com/2020/04/flutter-widget.html?m=0

void main() {
  runApp(MyListPerson(
    value: '',
  ));
}

String test1 = '';

class MyListPerson extends StatelessWidget {
  late final String value;

  @override
  void initState() {
    setitem();
  }

  // 接收的參數是由建構子接收在這裡!!
  MyListPerson({required this.value});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: OutlinedButton(
          child: Text(
            test1,
            style: TextStyle(color: Colors.deepOrange),
          ),
          onPressed: setitem,
        ),
      ),
      body: _body(context),
    );
  }
}

final ItemScrollController itemScrollController = ItemScrollController();

//TODO StatefulWidget
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _PageState2 createState() => _PageState2();
}

class _PageState2 extends State<MyHomePage> {
  // @override
  // void initState() {
  //   setitem();
  // }
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //leading: Icon(Icons.arrow_back),
          backgroundColor: Color.fromRGBO(56, 163, 210, 1.0),
        ),
        body: _body(context));
  }
}

void setitem() async {
  itemScrollController.jumpTo(index: 4);
}

class BoxedReturns {
  final String a;
  final String b;

  BoxedReturns(this.a, this.b);
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
          //原來是 ListView.builder
          return ScrollablePositionedList.builder(
              itemCount: list_Modal_PsersonSch.length,
              //initialScrollIndex: 3,
              // key: const PageStorageKey('104259'),
              itemScrollController: itemScrollController,
              itemBuilder: (context, index) {
                final user = list_Modal_PsersonSch[index];
                var row = list_Modal_PsersonSch[index];
                // if (index == 10) {
                //   setitem();
                // }

                // return Card(
                //     child: ListTile(
                //   title: Text(row.name2),
                // ));

                //TODO listview迴圈時
                return Card(
                  child: ListTile(
                      title: Container(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => {
                            //TODO pop參數
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

  return "";
}

class PageSend2 {
  String Name1;
  String Name2;
  PageSend2(this.Name1, this.Name2);
}
