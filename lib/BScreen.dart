import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BScreen extends StatelessWidget {
  final String value;

  // 接收的參數是由建構子接收在這裡!!
  BScreen({required this.value});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(value),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(value),
            // RaisedButton(
            //   onPressed: () {
            //     // The Yep button returns "Yep!" as the result.
            //     Navigator.pop(context, '我是 B 畫面來的資料!');
            //   },
            //   child: Text("回傳資料給 A 畫面"),
            // ),
          ],
        ),
      ),
    );
  }
}
