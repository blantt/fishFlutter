import 'dart:async';

import 'package:lovetest2/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'page/JobLeaveSch.dart';
import 'package:lovetest2/myConn.dart';
import 'dart:io';
import 'Model/Model1.dart';
import 'pop/popPerson.dart';
import 'package:lovetest2/component/blanttButton.dart';

void main() {
  runApp(testform());
}

class testform extends StatelessWidget {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      title: 'dddd',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Stack(children: <Widget>[
        // JobStreamNew(context),
        _isLoading
            ? Text('9988')
            : !_isLoading
                ? Center(
                    child: MyLoadingWidget(
                      m_Strload: '儲存中',
                      // m_btnStopShow: true,
                    ),
                  )
                : Container(),
      ]),
    );
  }
}

//先定義一個類別
class User {
  String id;
  User(this.id);
}

class _testform extends StatefulWidget {
  const _testform({Key? key}) : super(key: key);

  @override
  State createState() => bbb();
}

class GlobalState {}

class GlobalLoadingState extends GlobalState {}

int _selectedIndex = 0;

class bbb extends State<_testform> {
  @override
  void initState() {
    super.initState();
  }

  @override
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      //body: _myorm(context),  //這一行是目前彈跳視窗可以正常顯示
      body: Text('ddd'),
    );
  }
}
