import 'package:lovetest2/component/blanttButton.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:lovetest2/testView.dart';
import 'package:dio/dio.dart';
import 'package:lovetest2/myConn.dart';
import 'package:lovetest2/routesPage.dart';
import '../Model/Model1.dart';
import 'package:lovetest2/utils/dt_router.dart';

//我喜歡這種表單樣式,先紀錄起來  lll
//https://www.kindacode.com/article/adding-borders-to-cards-in-flutter/
//不錯的做法! https://www.youtube.com/watch?v=4tG8M4wK4F0

List<Modal_LeaveSch2> _modal_list = [];

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
        routes: RoutePath, //如用這寫法,是為了配合後面用  Navigator.pushNamed
        home: ListViewSch());
  }
}

class ListViewSch extends StatefulWidget {
  ListViewSch({Key? key}) : super(key: key);
  @override
  _MyHomePageState2 createState() => _MyHomePageState2();
}

//TODO 取值
Future<String> GetDateLeaveSch() async {
  print('listview開始取值' + DateTime.now().second.toString());
  final response = await Dio().get(GetSelectAmcJobLeave_appEasy() + '/all');
  String sss = "";

  print('listview_1完成取值' + DateTime.now().second.toString());
  _modal_list = (response.data as List<dynamic>)
      .map((e) => Modal_LeaveSch2.fromJson((e as Map<String, dynamic>)))
      .toList();
  print('listview_2完成取值' + DateTime.now().second.toString());
  return "";
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

Widget _listCard_title(BuildContext context, String BatchID, String LeaveTypeN,
    String UserNameN, String MStatusN, String SendTime, String ApproveTime) {
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
    _listCard_row(context, BatchID, LeaveTypeN, UserNameN, MStatusN, SendTime,
        ApproveTime)
  ]);
}
//_listCard_row  建立表身row
Widget _listCard_row(BuildContext context, String BatchID, String LeaveTypeN,
    String UserNameN, String MStatusN, String SendTime, String ApproveTime) {
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
            //TODO 時間欄位
            buildCell(1, 30, 95, SendTime, 1),
            buildCell(1, 30, 95, ApproveTime, 1),
            Expanded(child: buildCell(1, 30, 100, '', 0)),
            // Expanded(child: FlutterLogo()),
          ]),
        ]),
      ),
      //TODO row點選時
      onTap: () {
        RouterUtil_test.toJobleaveForm(context, BatchID);
        // Navigator.pushNamed(context, page3, arguments: PageSend(BatchID));
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

//TODO listbuild
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
                final user = _modal_list[index];
                var row = _modal_list[index];
                if (index == 0) {
                  return _listCard_title(
                      context,
                      row.BatchID,
                      row.LeaveTypeN,
                      row.UserNameN,
                      row.MStatusN,
                      row.SendTimeN,
                      row.ApproveTimeN);
                } else {
                  return _listCard_row(
                      context,
                      row.BatchID,
                      row.LeaveTypeN,
                      row.UserNameN,
                      row.MStatusN,
                      row.SendTimeN,
                      row.ApproveTimeN);
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

class _MyHomePageState2 extends State<ListViewSch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            //leading: Icon(Icons.arrow_back),
            backgroundColor: Color.fromRGBO(56, 163, 210, 1.0),
            title: Row(
              children: [
                Text(
                  "請假單",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      // color: Colors.black54,
                      fontSize: 18),
                ),
                Expanded(child: Text('')),
                SizedBox(
                  width: 35,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: myButton(
                      m_child: myText(
                        m_text: '新增',
                        m_color: Colors.blueAccent,
                        m_fontsize: 16,
                      ),
                      m_onPressed: () {
                        RouterUtil_test.toJobleaveForm(context, '');
                      },
                    ))
              ],
            )),
        body: buildLivtView_LeaveSch(context));
  }
}
