import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'ListView.dart';
import 'package:blantt_love_test/myConn.dart';
import 'dart:io';
import 'Model/Model1.dart';

String _BatchID = '';
String _UserNameN = '';

void main() {
  runApp(Jobleave());
}

class Jobleave extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as PageSend;
    if (args != null) {
      _BatchID = args.BatchID;
    } else {
      _BatchID = "h";
    }

    return MaterialApp(
      title: 'dddd',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Jobleave2(),
    );
  }
}

class Jobleave2 extends StatefulWidget {
  Jobleave2({Key? key}) : super(key: key);
  @override
  _Jovleave createState() => _Jovleave();
}

class GlobalState {}

class GlobalLoadingState extends GlobalState {}

int _selectedIndex = 0;

class _Jovleave extends State<Jobleave2> {
  //---重點是counterStreamController 要寫對地方,不然第二次進來stream,會出現錯誤!!!

  int _counter = 0;
  late Stream _counterStream;
  late StreamSink _counterSink;
  StreamController<int> _counterStreamController = StreamController<int>(
    onCancel: () {
      print('cancel');
    },
    onListen: () {
      print('listen');
    },
  );

  @override
  void initState() {
    super.initState();
    _counterSink = _counterStreamController.sink;
    _counterStream = _counterStreamController.stream;
  }

  @override
  void dispose() {
    _counterStreamController.close();
    //controller=null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('請假單 ' + _BatchID),
      ),
      body: JobStreamNew(context),
      // body: Align(
      //   alignment: Alignment.bottomCenter,
      //   child: Container(
      //     alignment: Alignment.bottomCenter,
      //     width: double.infinity,
      //     height: 30,
      //     decoration: new BoxDecoration(color: Colors.teal),
      //   ),
      // ),
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

  Future<String> GetDateLeave() async {
    // return Future.delayed(Duration(seconds: 2), () => "我是从互联网上获取的数据");
    // getHttp();
    //return Future.delayed(Duration(seconds: 5), () => "我是从互联网上获取的数据");
    final response = await Dio().get(m_url_LeaveSch + '/' + _BatchID);
    String sss = "";

    if (response.statusCode == HttpStatus.ok) {
      list_Modal_LeaveSch2 = (response.data as List<dynamic>)
          .map((e) => Modal_LeaveSch2.fromJson((e as Map<String, dynamic>)))
          .toList();

      //---其實_counterSink 這段沒有也沒差了,當初只是想是否要用count去判斷資燉讀取了沒,先留著好了,
      //---重點是counterStreamController 要寫對地方,不然第二次進來stream,會出現錯誤!!!
      _counter = 1;
      _counterSink.add(_counter);
    }

    return "";
  }

  Widget JobStreamNew(BuildContext context) {
    GetDateLeave();
    return StreamBuilder<int>(
      stream: _counterStreamController.stream,
      builder: (
        BuildContext context,
        AsyncSnapshot<int> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {
            var icount = list_Modal_LeaveSch2.length;
            if (icount <= 0) {
            } else {
              var row = list_Modal_LeaveSch2[icount - 1];
              _UserNameN = row.UserNameN;
              // 请求成功，显示数据
              ControllerLeaveTypeN.text = row.LeaveTypeN;
              emailController.text = _BatchID;
              ControllerUserNameN.text = _UserNameN;
            }
            return _myorm(context);
          } else {
            return const Text('Empty data');
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    );
  }
}

Widget set1(BuildContext context) {
  return TextField();
}

Stream<int> streamPage = (() async* {
  //await Future<void>.delayed(Duration(seconds: 2));
  //await Future<void>.delayed(Duration(seconds: 2));
  final response = await Dio().get(m_url_LeaveSch + '/' + _BatchID);
  list_Modal_LeaveSch2 = (response.data as List<dynamic>)
      .map((e) => Modal_LeaveSch2.fromJson((e as Map<String, dynamic>)))
      .toList();

  yield 0;
})();

TextEditingController emailController = new TextEditingController();

TextEditingController ControllerUserNameN = new TextEditingController();
TextEditingController ControllerLeaveTypeN = new TextEditingController();

Widget buildmyForm(BuildContext context) {
  return Form(
      child: Column(children: <Widget>[
    TextFormField(
      //'$textHolder'
      //initialValue: '$textHolder',
      //controller: emailController,
      decoration: InputDecoration(icon: Icon(Icons.people), labelText: '單號'),
    ),
    TextField(),
  ]));
}

Widget JobStream(BuildContext context) {
  return StreamBuilder<int>(
    stream: streamPage,
    builder: (
      BuildContext context,
      AsyncSnapshot<int> snapshot,
    ) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.connectionState == ConnectionState.active ||
          snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return const Text('Error');
        } else if (snapshot.hasData) {
          var icount = list_Modal_LeaveSch2.length;
          if (icount <= 0) {
          } else {
            var row = list_Modal_LeaveSch2[icount - 1];
            // _UserNameN = row.UserNameN;
            // ControllerLeaveTypeN.text = row.UserNameN;
            // // 请求成功，显示数据
            // emailController.text = _BatchID;
            // ControllerUserNameN.text = _UserNameN;
          }
          return _myorm(context);

          // return TextField(
          //   decoration: InputDecoration(
          //     border: OutlineInputBorder(),
          //     hintText: _UserNameN,
          //   ),
          // );
          // return Text(snapshot.data.toString(),
          //     style: const TextStyle(color: Colors.red, fontSize: 40));
        } else {
          return const Text('Empty data');
        }
      } else {
        return Text('State: ${snapshot.connectionState}');
      }
    },
  );
}

Widget _myorm(BuildContext context) {
  return Column(children: <Widget>[
    Container(
        alignment: Alignment.topCenter,
        width: double.infinity,
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: Form(
            child: Column(children: <Widget>[
          TextFormField(
            //'$textHolder'
            //initialValue: '$textHolder',
            controller: emailController,
            decoration:
                InputDecoration(icon: Icon(Icons.people), labelText: '單號'),
          ),
          TextField(
            // controller: ControllerUserNameN..text = _UserNameN,
            controller: ControllerUserNameN,
          ),
          TextFormField(
            //'$textHolder'
            //initialValue: '$textHolder',
            controller: ControllerLeaveTypeN,
            decoration:
                InputDecoration(icon: Icon(Icons.people), labelText: '假別'),
          ),
        ]))),
    Expanded(
      child: Align(

        alignment: FractionalOffset.bottomCenter,
        child: MaterialButton(
          onPressed: () => {},
          child: Container(
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              height: 30,
              //decoration: new BoxDecoration(color: Colors.teal),
              child: ElevatedButton.icon(
                icon: Icon(Icons.save),
                label: Text("儲存"),
                onPressed: () {},
              )),
        ),
      ),
    ),
  ]);

  return Container(
      alignment: Alignment.topCenter,
      width: double.infinity,
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Form(
          child: Column(children: <Widget>[
        TextFormField(
          //'$textHolder'
          //initialValue: '$textHolder',
          controller: emailController,
          decoration:
              InputDecoration(icon: Icon(Icons.people), labelText: '單號'),
        ),
        TextField(
          // controller: ControllerUserNameN..text = _UserNameN,
          controller: ControllerUserNameN,
        ),
        TextFormField(
          //'$textHolder'
          //initialValue: '$textHolder',
          controller: ControllerLeaveTypeN,
          decoration:
              InputDecoration(icon: Icon(Icons.people), labelText: '假別'),
        ),
        OutlinedButton(
          child: Text(
            '登入',
            style: TextStyle(color: Colors.deepOrange),
          ),
          onPressed: () {
            //changeText();
            emailController.text = 'bbbb';
            print(emailController.text);
          },
        ),
      ])));
}
