import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lovetest2/TryMenu.dart';

class barview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Learning',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  //List<String> _titles = ["Home", "Profile", "Shop"];
  List<Widget> _items = [
    // Text(
    //   '歡迎來到AMC',
    // ),

    //menu_Clock(),
    //testmenu(),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('AMC臉書系統',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              // shadows: [
              //   Shadow(
              //       color: Colors.black54,
              //       offset: Offset(1, 2),
              //       blurRadius: 4)
              // ]
            )),
        //Text("AMC臉書系統"),
      ),
      body: Center(
          child: IndexedStack(
              index: _selectedIndex,
              children: _items) //_items.elementAt(_index),
          ),
      bottomNavigationBar: _showBottomNav(),
    );
  }

  Widget _showBottomNav() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '首頁',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: '差勤系統',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag),
          label: '測試專區',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.redAccent,
      unselectedItemColor: Colors.teal,
      selectedFontSize: 15,
      unselectedFontSize: 15,
      iconSize: 30,
      onTap: _onTap,
    );
  }

  void _onTap(int index) {
    _selectedIndex = index;
    setState(() {});
  }
}
