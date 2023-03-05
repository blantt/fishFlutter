import 'dart:async';

import 'package:blantt_love_test/component/blanttButton.dart';
import 'package:blantt_love_test/component/blanttColor.dart';
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
import 'package:blantt_love_test/page/pop/pop_LeaveType.dart';
import 'package:blantt_love_test/Model/modalBasic.dart';
import 'package:blantt_love_test/testTime.dart';
import 'package:intl/intl.dart';

String _BatchID = '';
String _UserNameN = '';

List<Modal_basic> _modal_time = [];

// isNew 判斷是不是第一次進來,因為有些事件,會重複觸發build,
//不是第一次進來,就不用再重抓資料bind,不然會有些例外狀況..
//感覺應該還有更好的寫法,等待進化版!!
bool isNew = true;

class BindControl {
  String UserAgent = "";
  String UserAgent2 = "";
  String UserSee = "";
  String UserSee2 = "";
  String LeaveType = "";

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
  runApp(Jobleave(""));
}

var _BindControl = BindControl();

class Jobleave extends StatelessWidget {
  String SendBatchID = '';
  Jobleave(this.SendBatchID);

  @override
  Widget build(BuildContext context) {
    //---這是另外一種傳值的寫法
    // final args = ModalRoute.of(context)!.settings.arguments as PageSend;
    // if (args != null) {
    //   _BatchID = args.BatchID;
    // } else {
    //   _BatchID = "h";
    // }
    _BatchID = this.SendBatchID;

    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        // '/': (context) {
        //   return const MyApp();
        // },
        '/popTime': (_) => new doorSelectTime(name1: '', name2: ''),
        '/register': (_) => new MyListPerson(value: 'abc2'),
        '/UserAgent': (_) => new newPersonState(value: _BindControl.UserAgent),
        '/LeaveType': (_) => new doorLeaveType2(),
        '/UserAgent2': (_) =>
            new newPersonState(value: _BindControl.UserAgent2),
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
  String testdd = "";

  int _counter = 0;
  late Stream _counterStream;
  late StreamSink _counterSink;
  StreamController<int> _counterStreamController = StreamController<int>(
    onCancel: () {},
    onListen: () {},
  );

  @override
  void initState() {
    testdd = "bb1";
    _counterSink = _counterStreamController.sink;
    _counterStream = _counterStreamController.stream;
    _BindControl.FormControl_UserSeeN.text = "ddddd2";
    SetTimeList();
    super.initState();
    print('in initState');
  }

  @override
  void didChangeDependencies() {
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
        body: Column(
          children: [
            JobStreamNew(context),
          ],
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
      if (result != null) {}
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

  //TODO testnewRange
  Widget testTimeRange() {
    Widget tempContainer(int itype, int Stype, Widget chid) {
      //itype 0:title,1.row
      //Stype row's index
      Color _color;
      Alignment _Alignment;

      double _height;
      if (Stype == 1) {
        _Alignment = Alignment.centerLeft;
      } else {
        _Alignment = Alignment.center;
      }

      if (itype == 0) {
        _height = 40;
        _color = MyColor.back_COLOR1;
      } else {
        _height = 40;
        _color = MyColor.back_COLOR2;
      }
      return Container(
        decoration: new BoxDecoration(
          color: _color,
          border: new Border.all(
            width: 1,
            color: Colors.white,
          ),
        ),
        // color: Colors.blue,

        alignment: _Alignment,
        width: 90,
        height: _height,
        child: chid,
      );
    }

    Widget temprowTitle() {
      return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Expanded(
            child: tempContainer(
              0,
              1,
              tempIconButton(
                my_onPressed: () {
                  Navigator.of(context).pushNamed('/popTime',
                      arguments: {'name1': '', 'name2': ''}).then((value) {
                    this.setState(() {
                      var _templist = [];
                      String _tempValue = "";
                      _tempValue = value.toString();
                      _templist = _tempValue.split('@');

                      print(value);

                      AddTimeList(Modal_basic(
                          name1: _templist[0], name2: _templist[1]));
                      // editTimeList("bbb", _templist[0], _templist[1]);
                    });
                  });
                },
                myicon: Icons.add,
                my_Backcolor33: Color.fromRGBO(54, 123, 148, 1.0),
              ),
            ),
            flex: 0),
        Expanded(
            child: tempContainer(
                0,
                2,
                myText(
                  m_text: '起始時間',
                  m_fountWeight: FontWeight.w700,
                  m_color: Colors.white,
                )),
            flex: 1),
        Expanded(
            child: tempContainer(
                0,
                3,
                myText(
                  m_text: '結束時間',
                  m_fountWeight: FontWeight.w700,
                  m_color: Colors.white,
                )),
            flex: 1),
      ]);
      //);
    }

    Widget TempTimeIcon(String name1, String name2) {
      return Row(
        children: [
          tempIconButton(
            my_onPressed: () {
              this.setState(() {
                _poptime(context, name1, name2);
              });

              // Navigator.of(context).pushNamed('/popTime',
              //     arguments: {'name1': name1, 'name2': name2}).then((value) {
              //   this.setState(() {
              //     var _templist = [];
              //     String _tempValue = "";
              //     _tempValue = value.toString();
              //     _templist = _tempValue.split('@');
              //
              //     print(value);
              //     editTimeList(name1, _templist[0], _templist[1]);
              //   });
              // });
            },
            myicon: Icons.edit,
          ),
          SizedBox(
            width: 2,
          ),
          tempIconButton(
            my_onPressed: () {
              this.setState(() {
                DelTimeList(name1);
                print('del');
              });
            },
            myicon: Icons.delete_forever,
          )
        ],
      );
    }

    Widget tempList() {
      return ListView.builder(
        itemBuilder: (BuildContext, index) {
          Widget tempCard;
          var row = _modal_time[index];

          Widget ttt;
          ttt = SizedBox(
            height: 35.0,
            width: 35.0,
            child: TextButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(87, 180, 156, 1.0),
                //side: BorderSide(width: 1.0, color: Colors.blueAccent),
              ),
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          );

          Widget bb =
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Expanded(
                child: tempContainer(1, 1, TempTimeIcon(row.name1, row.name2)),
                flex: 0),
            Expanded(child: tempContainer(1, 2, Text(row.name1)), flex: 1),
            Expanded(child: tempContainer(1, 3, Text(row.name2)), flex: 1),
          ]);

          return bb;
        },
        itemCount: _modal_time.length,
        shrinkWrap: true,
        padding: EdgeInsets.all(0),
        scrollDirection: Axis.vertical,
      );
    }

    String tt = "";
    final children = <Widget>[];
    children.add(temprowTitle());
    children.add(tempList());

    Widget bb() {
      //return sss();
      return Column(children: children);
    }

    ;

    return bb();
  }

  //TODO myform
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
                      enabled: false,
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
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/LeaveType',
                          arguments: {'name': 'Raymond'}).then((value) {
                        var _templist = [];

                        String _tempValue = "";
                        _tempValue = value.toString();
                        _templist = _tempValue.split('/');

                        _BindControl.LeaveType = _templist[0];
                        _BindControl.ControllerLeaveTypeN.text = _templist[1];
                      });
                    }, // Handle your callback
                    child: SizedBox(
                      width: 180,
                      child: TextFormField(
                        enabled: false,
                        controller: _BindControl.ControllerLeaveTypeN,
                        decoration: InputDecoration(labelText: '假別'),
                      ),
                    ),
                  ),
                )
              ]),

              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/UserAgent',
                        arguments: {'name': 'Raymond'}).then((value) {
                      var _templist = [];
                      String _tempValue = "";
                      _tempValue = value.toString();
                      _templist = _tempValue.split('/');
                      _BindControl.UserAgent = _templist[0];
                      _BindControl.FormControl_UserAgentN.text = _templist[1];
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
                    Navigator.of(context).pushNamed('/UserAgent',
                        arguments: {'name': 'Raymond'}).then((value) {
                      var _templist = [];
                      String _tempValue = "";
                      _tempValue = value.toString();
                      _templist = _tempValue.split('/');
                      _BindControl.UserAgent2 = _templist[0];
                      _BindControl.FormControl_UserAgent2N.text = _templist[1];
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
                    Navigator.of(context).pushNamed('/UserAgent',
                        arguments: {'name': 'Raymond'}).then((value) {
                      var _templist = [];
                      String _tempValue = "";
                      _tempValue = value.toString();
                      _templist = _tempValue.split('/');
                      _BindControl.UserSee = _templist[0];
                      _BindControl.FormControl_UserSeeN.text = _templist[1];
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
                    Navigator.of(context).pushNamed('/UserAgent',
                        arguments: {'name': 'Raymond'}).then((value) {
                      var _templist = [];
                      String _tempValue = "";
                      _tempValue = value.toString();
                      _templist = _tempValue.split('/');
                      _BindControl.UserSee2 = _templist[0];
                      _BindControl.FormControl_UserSee2N.text = _templist[1];
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

              OutlinedButton(
                child: Text(
                  'poptimeTest',
                  style: TextStyle(color: Colors.deepOrange),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/popTime',
                      arguments: {'name': 'aabb'}).then((value) {
                    this.setState(() {
                      var _templist = [];
                      String _tempValue = "";
                      _tempValue = value.toString();
                      _templist = _tempValue.split('@');

                      print(value);
                      editTimeList("bbb", _templist[0], _templist[1]);
                    });
                  });
                },
              ),
              //TODO======時間列表====

              testTimeRange(),

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

  //TODO set add time
  void SetTimeList() {
    _modal_time.clear();
    AddTimeList(
        Modal_basic(name1: '2020-01-02 01:30', name2: '2020-01-02 06:04'));
    AddTimeList(
        Modal_basic(name1: '2020-01-04 03:04', name2: '2020-01-04 15:04'));
  }

  void DelTimeList(String DelValue) {
    _modal_time.removeWhere((item) => item.name1 == DelValue);
  }

  void AddTimeList(Modal_basic item) {
    _modal_time.add(item);
  }

  //TODO edittimelist
  void editTimeList(String key, String Chanedate1, String Chanedate2) {
    _modal_time[_modal_time.indexWhere((element) => element.name1 == key)]
        .name2 = Chanedate2;
    _modal_time[_modal_time.indexWhere((element) => element.name1 == key)]
        .name1 = Chanedate1;
  }

  //TODO lsaveStream
  Widget JobStreamNew(BuildContext context) {
    GetDateLeave();
    return StreamBuilder<int>(
      stream: _counterStreamController.stream,
      builder: (
        BuildContext context,
        AsyncSnapshot<int> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return new Center(child: CircularProgressIndicator());
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
              _BindControl.ControllerClassTypeN.text = row.ClassTypeN;
              _BindControl.ControllerLeaveTypeN.text = row.LeaveTypeN;
              _BindControl.LeaveType = row.LeaveType;
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

  Future<void> _poptime(BuildContext context, String key, String name2) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => doorSelectTime(name1: key, name2: name2)),
    );
    var _templist = [];
    String _tempValue = "";
    _tempValue = result.toString();
    _templist = _tempValue.split('@');
    this.setState(() {
      editTimeList(key, _templist[0], _templist[1]);
    });
  }
}

class tempIconButton extends StatelessWidget {
  final IconData? myicon;
  final Color? my_Backcolor33;
  final Function my_onPressed;
  const tempIconButton({
    this.myicon,
    this.my_Backcolor33,
    required this.my_onPressed,
    Key? key,
  }) : super(key: key);

  //my_Backcolor= Color.fromRGBO(87, 180, 156, 1.0);
  @override
  Widget build(BuildContext context) {
    Color? my_Backcolor = Color.fromRGBO(87, 180, 156, 1.0);
    if (this.my_Backcolor33 != null) {
      my_Backcolor = my_Backcolor33;
    }

    return SizedBox(
      height: 40,
      width: 40,
      child: TextButton(
        style: ElevatedButton.styleFrom(
          primary: my_Backcolor,
          //side: BorderSide(width: 1.0, color: Colors.blueAccent),
        ),
        child: Icon(
          myicon,
          color: Colors.white,
        ),
        onPressed: () {
          my_onPressed();
        },
      ),
    );
  }
}
