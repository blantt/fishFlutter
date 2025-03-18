import 'dart:async';
import 'package:lovetest2/component/blanttButton.dart';
import 'package:lovetest2/component/blanttColor.dart';
import 'package:lovetest2/utils/dt_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:lovetest2/myConn.dart';
import 'dart:io';
import '../Model/Model2.dart';
import '../pop/popPerson.dart';
import 'package:lovetest2/pop/pop_LeaveType.dart';
import 'package:lovetest2/Model/modalBasic.dart';
import 'package:lovetest2/pop/popTime.dart';
import '../../component/blanttFileControl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lovetest2/dt_Dialog.dart';
import 'package:lovetest2/pop/popSelectFile.dart';

String _BatchID = '';
String _UserNameN = '';
String _UserName = '';
en_FromType nowFromtype = en_FromType._void;
List<Modal_basic_LeaveTime> _modal_time = [];
List<String> ListImage = [];

// isNew 判斷是不是第一次進來,因為有些事件,會重複觸發build,
//不是第一次進來,就不用再重抓資料bind,不然會有些例外狀況..
//感覺應該還有更好的寫法,等待進化版!!
bool isNew = true;

enum buttonType { _home, _save, _del, _send, _approve, _test }

enum en_FromType { _add, _edit, _return, _send, _app, _void }

enum filedType {
  _batchid,
  _name,
  //班別
  _class,
  //假別
  _type,
  //代理1
  _agent1,
  //代理2
  _agent2,
  _see1,
  _see2,
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class AlwaysDisabledFocusNode2 extends FocusNode {
  bool isEnabled;

  AlwaysDisabledFocusNode2({this.isEnabled = false});

  @override
  bool get hasFocus => isEnabled;
}

class BindControl {
  String UserAgent = "";
  String UserAgent2 = "";
  String UserSee = "";
  String UserSee2 = "";
  String LeaveType = "";
  //String MStatusN = "";
  String MStatus = "0";

  TextEditingController ControllerMStatusN = new TextEditingController();

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
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'NotoSansHK'),
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
MyFileControl classMyFile = MyFileControl(otherFolder: 'blantt2');

class _Jovleave extends State<Jobleave2> {
  //---重點是counterStreamController 要寫對地方,不然第二次進來stream,會出現錯誤!!!
  bool _isdataload = false;
  bool _isLoading = false;
  bool _stopLoading = false;
  bool _isallIsload = false; //目前測試,想當作判定確定所有的api都呼叫完成,
  bool _isFileload = false;
  String testdd = "";
  String _SelectFilePath = "";
  classUserInfo mySharedPreferences = classUserInfo();
  int _counter = 0;
  late Stream _counterStream;
  late StreamSink _counterSink;
  StreamController<int> _counterStreamController = StreamController<int>(
    onCancel: () {},
    onListen: () {},
  );
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
      _isLoading = false;
      _stopLoading = false;
    });
  }

  @override
  void initState() {
    testdd = "bb1";
    _counterSink = _counterStreamController.sink;
    _counterStream = _counterStreamController.stream;

    classMyFile.delFilefolder("");
    // GetFileList();
    GetfileListnew();
    GetDateLeave2();
    SetTimeList();

    super.initState();
    print('in initState');
  }

  void checkStates() {
    if (_isdataload == true && _isFileload == true) {
      _isallIsload = true;
    }
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
    print('測試目前檔案路徑:' + _SelectFilePath);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: MyColor.back_COLOR1, // 設定背景色為藍色
          title:
              //Text('請假單 ' + _BatchID),
              Row(
            children: [
              Text('請假單 ' + _BatchID),
              Expanded(child: Text('')),
              SizedBox(
                width: 35,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 105,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        myContain(
                          m_weight: 40,
                          m_heght: 40,
                          m_boxDecoration: BoxDecoration(
                            color: Color.fromRGBO(
                                111, 225, 227, 0.9019607843137255),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Positioned(
                            left: 20,
                            child: myContain(
                                m_Alignment: Alignment.centerLeft,
                                m_weight: 90,
                                m_heght: 50,
                                m_child: Text(
                                    _BindControl.ControllerMStatusN.text,
                                    style: TextStyle(
                                      // fontFamily: 'NotoSansHK',
                                      //fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(238, 228, 142, 1.0),
                                      letterSpacing: 2.0,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black45,
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 5.0,
                                        ),
                                      ],
                                    )))),
                      ],
                    ),
                  ))
            ],
          )),
      body: Stack(children: <Widget>[
        _isallIsload
            ? _myorm(context)
            : !_isallIsload
                ? CircularProgressIndicator() // Show a loading indicator
                : Container(),
        _isLoading
            ? MyLoadingWidget(
                m_Strload: '儲存中',
                m_btnStopShow: true,
                m_onPressed: _stopLoadingAnimation,
              )
            : Container(),
      ]),
      // bottomNavigationBar: BottomAppBar(
      //   child: Row(
      //     //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: buildRowChildren(),
      //   ),
      // )
      bottomNavigationBar: _isallIsload
          ? BottomAppBar(
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: buildRowChildren(),
              ),
            )
          : Container(),
    );
  }

  double tempwidgh = 8;

  List<Widget> buildRowChildren() {
    List<Widget> children = <Widget>[];
    children.add(SizedBox(
      width: tempwidgh,
    ));
    children.add(tempBottomButton(
      myitype: buttonType._home,
      my_onPressed: () {
        RouterUtil_test.myhome(context);
      },
    ));
    if (nowFromtype == en_FromType._edit) {
      children.add(SizedBox(
        width: tempwidgh,
      ));
      children.add(tempBottomButton(
        myitype: buttonType._save,
        my_onPressed: () {
          _toggleLoading();
          SaveAllPage();
        },
      ));
      children.add(SizedBox(
        width: tempwidgh,
      ));
      children.add(tempBottomButton(
        myitype: buttonType._del,
        my_onPressed: () {},
      ));
      children.add(SizedBox(
        width: tempwidgh,
      ));
      children.add(tempBottomButton(
        myitype: buttonType._send,
        my_onPressed: () {},
      ));
    }
    if (nowFromtype == en_FromType._send) {
      children.add(SizedBox(
        width: tempwidgh,
      ));
      children.add(tempBottomButton(
        myitype: buttonType._approve,
        my_onPressed: () {},
      ));
    }
    children.add(tempBottomButton(
      myitype: buttonType._test,
      my_onPressed: () {
        //TODO Test事件
        _popMyimage(context, 1);
      },
    ));
    return children;
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

  void _onTap(int index) {
    _selectedIndex = index;
    setState(() {
      if (index == 0) {
        //儲存
        _toggleLoading();
        SaveAllPage();
      }
    });
  }

  var itemtest2 = {
    "BatchID": "",
    "Reason": "",
    "UserName": "",
    "UserNameN": '',
    "LeaveTypeN": '',
    "DeptID": '',
    "LeaveType": '',
    "ClassType": '',
    "ClassTypeN": '',
    "ReturnReason": '',
    "MStatusN": '',
    "UserAgent": '',
    "UserAgent2": '',
    "UserAgentN": '',
    "UserAgent2N": '',
    "UserSee": '',
    "UserSee2": '',
    "UserSeeN": '',
    "UserSee2N": '',
  };

  //TODO 存檔
  Future<String> SaveAllPage() async {
    if (_modal_time.length == 0) {
      myDialog.Dialog_Message(context, '請至少輸入一筆時間', 0);

      _stopLoadingAnimation();
      return '';
    }

    var dio = Dio();
    for (int i = 0; i <= _modal_time.length - 1; i++) {
      // 在此处执行循环体中的操作
      _modal_time[i].DetailClassID = "xxx";
      _modal_time[i].STime2 = _modal_time[i].STime;
      _modal_time[i].ETime2 = _modal_time[i].ETime;
    }
    //--實測結果,傳給api時,STime 會被 STime2吃掉,不知為什麼?
    //暫時性解決,先在迴卷把Stime再補上,以後再找更好的解法

    try {
      // final response =
      //     await dio.post(m_url_SaveJovLeaveDetail, data: _modal_time);

      itemtest2["BatchID"] = _BatchID;
      itemtest2["Reason"] = _BindControl.FormControl_Reason.text;
      itemtest2["UserAgent"] = _BindControl.UserAgent;
      itemtest2["UserAgent2"] = _BindControl.UserAgent2;
      itemtest2["UserSee"] = _BindControl.UserSee;
      itemtest2["UserSee2"] = _BindControl.UserSee2;
      itemtest2["UserName"] = _UserName;

      Map<String, dynamic> requestData = {
        'detail': _modal_time,
        'master': itemtest2
      };

      Response response = await dio.post(
        m_url_SaveJovLeaveAll,
        data: [requestData],
      );

      if (response.statusCode == 200) {
        print('Q回傳:' + response.data);
        if (response.data != "0") {
          print('saveerror:' + response.data);
        }
        _stopLoadingAnimation();
        return response.data;
      } else {
        _stopLoadingAnimation();

        //  throw Exception('Failed to add leave.');
      }
    } catch (e) {
      if (e is DioError) {
      } else {}
    }

    return '';
  }

  Future<String> SaveDateLeave() async {
    var dio = Dio();
    // dio.options.contentType = Headers.formUrlEncodedContentType;
    //Add請假單
    //Addtest

    itemtest2["BatchID"] = _BatchID;
    itemtest2["Reason"] = _BindControl.FormControl_Reason.text;
    itemtest2["UserAgent"] = _BindControl.UserAgent;
    itemtest2["UserAgent2"] = _BindControl.UserAgent2;
    itemtest2["UserSee"] = _BindControl.UserSee;
    itemtest2["UserSee2"] = _BindControl.UserSee2;
    var response = await dio.post(
      m_url_UpdateJovLeave,
      //data: jsonEncode(itemtest),
      data: itemtest2,
      // options: Options(
      //   headers: {'Content-Type': 'application/json'},
      // ),
    );
    if (response.statusCode == 200) {
      if (response.data != "0") {
        print('error:' + response.data);
      }
      _stopLoadingAnimation();
      return response.data;
    } else {
      _stopLoadingAnimation();
      print('error');
      //  throw Exception('Failed to add leave.');
    }

    return '';
  }

  //TODO 取得附件List(new)
  Future<String> GetfileListnew() async {
    final response = await Dio().get(GetGetAmcJobLeaveImage() + '/' + _BatchID);
    String sss = "";

    if (response.statusCode == HttpStatus.ok) {
      print(_BatchID + ',有取到圖檔明細new');
      // print('file:' + response.data);
      var _templist = [];

      _templist = response.data.split('/');
      for (int i = 0; i <= _templist.length - 1; i++) {
        // 在此处执行循环体中的操作
        String url;
        url = 'https://editor.4kids.com.tw/Portal/imageClock/' +
            _BatchID +
            '/' +
            _templist[i];
        //---測試,如用網址用ip,目前是收不到檔案的

        print('filename:' + _templist[i]);
        classMyFile.setimage(url, _templist[i], funcCall: () {
          callevictImage(_templist[i]);
        });
      }
    }

    setState(() {
      _isFileload = true;
      checkStates();
    });

    // Future.delayed(Duration(seconds: 5), () {
    //   // 在这里写下您想要在等待2秒后执行的代码
    //
    // });

    return "";
  }

//TODO 取得表頭
  Future<String> GetDateLeave2() async {
    if (_BatchID == '') {
      print('是新增');

      _UserNameN = 'blantt';
      _BindControl.ControllerMStatusN.text = '新增';
      _BindControl.MStatus = "0";
      getNowFromType('0');
      _BindControl.emailController.text = _BatchID;

      _BindControl.ControllerClassTypeN.text = myUserBasic.ClassName;
      //  _BindControl.ControllerLeaveTypeN.text = row.LeaveTypeN;
      _BindControl.LeaveType = myUserBasic.ClassID;
      _UserName = myUserBasic.UserName;
      _BindControl.ControllerUserNameN.text = myUserBasic.FullName;

      //
      _BindControl.UserAgent = myUserBasic.UserAgent;
      _BindControl.UserAgent2 = myUserBasic.UserAgent2;
      _BindControl.FormControl_UserAgentN.text = myUserBasic.UserAgentN;
      _BindControl.FormControl_UserAgent2N.text = myUserBasic.UserAgent2N;
      //
      _BindControl.UserSee = myUserBasic.UserSee;
      _BindControl.UserSee2 = myUserBasic.UserSee2;
      _BindControl.FormControl_UserSeeN.text = myUserBasic.UserSeeN;

      _BindControl.FormControl_UserSee2N.text = myUserBasic.UserSee2N;
      _BindControl.FormControl_Reason.text = '';
    }
    {
      final response = await Dio().get(m_url_LeaveSch + '/' + _BatchID);
      String sss = "";

      if (response.statusCode == HttpStatus.ok) {
        print(_BatchID + ',有取到表頭明細');
        list_Modal_LeaveSch2 = (response.data as List<dynamic>)
            .map((e) => Modal_LeaveSch2.fromJson((e as Map<String, dynamic>)))
            .toList();

        var row = list_Modal_LeaveSch2[0];
        _UserNameN = row.UserNameN;
        //TODO 取得bind數據
        _BindControl.ControllerMStatusN.text = row.MStatusN;
        _BindControl.MStatus = row.MStatus;
        getNowFromType(row.MStatus);
        _UserName = row.UserName;
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
    }
    setState(() {
      _isdataload = true;
      checkStates();
    });
    return "";
  }

  //TODO 附件control
  Widget SetFileList() {
    ListImage = classMyFile.getFileList2();

    //print('附件大小' + ListImage.length.toString());

    return myContain(
      m_heght: 50,
      m_child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext, index) {
          Widget tempCard;

          Widget imageWidget;

          imageWidget = myContain(
            m_boxDecoration: new BoxDecoration(
              color: Colors.lightBlueAccent,
              border: new Border.all(
                width: 1,
                color: Colors.black,
              ),
            ),
            m_child: GestureDetector(
              onTap: () {
                //String ddd = _popMyimage(context, index);
                _popSelectFile(context, index);
              },
              child: Image.file(
                File(ListImage[index]),
                height: 80,
                width: 80,
              ),
            ),
          );

          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.0),
              child: imageWidget);
        },
        itemCount: ListImage.length,
        shrinkWrap: true,
        padding: EdgeInsets.all(0),
      ),
    );
  }

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

    bool isShow = true;
    if (nowFromtype == en_FromType._edit) {
      isShow = true;
    } else {
      isShow = false;
    }
    //TODO row title
    Widget temprowTitle() {
      return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
            decoration: new BoxDecoration(
              color: MyColor.back_COLOR1,
              border: new Border.all(
                width: 1,
                color: Colors.white,
              ),
            ),
            // color: Colors.blue,
            height: 40,
            //alignment: _Alignment,
            width: 90,
            child: Visibility(
              visible: isShow,
              child: TextButton.icon(
                  label: myText(
                    m_color: Colors.white,
                    m_text: "new",
                    m_fontsize: 16,
                  ),
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    //TODO--新增時段
                    _poptime_add(context, '', '');
                  }),
            )),
        Expanded(
            child: tempContainer(
                0,
                2,
                myText(
                  m_text: '起始時間',
                  m_fountWeight: FontWeight.w600,
                  m_color: Colors.white,
                  m_letterSpacing: 2,
                )),
            flex: 1),
        Expanded(
            child: tempContainer(
                0,
                3,
                myText(
                  m_text: '結束時間',
                  m_fountWeight: FontWeight.w600,
                  m_color: Colors.white,
                  m_letterSpacing: 2,
                )),
            flex: 1),
      ]);
      //);
    }

    Widget TempTimeIcon(String name1, String name2) {
      return Row(
        children: [
          Visibility(
              visible: isShow,
              child: tempIconButton(
                my_Backcolor33: MyColor.myblue,
                my_onPressed: () {
                  this.setState(() {
                    _poptime(context, name1, name2);
                  });
                },
                myicon: Icons.edit,
              )),
          SizedBox(
            width: 2,
          ),
          Visibility(
              visible: isShow,
              child: tempIconButton(
                my_Backcolor33: MyColor.back_COLOR3,
                my_onPressed: () {
                  this.setState(() {
                    DelTimeList(name1);
                  });
                },
                myicon: Icons.delete_forever,
              )),
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
                backgroundColor: Color.fromRGBO(87, 180, 156, 1.0),
                //side: BorderSide(width: 1.0, color: Colors.blueAccent),
              ),
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          );
          //TODO 時間ui
          Widget bb =
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Expanded(
                child: tempContainer(1, 1, TempTimeIcon(row.STime, row.ETime)),
                flex: 0),
            Expanded(child: tempContainer(1, 2, Text(row.STime)), flex: 1),
            Expanded(child: tempContainer(1, 3, Text(row.ETime)), flex: 1),
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

  Widget from1(BuildContext context) {
    UnderlineInputBorder tempenabledBorder;
    tempenabledBorder = UnderlineInputBorder(
      borderSide: BorderSide(
          width: 3, color: MyColor.myblue.withOpacity(0.5)), //<-- SEE HERE
    );
    UnderlineInputBorder tempfocusedBorder;
    tempfocusedBorder = UnderlineInputBorder(
      borderSide: BorderSide(width: 3, color: Colors.blue),
    );

    bool bbShow = false;
    if (nowFromtype == en_FromType._edit) {
      bbShow = true;
    }

    print(_BatchID + ',開始進來讀取form表頭2' + _BindControl.ControllerUserNameN.text);
    return Container(
      alignment: Alignment.topCenter,
      width: double.infinity,
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Form(
        child: Column(
          children: [
            tempFormField(filedType._batchid, filedType._name),
            tempFormField(filedType._class, filedType._type),
            tempFormField(filedType._agent1, filedType._agent2),
            tempFormField(filedType._see1, filedType._see2),

            SizedBox(
              height: 1,
            ),
            //TODO======時間列表====
            testTimeRange(),
            SizedBox(
              height: 10,
            ),

            TextFormField(
              focusNode: new AlwaysDisabledFocusNode2(isEnabled: bbShow),
              controller: _BindControl.FormControl_Reason,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '備註/原因',
              ),
              maxLines: 3,
            ),

            myContain(
              m_heght: 45,
              m_Alignment: Alignment.topCenter,
              m_boxDecoration: new BoxDecoration(
                color: MyColor.back_COLOR2,
                border: new Border.all(
                  width: 1,
                  color: Colors.black,
                ),
              ),
              m_child: Row(
                children: [
                  Expanded(
                      child: Visibility(
                    visible: bbShow,
                    child: tempIconButton2(
                      myitype: 0,
                      my_onPressed: () {
                        _popMyimage(context, -1);
                      },
                    ),
                  )),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      //color: Colors.green,
                      child: myText(
                        m_text: '附件',
                        m_letterSpacing: 2,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        // color: Colors.amber,
                        ),
                  ),
                ],
              ),
            ),
            myContain(
              m_heght: 100,
              m_Alignment: Alignment.topCenter,
              m_boxDecoration: new BoxDecoration(
                color: Color.fromRGBO(183, 183, 183, 1.0),
                border: new Border.all(
                  width: 1,
                  color: Colors.black,
                ),
              ),
              m_child: Column(
                children: [
                  Expanded(
                      child: myContain(
                          m_boxDecoration: new BoxDecoration(
                            // color: Colors.redAccent,
                            border: new Border.all(
                              width: 1,
                              color: MyColor.back_COLOR1,
                            ),
                          ),
                          m_child: SetFileList()))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //--陰件集合
  Widget FileList() {
    return Text('預計這裡放置圖片');
  }

 

  //TODO myform2
  Widget _myorm(BuildContext context) {
    print(_BatchID + '開始進來讀取form表頭');

    if (_isallIsload == true) {
      print('_isallIsload=true');
    } else {
      print('_isallIsload=false');
    }

    

    return SingleChildScrollView(
      child: Column(children: <Widget>[
        from1(context),
      ]),
    );
  }

  void callevictImage(String FileName) {
    this.setState(() {
      classMyFile.evictImage(FileName);
    });
  }

  //TODO 取得圖檔附件list
  //取得陰件list
  void GetFileList() {
    String url;
    url =
        'https://editor.4kids.com.tw/Portal/imageClock/A202303170002/0316.jpg';

    //url = 'http://192.168.100.131:678/imageClock/A202309220001/1122.png';
    classMyFile.setimage(url, 'aaa3.png', funcCall: () {
      callevictImage('aaa3.png');
    });
    url = 'https://cdn-icons-png.flaticon.com/512/3884/3884851.png';
    classMyFile.setimage(url, 'aaa4.png', funcCall: () {
      callevictImage('aaa4.png');
    });
    // ListImage.add(url);
  }

  Widget WidgetFile() {
    return Text('');
  }

  Future<String> GetDateLeaveDetail() async {
    if (_BatchID == '') {
    } else {
      final response = await Dio().get(GetLeaveDetail() + '/' + _BatchID);
      String sss = "";

      list_Modal_LeaveSch2 = (response.data as List<dynamic>)
          .map((e) => Modal_LeaveSch2.fromJson((e as Map<String, dynamic>)))
          .toList();

      if (response.statusCode == HttpStatus.ok) {
        print(_BatchID + '有取到時間明細');
        _modal_time = (response.data as List<dynamic>)
            .map((e) =>
                Modal_basic_LeaveTime.fromJson((e as Map<String, dynamic>)))
            .toList();

        for (int i = 0; i <= _modal_time.length - 1; i++) {
          // 在此处执行循环体中的操作
          _modal_time[i].STime = _modal_time[i].STime2;
          _modal_time[i].ETime = _modal_time[i].ETime2;
        }
      }
    }

    return "";
  }

  //TODO 取得時間明細
  void SetTimeList() {
    _modal_time.clear();

    GetDateLeaveDetail();
  }

  void DelTimeList(String DelValue) {
    _modal_time.removeWhere((item) => item.STime == DelValue);
  }

  void AddTimeList(Modal_basic_LeaveTime item) {
    _modal_time.add(item);
  }

  //TODO edittimelist
  void editTimeList(String key, String Chanedate1, String Chanedate2) {
    _modal_time[_modal_time.indexWhere((element) => element.STime == key)]
        .ETime = Chanedate2;
    _modal_time[_modal_time.indexWhere((element) => element.STime == key)]
        .STime = Chanedate1;
  }

  //TODO 自設formfield
  Widget tempFormField(filedType stype1, filedType stype2) {
    UnderlineInputBorder tempenabledBorder;
    tempenabledBorder = UnderlineInputBorder(
      borderSide: BorderSide(
          width: 3, color: MyColor.myblue.withOpacity(0.5)), //<-- SEE HERE
    );
    UnderlineInputBorder tempfocusedBorder;
    tempfocusedBorder = UnderlineInputBorder(
      borderSide: BorderSide(width: 3, color: Colors.blue),
    );

    bool bshow(filedType settype) {
      if (settype == filedType._batchid ||
          settype == filedType._class ||
          settype == filedType._name) {
        return false;
      } else {
        if (nowFromtype == en_FromType._edit) {
          return true;
        } else {
          return false;
        }
      }
    }

    String templabel(filedType settype) {
      if (settype == filedType._batchid) {
        return '單據號碼';
      }
      if (settype == filedType._class) {
        return '班別';
      }
      if (settype == filedType._type) {
        return '假別';
      }
      if (settype == filedType._agent1) {
        return '代理人1';
      }
      if (settype == filedType._agent2) {
        return '代理人2';
      }

      if (settype == filedType._see2) {
        return '監交人2';
      }

      if (settype == filedType._see1) {
        return '監交人1';
      }
      if (settype == filedType._see2) {
        return '監交人2';
      }
      if (settype == filedType._name) {
        return '請假人';
      }
      return '';
    }

    void btnevent(filedType settype) {
      if (settype == filedType._type) {
        this.setState(() {
          Navigator.of(context).pushNamed('/LeaveType',
              arguments: {'name': 'Raymond'}).then((value) {
            var _templist = [];

            String _tempValue = "";
            _tempValue = value.toString();
            _templist = _tempValue.split('/');

            _BindControl.LeaveType = _templist[0];
            _BindControl.ControllerLeaveTypeN.text = _templist[1];
          });
        });
      }

      if (settype == filedType._agent1) {
        this.setState(() {
          Navigator.of(context).pushNamed('/UserAgent',
              arguments: {'name': 'Raymond'}).then((value) {
            var _templist = [];
            String _tempValue = "";
            _tempValue = value.toString();
            _templist = _tempValue.split('/');
            _BindControl.UserAgent = _templist[0];
            _BindControl.FormControl_UserAgentN.text = _templist[1];
          });
        });
      }

      if (settype == filedType._agent2) {
        this.setState(() {
          Navigator.of(context).pushNamed('/UserAgent',
              arguments: {'name': 'Raymond'}).then((value) {
            var _templist = [];
            String _tempValue = "";
            _tempValue = value.toString();
            _templist = _tempValue.split('/');
            _BindControl.UserAgent2 = _templist[0];
            _BindControl.FormControl_UserAgent2N.text = _templist[1];
          });
        });
      }
      if (settype == filedType._see1) {
        this.setState(() {
          Navigator.of(context).pushNamed('/UserAgent',
              arguments: {'name': 'Raymond'}).then((value) {
            var _templist = [];
            String _tempValue = "";
            _tempValue = value.toString();
            _templist = _tempValue.split('/');
            _BindControl.UserSee = _templist[0];
            _BindControl.FormControl_UserSeeN.text = _templist[1];
          });
        });
      }
      if (settype == filedType._see2) {
        Navigator.of(context).pushNamed('/UserAgent',
            arguments: {'name': 'Raymond'}).then((value) {
          var _templist = [];
          String _tempValue = "";
          _tempValue = value.toString();
          _templist = _tempValue.split('/');
          _BindControl.UserSee2 = _templist[0];
          _BindControl.FormControl_UserSee2N.text = _templist[1];
        });
      }
    }

    TextEditingController tempController(filedType settype) {
      if (settype == filedType._batchid) {
        return _BindControl.emailController;
      }
      if (settype == filedType._name) {
        return _BindControl.ControllerUserNameN;
      }
      if (settype == filedType._type) {
        return _BindControl.ControllerLeaveTypeN;
      }
      if (settype == filedType._class) {
        return _BindControl.ControllerClassTypeN;
      }
      if (settype == filedType._class) {
        return _BindControl.ControllerLeaveTypeN;
      }
      if (settype == filedType._agent1) {
        return _BindControl.FormControl_UserAgentN;
      }
      if (settype == filedType._agent2) {
        return _BindControl.FormControl_UserAgent2N;
      }

      if (settype == filedType._see1) {
        return _BindControl.FormControl_UserSeeN;
      }
      if (settype == filedType._see2) {
        return _BindControl.FormControl_UserSee2N;
      }
      return _BindControl.emailController;
    }

    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Expanded(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {},
              child: SizedBox(
                  //height: 150,
                  //width: 140,
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: TextFormField(
                  maxLines: 1, // 设置最大行数，这会自动调整高度
                  focusNode: new AlwaysDisabledFocusNode2(isEnabled: false),
                  controller: tempController(stype1),
                  decoration: InputDecoration(
                      enabledBorder: tempenabledBorder,
                      focusedBorder: tempfocusedBorder,
                      labelText: templabel(stype1)),
                ),
              )),
            ),
          ),
          Visibility(
            visible: bshow(stype1), // 根據條件來控制顯示與隱藏
            child: SizedBox(
                child: tempIconButton(
              my_Backcolor33: MyColor.myblue.withOpacity(0.5),
              my_onPressed: () {
                this.setState(() {
                  btnevent(stype1);
                });
              },
              myicon: Icons.search_sharp,
            )),
          ),
        ],
      )),
      SizedBox(
        width: 5,
      ),
      Expanded(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {},
              child: SizedBox(
                //width: 140,
                child: TextFormField(
                  focusNode: new AlwaysDisabledFocusNode2(isEnabled: false),
                  controller: tempController(stype2),
                  decoration: InputDecoration(
                      enabledBorder: tempenabledBorder,
                      focusedBorder: tempfocusedBorder,
                      labelText: templabel(stype2)),
                ),
              ),
            ),
          ),
          Visibility(
            visible: bshow(stype2), // 根據條件來控制顯示與隱藏
            child: SizedBox(
                child: tempIconButton(
              my_Backcolor33: MyColor.myblue.withOpacity(0.5),
              my_onPressed: () {
                this.setState(() {
                  btnevent(stype2);
                });
              },
              myicon: Icons.search_sharp,
            )),
          ),
        ],
      )),
    ]);
  }

  void getNowFromType(String mstatus) {
    if (mstatus == "0") {
      nowFromtype = en_FromType._edit;
    }
    if (mstatus == "3") {
      nowFromtype = en_FromType._edit;
    }
    if (mstatus == "5") {
      nowFromtype = en_FromType._send;
    }
    if (mstatus == "10") {
      nowFromtype = en_FromType._app;
    }
    if (mstatus == "99") {
      nowFromtype = en_FromType._void;
    }
  }

  //TODO pop選擇圖檔
  Future<void> _popSelectFile(BuildContext context, int index) async {
    Widget myob;
    File? myfile;
    Image? myimage;
    String fileName = "";

    // 在使用之前进行空值检查
    if (index == -1) {
      //新增時沒有點案,給個空的
      myob = myContain(
        m_heght: 150,
        m_weight: 150,
      );
    } else {
      // 使用Image Widget
      myfile = File(ListImage[index]);
      _SelectFilePath = ListImage[index];
      //--這個方式是用file路徑聯結
      myimage = Image.file(
        File(_SelectFilePath),
        height: 150,
        width: 150,
      );

      fileName = myfile.path.split('/').last;
      myob = myimage;
    }

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => popSelectFile(SelectFile: _SelectFilePath)),
    );
    print('原本的路徑:' + ListImage[index]);
    print('回傳的路徑:' + result);

    this.setState(() {
      classMyFile.delFilefolder(ListImage[index]); //目前這
      // 一行並沒有起作用?!
      classMyFile.Copyimage(result, 'ddddd');
      ListImage[index] = result;
    });
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

  Future<void> _poptime_add(
      BuildContext context, String key, String name2) async {
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

    Modal_basic_LeaveTime dd = Modal_basic_LeaveTime(
        BatchID: _BatchID,
        STime: _templist[0],
        ETime: _templist[1],
        STime2: _templist[0],
        ETime2: _templist[1],
        DetailClassID: '');

    this.setState(() {
      AddTimeList(dd);
    });
  }

  List<int>? convertImageToBytes(String imagePath) {
    File imageFile = File(imagePath);
    if (imageFile.existsSync()) {
      List<int> fileBytes = imageFile.readAsBytesSync();
      return fileBytes;
    } else {
      print('Image file does not exist');
      return null;
    }
  }

  //TODO 選擇圖片視窗 OLD
  _popMyimage(BuildContext context, int index) {
    Widget myob;

    File? myfile;

    Image? myimage;
    String fileName = "";

    // 在使用之前进行空值检查
    if (index == -1) {
      //新增時沒有點案,給個空的
      myob = myContain(
        m_heght: 150,
        m_weight: 150,
      );
    } else {
      // 使用Image Widget
      myfile = File(ListImage[index]);
      _SelectFilePath = ListImage[index];
      //--這個方式是用file路徑聯結
      myimage = Image.file(
        File(_SelectFilePath),
        height: 150,
        width: 150,
      );

      fileName = myfile.path.split('/').last;
      myob = myimage;
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Expanded(
            child: SimpleDialog(
              title: Text('select file'),
              children: [
                // myimage,
                myob,
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: myContain(
                    m_heght: 35,
                    m_Alignment: Alignment.center,
                    m_child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        myButton(
                          m_child: myText(
                            m_text: '選擇圖片',
                            m_color: Colors.black,
                          ),
                          m_onPressed: () {
                            _openImagePicker(fileName);
                          },
                        ),
                        myButton(
                          m_child: myText(
                            m_text: '取消',
                            m_color: Colors.black,
                          ),
                          m_onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, "NO");
                  },
                  child: Text(
                    'NO',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (myfile != null) {
                      List<int> fileBytes = myfile.readAsBytesSync();
                      uploadFile("ddd", fileName, fileBytes);
                    }
                  },
                  child: Text(
                    'savetest',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          );
        }).then((value) => debugPrint(value));
  }

  //TODO 檔案上傳
  void uploadFile(String filepath, String filename, List<int> fileBytes) async {
    Dio dio = Dio();
    String apiUrl = m_url_SaveUploadFile2;

//    List<int> fileBytes;
    // 创建FormData对象
    FormData formData = FormData.fromMap({
      'batchid': _BatchID,
      'filename': filename,
      'filebyte': MultipartFile.fromBytes(fileBytes, filename: filename),
    });

    try {
      // 发送POST请求
      Response response = await dio.post(apiUrl, data: formData);

      if (response.statusCode == 200) {
        print('文件上传成功');
        print('回傳:' + response.data);
      } else {
        print('文件上传失败');
      }
    } catch (e) {
      print('请求失败: $e');
    }
  }

  Future<void> _openImagePicker(String oldfilename) async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery); // 打开手机相册

    if (pickedFile != null) {
      print('我選擇了圖片');
      //--(待驗證)取得圖片,取得文件名,刪除原來的檔案,並且寫入選擇的檔案

      //String fileName = basename(pickedFile.path);
      String filePath = pickedFile.path;
      File file = File(filePath);
      String fileName = file.path.split('/').last;
      print('选中的文件名：$fileName');

      classMyFile.delFilefolder(oldfilename);
      classMyFile.Copyimage(pickedFile.path, fileName);

      print('這是完整的文件名嗎 ??：' + filePath);

      this.setState(() {
        _SelectFilePath = filePath;
      });
    }
  }
}

//TODO IconButton
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
    Color? my_Backcolor = MyColor.back_COLOR1;
    if (this.my_Backcolor33 != null) {
      my_Backcolor = my_Backcolor33;
    }

    return SizedBox(
      height: 40,
      width: 40,
      child: TextButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: my_Backcolor,

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

//-TODO 下方巡覽列按鈕
class tempBottomButton extends StatelessWidget {
  final buttonType myitype;
  final Function my_onPressed;
  const tempBottomButton({
    required this.myitype,
    required this.my_onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Icon myicon = Icon(Icons.save);
    String myText = "";
    bool isshow = true;

    if (myitype == buttonType._save) {
      myicon = Icon(Icons.save);
      myText = "儲存";
      if (nowFromtype != en_FromType._edit) {
        isshow = false;
      }
    }
    if (myitype == buttonType._del) {
      myicon = Icon(Icons.delete);
      myText = "刪除";
      if (nowFromtype != en_FromType._edit) {}
    }
    if (myitype == buttonType._home) {
      myicon = Icon(Icons.home);
      myText = "Home";
    }
    if (myitype == buttonType._send) {
      myicon = Icon(Icons.add_circle);
      myText = "送審";
    }

    if (myitype == buttonType._approve) {
      myicon = Icon(Icons.access_alarm);
      myText = "簽核";
    }
    if (myitype == buttonType._test) {
      myicon = Icon(Icons.add_box);
      myText = "test";
    }
    return Visibility(
        // visible: isshow,
        child: myContain(
      m_weight: 55,
      m_heght: 45,
      m_boxDecoration: new BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      m_child: InkWell(
        splashColor: Colors.green,
        onTap: () {
          my_onPressed();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            myicon, // <-- Icon
            Text(myText), // <-- Text
          ],
        ),
      ),
    ));
  }
}

//TODO add button
class tempIconButton2 extends StatelessWidget {
  final int myitype;
  final IconData? myicon;
  final Function my_onPressed;
  const tempIconButton2({
    required this.myitype,
    this.myicon,
    required this.my_onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? my_Backcolor = MyColor.back_COLOR1;

    Widget tempIcon;
    tempIcon = Icon(
      Icons.add,
      color: Colors.white,
    );
    Widget tempLabel;
    tempLabel = myText(
      m_color: Colors.white,
      m_text: "new",
      m_fontsize: 16,
    );

    if (myitype == 0) {}

    return Container(
        alignment: Alignment.topLeft,
        child: Container(
            // width: 90,
            //TODO now my textbutton

            child: TextButton.icon(
                label: tempLabel,
                icon: tempIcon,
                onPressed: () {
                  my_onPressed();
                }),
            decoration: new BoxDecoration(
              color: Color.fromRGBO(100, 176, 231, 1.0),
              border: new Border.all(
                width: 1,
                color: Colors.green,
              ),
              boxShadow: [
                BoxShadow(
                    color: MyColor.back_COLOR3,
                    offset: Offset(3.0, 0.0), //陰影y軸偏移量
                    blurRadius: 2, //陰影模糊程度
                    spreadRadius: 0 //陰影擴散程度
                    )
              ],
            )));
  }
}
