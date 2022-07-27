import 'package:blantt_love_test/dt_image.dart';
import 'package:flutter/material.dart';
import 'package:blantt_love_test/testView.dart';
import 'package:blantt_love_test/BarView.dart';
import 'package:blantt_love_test/ListView.dart';
import 'package:blantt_love_test/dt_rounter.dart';
import 'package:blantt_love_test/myConn.dart';

class testmenu extends StatelessWidget {
  const testmenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _menu(context);
  }
}

class menu_Clock extends StatelessWidget {
  const menu_Clock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _menu_Clock(context);
  }
}

Widget _menu_Clock(BuildContext context) {
  return Scaffold(
      body: Center(
          child: Column(children: [
    Container(
      margin: EdgeInsets.fromLTRB(0, 65, 0, 0),
    ),
    OutlinedButton(
      child: Text(
        '請假單',
        style: TextStyle(color: Colors.deepOrange),
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => testview()));
      },
    ),
    OutlinedButton(
      child: Text(
        '加班單',
        style: TextStyle(color: Colors.deepOrange),
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => barview()));
      },
    ),
  ])));
}

Widget _menu(BuildContext context) {
  return Scaffold(
      body: Center(
          child: Column(children: [
    Container(
      margin: EdgeInsets.fromLTRB(0, 65, 0, 0),
    ),
    OutlinedButton(
      child: Text(
        'login in',
        style: TextStyle(color: Colors.deepOrange),
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => testview()));
      },
    ),
    OutlinedButton(
      child: Text(
        'menu bar',
        style: TextStyle(color: Colors.deepOrange),
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => barview()));
      },
    ),
    OutlinedButton(
      child: Text(
        'listview',
        style: TextStyle(color: Colors.deepOrange),
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyListView()));
      },
    ),
    OutlinedButton(
      child: Text(
        'MyRunter',
        style: TextStyle(color: Colors.deepOrange),
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyRunter()));
      },
    ),
    OutlinedButton(
      child: Text(
        'MyRImage',
        style: TextStyle(color: Colors.deepOrange),
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Myimage()));
      },
    ),
    OutlinedButton(
      child: Text(
        '連線測試',
        style: TextStyle(color: Colors.deepOrange),
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => menu_conn()));
      },
    )
  ])));
}
