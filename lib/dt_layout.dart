import 'package:blantt_love_test/ListView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blantt_love_test/testView.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:blantt_love_test/routesPage.dart';
import 'package:blantt_love_test/testButton.dart';

// row column 範例
//https://tw-hkt.blogspot.com/2019/08/flutter-row-column.html

void main() {
  runApp(templayout());
}

class templayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter App Learning',
        routes: RoutePath,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter GridView build new"),
        ),
        // body: buildLivtView_Kind(context));
        body: _testlayout(context));
  }
}

Widget _testlayout(BuildContext context) {
  return Container(
    alignment: Alignment.topCenter,
    width: double.infinity,
    height: 400,
    decoration: new BoxDecoration(color: Colors.greenAccent),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('ddddd'),
          Text('ddddd234'),
          SizedBox(
            width: 65,
          ),
          // Expanded(
          //     child: Container(
          //   decoration: new BoxDecoration(color: Colors.amber),
          // ))
        ]),
    // child: Text('cccccc'),
  );
}
