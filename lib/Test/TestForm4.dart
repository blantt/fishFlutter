import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../component/blanttButton.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:io';
import '../Model/Model2.dart';
import 'package:blantt_love_test/myConn.dart';

class MyAppLoad extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppLoad> {
  bool _isLoading = false;
  bool _stopLoading = false;

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
      if (_isLoading) {
        _stopLoading = true;
      }
    });
  }

  void _stopLoadingAnimation() {
    setState(() {
      print('colse');
      _isLoading = false;
      _stopLoading = false;
    });
  }

  Widget _buildStopButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: RaisedButton(
          onPressed: _stopLoadingAnimation,
          child: Text('Stop Loading'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loading Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Loading Example'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.save),
              label: '儲存',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Shop',
            ),
          ],
          // currentIndex: 1,
          unselectedItemColor: Colors.grey,
          // onTap: _onTap,
          elevation: 15,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                myButton(
                  m_child: Text('save1'),
                  m_onPressed: () {
                    sss();
                  },
                ),
                myButton(
                  m_child: Text('save2'),
                  m_onPressed: () {
                    sss2();
                  },
                ),
              ],
            )
          ],

          // children: <Widget>[
          //   myButton(
          //     m_child: Text('save1'),
          //     m_onPressed: () {
          //       sss();
          //     },
          //   ),
          //   myButton(
          //     m_child: Text('save3'),
          //     m_onPressed: () {
          //       sss2();
          //     },
          //   )
          // ],
        ),
      ),
    );
  }
}

class Itemtest {
  final String batchID;
  final String userName;
  final String reason;

  Itemtest(
      {required this.batchID, required this.userName, required this.reason});

  Map<String, dynamic> toJson() {
    return {
      'BatchID': batchID,
      'UserName': userName,
      'Reason': reason,
    };
  }
}

final items = [
  Itemtest(batchID: '1', userName: 'User1', reason: 'Reason1'),
  Itemtest(batchID: '2', userName: 'User2', reason: 'Reason2'),
  Itemtest(batchID: '3', userName: 'User3', reason: 'Reason3'),
];

Future<String> sss2() async {
  var dio = Dio();
  var response2 = await dio.post(
    m_url_UpdateJovLeave,
    data: itemtest2,
  );

  final response =
      await dio.post("http://clockappservice.english4u.com.tw/api/Addtest",
          // data: json.encode(items.map((item) => item.toJson()).toList()),
          data: items
          //options: Options(headers: {'Content-Type': 'application/json'}),
          );

  if (response.statusCode == 200) {
    print('OK');
    if (response.data != "0") {
      print('error:' + response.data);
    }

    return response.data;
  } else {
    print('error');
    //  throw Exception('Failed to add leave.');
  }
  return '';
}

var itemtest2 = {
  "BatchID": "A202304200001",
  "Reason": "YYY2",
  "UserName": "UserName value",
  "UserNameN": '',
  "LeaveTypeN": '',
  "DeptID": '',
  "LeaveType": '',
  "ClassType": '',
  "ClassTypeN": '',
  "ReturnReason": '',
  "MStatusN": '',
  "UserAgent": '104259',
  "UserAgent2": '104259',
  "UserAgentN": '',
  "UserAgent2N": '',
  "UserSee": '104259',
  "UserSee2": '104259',
  "UserSeeN": '',
  "UserSee2N": '',
};

Future<String> sss() async {
  var dio = Dio();
  // dio.options.contentType = Headers.formUrlEncodedContentType;
  //Add請假單
  //Addtest

  // Modal_LeaveSch2 ();
  // dd.BatchID="";
  itemtest2["BatchID"] = "A202304200001";
  itemtest2["Reason"] = "BB999";
  itemtest2["UserName"] = "104259";
  var response = await dio.post(
    m_url_UpdateJovLeave,
    //data: jsonEncode(itemtest),
    data: itemtest2,
    // options: Options(
    //   headers: {'Content-Type': 'application/json'},
    // ),
  );
  if (response.statusCode == 200) {
    print('OK');
    if (response.data != "0") {
      print('error:' + response.data);
    }

    return response.data;
  } else {
    print('error');
    //  throw Exception('Failed to add leave.');
  }
  return '';
}
