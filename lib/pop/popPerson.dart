import 'package:blantt_love_test/page/JobLeave.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:blantt_love_test/myConn.dart';
import '../Model/Model1.dart';
import 'package:blantt_love_test/routesPage.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

//參收參數參考 https://fightwennote.blogspot.com/2020/04/flutter-widget.html?m=0
//https://github.com/yogitakumar/navigation
void main() {
  runApp(MyListPerson(
    value: '',
  ));
}

//list_Modal_PsersonSch_new 是用來判斷是否己經有抓過資料庫,給list值了,
//如果用list 過濾資料時,FutureBuilder ,會再啓動一次,這是就判斷不會再回抓資料庫了
//這個做法是綜合許多後自己發明的,有沒有更好的寫法,再觀查一下
List<Modal_PsersonSch> list_Modal_PsersonSch_new = [
  Modal_PsersonSch(
    name1: '',
    name2: '',
  )
];

class newPersonState extends StatefulWidget {
  //如要用Route ,能正確的用pop返迴值到上一面,需舕叫這個 StatefulWidget ,不能用 StatelessWidget
  //真正原理為何,其實不太懂,有機會要去再深入了解一下, 但應該和 BuildContext 是有關的

  late final String value;
  newPersonState({required this.value});

  @override
  _PageState2 createState() => _PageState2();
}

class MyListPerson extends StatelessWidget {
  late final String value;

  @override
  void initState() {}

  // 接收的參數是由建構子接收在這裡!!
  MyListPerson({required this.value});

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: value,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Text('暫時沒用'),
    );
  }
}

final ItemScrollController itemScrollController = ItemScrollController();

class _PageState2 extends State<newPersonState> {
  // @override
  void initState() {
    //這個states應該只會進來一次,所以在這裡做初始值

    list_Modal_PsersonSch_new.clear();
    super.initState();
  }

  // 接收的參數是由建構子接收在這裡!!
  // MyListPerson({required this.value});
  onSearch(String search) {
    setState(() {
      list_Modal_PsersonSch_new = list_Modal_PsersonSch
          .where((user2) => user2.name1.toLowerCase().contains(search))
          .toList();
    });
  }

  String getvalue = "";
  @override
  Widget build(BuildContext context) {
    getvalue = widget.value;
    return Scaffold(
        appBar: AppBar(
          //leading: Icon(Icons.arrow_back),
          backgroundColor: Color.fromRGBO(56, 163, 210, 1.0),
        ),
        // body: Text('ddd'),
        body: Container(
          child: Column(
            children: [
              TextField(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    onSearch(value);
                  },
                  decoration: InputDecoration(
                      labelText: "Search3",
                      hintText: "Search2",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Expanded(
                child: _body(context),
              ),
            ],
          ),
        ));
  }
}

void setitem() async {
  itemScrollController.jumpTo(index: 4);
}

void clearitem() async {
  list_Modal_PsersonSch_new.clear();
}

class BoxedReturns {
  final String a;
  final String b;

  BoxedReturns(this.a, this.b);
}

Widget _buildList(BuildContext context) {
  //原來是 ListView.builder
  print('nowlen' + list_Modal_PsersonSch_new.length.toString());

  var itemCount = list_Modal_PsersonSch_new.length;
  if (itemCount == 0) {
    itemCount = 1;
  }

  return ScrollablePositionedList.builder(
      itemCount: list_Modal_PsersonSch_new.length,
      itemScrollController: itemScrollController,
      itemBuilder: (context, index) {
        final user = list_Modal_PsersonSch_new[index];
        var row = list_Modal_PsersonSch_new[index];
        //TODO listview迴圈時
        return Card(
          child: ListTile(
              title: Container(
            child: Row(
              children: [
                IconButton(
                  onPressed: () => {
                    //TODO pop參數
                    // debugPrint(row.name1)

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

Widget _body(BuildContext context) {
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

          return _buildList(context);
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

//TODO  list_Modal_PsersonSch_new 取值
Future<String> GetDatePersonSch() async {
  if (list_Modal_PsersonSch_new.length > 0) {
    //代表有取過值了,過濾時,不要再去回調資料api了
    return "";
  }

  final response = await Dio().get(m_PersonSch + '/admin');
  list_Modal_PsersonSch = (response.data as List<dynamic>)
      .map((e) => Modal_PsersonSch.fromJson((e as Map<String, dynamic>)))
      .toList();

  list_Modal_PsersonSch_new = list_Modal_PsersonSch;

  return "";
}

class PageSend2 {
  String Name1;
  String Name2;
  PageSend2(this.Name1, this.Name2);
}
