import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blantt_love_test/testView.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'ListView.dart';

void main() {
  runApp(testButton());
}

String ss1 = '';

class testButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as PageSend;
    if (args != null) {
      ss1 = args.BatchID;
    } else {
      ss1 = "h";
    }

    return MaterialApp(
      title: 'dddd',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage2(),
      routes: <String, WidgetBuilder>{'/register': (_) => new testButton()},
    );
  }
}

class MyHomePage2 extends StatefulWidget {
  MyHomePage2({Key? key}) : super(key: key);
  @override
  _MyHomePageState2 createState() => _MyHomePageState2();
}

class _MyHomePageState2 extends State<MyHomePage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(ss1),
        ),
        // body: buildLivtView_Kind(context));
        body: _testButton(context));
  }
}

Widget _testButton(BuildContext context) {
  return Scaffold(
      body: Center(
          child: Column(children: [
    Container(
      decoration: new BoxDecoration(
        border: new Border.all(
          width: 1,
          color: Colors.green,
        ),
      ),
      width: 30,
      height: 30,
      child: InkWell(
        child: Image(
          image: AssetImage("assets/images/login.png"),
          fit: BoxFit.fill,
        ),
        onTap: () {
          print('ddd');
        },
      ),
    )
  ])));
}
