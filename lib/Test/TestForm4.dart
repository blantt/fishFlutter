import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../component/blanttButton.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:io';
import '../Model/Model2.dart';
import 'package:blantt_love_test/myConn.dart';

List<Modal_LeaveSch2> _modal_list = [];

class MyAppLoad extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppLoad> {
  List<String> items = [];
  int batchSize = 120;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    //_loadData2();
  }

  Future<void> _loadData2() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      // Simulate data loading delay
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        // _modal_list.addAll(List.generate(10, (index) => _modal_list[index]));

        // items.addAll(List.generate(
        //     batchSize, (index) => 'Item ${items.length + index}'));
        isLoading = false;
      });
    }
  }

  Future<void> _loadData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      // Simulate data loading delay
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        items.addAll(List.generate(
            batchSize, (index) => 'Item2 ${items.length + index}'));
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lazy Loading ListView'),
      ),
      body: buildLivtView_LeaveSch(context),
      // body: ListView.builder(
      //   itemCount: items.length + 1,
      //   itemBuilder: (context, index) {
      //     if (index < items.length) {
      //       return ListTile(
      //         title: Text(items[index]),
      //       );
      //     } else {
      //       if (isLoading) {
      //         return Center(child: CircularProgressIndicator());
      //       } else {
      //         _loadData();
      //         return SizedBox.shrink();
      //       }
      //     }
      //   },
      // ),
    );
  }

  //TODO LeaveSch
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
              itemCount: _modal_list.length,
              itemBuilder: (context, index) {
                if (index < items.length) {
                  return ListTile(
                    title: Text(items[index]),
                  );
                } else {
                  if (isLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    //_loadData2();
                    return SizedBox.shrink();
                  }
                }
              },
              // itemBuilder: (context, index) {
              //   final user = _modal_list[index];
              //   var row = _modal_list[index];
              //   if (index == 0) {
              //     return _listCard_title(context, row.BatchID, row.LeaveTypeN,
              //         row.UserNameN, row.MStatusN);
              //   } else {
              //     return _listCard_row(context, row.BatchID, row.LeaveTypeN,
              //         row.UserNameN, row.MStatusN);
              //   }
              // }
            );
          }
        } else {
          // 请求未结束，显示loading
          return new Center(child: CircularProgressIndicator());
          // return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _listCard_title(BuildContext context, String BatchID,
      String LeaveTypeN, String UserNameN, String MStatusN) {
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
          ])),
      _listCard_row(context, BatchID, LeaveTypeN, UserNameN, MStatusN)
    ]);
  }

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
              Expanded(
                  child: buildCell(1, 30, 100, '2022/01/01~2022/05/05', 0)),
              // Expanded(child: FlutterLogo()),
            ]),
          ]),
        ),
        //TODO row點選時
        onTap: () {
          //RouterUtil_test.toJobleaveForm(context, BatchID);
          // Navigator.pushNamed(context, page3, arguments: PageSend(BatchID));
        },
      )

      // _listCard(context, BatchID),
    ]);
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

  Future<String> GetDateLeaveSch() async {
    print('begin');
    final response = await Dio().get(m_url_LeaveSch + '/all');
    String sss = "";

    if (response.statusCode == HttpStatus.ok) {
      print('getdata');
      _modal_list = (response.data as List<dynamic>)
          .map((e) => Modal_LeaveSch2.fromJson((e as Map<String, dynamic>)))
          .toList();
    }
    return "";
  }
}
