import 'package:lovetest2/page/JobLeave.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lovetest2/myConn.dart';
import 'package:lovetest2/Model/modalBasic.dart';
import 'package:lovetest2/routesPage.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

List<Modal_basic> _listModal = [];

class doorLeaveType extends StatelessWidget {
  late final String value;

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: doorLeaveType2(),
    );
  }
}

class doorLeaveType2 extends StatefulWidget {
  //如要用Route ,能正確的用pop返迴值到上一面,需舕叫這個 StatefulWidget ,不能用 StatelessWidget
  //真正原理為何,其實不太懂,有機會要去再深入了解一下, 但應該和 BuildContext 是有關的

  doorLeaveType2();

  @override
  leaveDoorState createState() => leaveDoorState();
}

class leaveDoorState extends State<doorLeaveType2> {
  // @override
  void initState() {
    //這個states應該只會進來一次,所以在這裡做初始值
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('假別選單'),
          //leading: Icon(Icons.arrow_back),
          backgroundColor: Color.fromRGBO(56, 163, 210, 1.0),
        ),
        // body: Text('ddd'),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: _body(context),
              ),
            ],
          ),
        ));
  }

  Future<String> GetDatePersonSch() async {
    final response = await Dio().get(m_LeaveType);
    _listModal = (response.data as List<dynamic>)
        .map((e) => Modal_basic.fromJson((e as Map<String, dynamic>)))
        .toList();

    return "";
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

  Widget _buildList(BuildContext context) {
    //原來是 ListView.builder
    print('nowlen' + _listModal.length.toString());

    return ScrollablePositionedList.builder(
        itemCount: _listModal.length,
        itemBuilder: (context, index) {
          final user = _listModal[index];
          var row = _listModal[index];
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
                  // SizedBox(
                  //   width: 5,
                  // ),
                  // Text(row.name1),
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
}
