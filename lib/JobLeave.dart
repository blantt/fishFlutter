import 'dart:async';

import 'package:blantt_love_test/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'ListView.dart';
import 'package:blantt_love_test/myConn.dart';
import 'dart:io';
import 'Model/Model2.dart';
import 'ListPerson.dart';
import 'package:blantt_love_test/testListSch2.dart';

String _BatchID = '';
String _UserNameN = '';

// isNew 判斷是不是第一次進來,因為有些事件,會重複觸發build,
//不是第一次進來,就不用再重抓資料bind,不然會有些例外狀況..
//感覺應該還有更好的寫法,等待進化版!!
bool isNew = true;

class BindControl {
  String UserAgent = "";
  String UserAgent2 = "";
  String UserSee = "";
  String UserSee2 = "";

  TextEditingController FormControl_UserAgentN = new TextEditingController();
  TextEditingController FormControl_UserAgent2N = new TextEditingController();
  TextEditingController FormControl_UserSeeN = new TextEditingController();
  TextEditingController FormControl_UserSee2N = new TextEditingController();
  TextEditingController FormControl_Reason = new TextEditingController();

  TextEditingController emailController = new TextEditingController();
  TextEditingController ControllerClassTypeN = new TextEditingController();
  TextEditingController ControllerUserNameN = new TextEditingController();
  TextEditingController ControllerLeaveTypeN = new TextEditingController();
}

void main() {
  runApp(Jobleave());
}

var _BindControl = BindControl();

//TODO setless
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
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        // '/': (context) {
        //   return const MyApp();
        // },
        '/register': (_) => new MyListPerson(value: 'abc2'),
        '/UserAgent': (_) => new newPersonState(value: _BindControl.UserAgent),
        '/UserAgent2': (_) =>
            new newPersonState(value: _BindControl.UserAgent2),
        '/abc': (_) => new HomePage_list2(),
      },
      title: 'dddd',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Jobleave2(),
    );
  }
}

//先定義一個類別
class User {
  String id;
  User(this.id);
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
    _counterSink = _counterStreamController.sink;
    _counterStream = _counterStreamController.stream;
    _BindControl.FormControl_UserSeeN.text = "ddddd2";
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    //_BindControl.FormControl_UserSeeN.text = "bbb";
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
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.grey,
          onTap: _onTap,
          elevation: 15,
        ));
  }

  void onPressToNextScreen3() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => newPersonState(value: 'fff'),
      ),
    );
    //從 B 畫面回傳後更新畫面資料
    setState(() {
      if (result != null) {
        print(result);
      }
    });
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

//TODO GetDateLeave
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

  Widget _myorm(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        Container(
            alignment: Alignment.topCenter,
            width: double.infinity,
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Form(
                child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 180,
                    child: TextFormField(
                      enabled: true,
                      //'$textHolder'
                      //initialValue: '$textHolder',
                      controller: _BindControl.emailController,
                      decoration: InputDecoration(labelText: '單號'),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: TextFormField(
                      enabled: true,
                      //'$textHolder'
                      //initialValue: '$textHolder',
                      controller: _BindControl.ControllerUserNameN,
                      decoration: InputDecoration(labelText: '姓名'),
                    ),
                  )
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(
                  width: 180,
                  child: TextFormField(
                    enabled: true,
                    //'$textHolder'
                    //initialValue: '$textHolder',
                    controller: _BindControl.ControllerClassTypeN,
                    decoration: InputDecoration(labelText: '班別'),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: TextFormField(
                    enabled: true,
                    //'$textHolder'
                    //initialValue: '$textHolder',
                    controller: _BindControl.ControllerLeaveTypeN,
                    decoration: InputDecoration(labelText: '假別'),
                  ),
                )
              ]),
              //TODO pop 代理人
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/UserAgent',
                        arguments: {'name': 'Raymond'}).then((value) {
                      var list = [];
                      print('got');
                      print(value);
                      String dd = "";
                      dd = value.toString();
                      list = dd.split('/');
                      _BindControl.UserAgent = list[0];
                      _BindControl.FormControl_UserAgentN.text = list[1];
                    });
                  }, // Handle your callback
                  child: SizedBox(
                    width: 180,
                    child: TextFormField(
                      enabled: false,
                      //'$textHolder'
                      //initialValue: '$textHolder',
                      controller: _BindControl.FormControl_UserAgentN,
                      decoration: InputDecoration(labelText: '代理人1'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/UserAgent2',
                        arguments: {'name': 'Raymond'}).then((value) {
                      var list = [];
                      String dd = "";
                      dd = value.toString();
                      list = dd.split('/');
                      _BindControl.UserAgent2 = list[0];
                      _BindControl.FormControl_UserAgent2N.text = list[1];
                    });
                  }, // Handle yo
                  child: TextFormField(
                    enabled: false,
                    //'$textHolder'
                    //initialValue: '$textHolder',
                    controller: _BindControl.FormControl_UserAgent2N,
                    decoration: InputDecoration(labelText: '代理人2'),
                  ),
                ))
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/register',
                        arguments: {'name': 'Raymond'}).then((value) {
                      var list = [];
                      String dd = "";
                      dd = value.toString();
                      list = dd.split('/');
                      _BindControl.UserSee = list[0];
                      _BindControl.FormControl_UserSeeN.text = list[1];
                    });
                  },
                  child: SizedBox(
                    width: 180,
                    child: TextFormField(
                      enabled: false,
                      //'$textHolder'
                      //initialValue: '$textHolder',
                      controller: _BindControl.FormControl_UserSeeN,
                      decoration: InputDecoration(labelText: '監交人1'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/register',
                        arguments: {'name': 'Raymond'}).then((value) {
                      var list = [];
                      String dd = "";
                      dd = value.toString();
                      list = dd.split('/');
                      _BindControl.UserSee2 = list[0];
                      _BindControl.FormControl_UserSee2N.text = list[1];
                    });
                  },
                  child: TextFormField(
                    enabled: false,
                    //'$textHolder'
                    //initialValue: '$textHolder',
                    controller: _BindControl.FormControl_UserSee2N,
                    decoration: InputDecoration(labelText: '監交人2'),
                  ),
                ))
              ]),
              TextFormField(
                //'$textHolder'
                //initialValue: '$textHolder',
                controller: _BindControl.ControllerLeaveTypeN,
                decoration:
                    InputDecoration(icon: Icon(Icons.people), labelText: '假別'),
              ),
              OutlinedButton(
                child: Text(
                  '人員選單',
                  style: TextStyle(color: Colors.deepOrange),
                ),
                //TODO scrreen
                onPressed: onPressToNextScreen3,
              ),
              TextFormField(
                controller: _BindControl.FormControl_Reason,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '備註/原因',
                ),
                maxLines: 3,
              ),
            ]))),
      ]),
    );
  }

  //TODO lsaveStream
  Widget JobStreamNew(BuildContext context) {
    if (isNew == false) {
      return _myorm(context);
    }

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
              //TODO 設定controls
              var row = list_Modal_LeaveSch2[icount - 1];
              _UserNameN = row.UserNameN;
              // 请求成功，显示数据
              _BindControl.ControllerClassTypeN.text = row.ClassTypeN;
              _BindControl.ControllerLeaveTypeN.text = row.LeaveTypeN;
              _BindControl.emailController.text = _BatchID;
              _BindControl.ControllerUserNameN.text = _UserNameN;

              _BindControl.UserAgent = row.UserAgent;
              _BindControl.UserAgent2 = row.UserAgent2;
              _BindControl.FormControl_UserAgentN.text = row.UserAgentN;
              _BindControl.FormControl_UserAgent2N.text = row.UserAgent2N;

              _BindControl.UserSee = row.UserSee;
              _BindControl.UserSee2 = row.UserSee2;
              _BindControl.FormControl_UserSeeN.text = row.UserSeeN;

              _BindControl.FormControl_UserSee2N.text = row.UserSee2N;
              _BindControl.FormControl_Reason.text = row.Reason;
            }
            isNew = false;
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
