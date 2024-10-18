import 'package:blantt_love_test/component/blanttButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../TryMenu.dart';
import 'package:blantt_love_test/utils/dt_router.dart';
import 'package:blantt_love_test/component/blanttColor.dart';
import 'package:blantt_love_test/Model/modalBasic.dart';
import '../main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:blantt_love_test/myConn.dart';
import 'package:blantt_love_test/dt_Dialog.dart';
// import 'package:blantt_love_test/page/JobLeave.dart';


class classhome extends StatefulWidget {
  // const classhome({Key? key}) : super(key: key);

  @override
  classhome2 createState() => classhome2();
}

classUserInfo mySharedPreferences = classUserInfo();

 
TextEditingController Control_Login_Username = new TextEditingController();
TextEditingController Control_Login_PassWord = new TextEditingController();

TextEditingController Control_Username = new TextEditingController();
TextEditingController Control_Fullname = new TextEditingController();

bool islogin = false;
bool isGetUser = false;

enum btnType {
  //請假單
  type1,
  //加班單
  type2,
  //補休單
  type3,
  //公出單
  type4,
}

List<Modal_Person_basic> ListPersonBasic = [
  Modal_Person_basic(
    UserName: '',
    FullName: '',
    RosterN: '',
    ClassID: '',
    ClassName: '',
    SHH: '',
    EHH: '',
    SleepHH1: '',
    SleepHH2: '',
    UserAgent: '',
    UserAgentN: '',
    UserAgent2: '',
    UserAgent2N: '',
    UserSee: '',
    UserSeeN: '',
    UserSee2: '',
    UserSee2N: '',
    UserBoss: '',
    UserBossN: '',
  )
];

class classhome2 extends State<classhome> {
  classUserInfo mySharedPreferences = classUserInfo();

  void ClearUserInfo() {
    isGetUser = false;
    setState(() {});
  }

  //TODO 取得人員資料
  void GetUserInfo() async {
    print('開始取得人員資料2');

    String? UserName = await mySharedPreferences.get_UserName();
    String? FullName = await mySharedPreferences.get_FullName();
    String? ClassID = await mySharedPreferences.get_ClassID();
    String? ClassName = await mySharedPreferences.get_ClassName();
    String? UserAgent = await mySharedPreferences.get_UserAgent();
    String? UserAgent2 = await mySharedPreferences.get_UserAgent2();
    String? UserAgentN = await mySharedPreferences.get_UserAgentN();
    String? UserAgent2N = await mySharedPreferences.get_UserAgent2N();
    String? UserSee = await mySharedPreferences.get_UserSee();
    String? UserSee2 = await mySharedPreferences.get_UserSee2();
    String? UserSeeN = await mySharedPreferences.get_UserSeeN();
    String? UserSee2N = await mySharedPreferences.get_UserSee2N();

    if (UserName != null) {
      islogin = (await mySharedPreferences.get_islogin())!;
      if (UserName == '') {
        Control_Fullname.text = "您好:訪客1";
        isGetUser = true;
        setState(() {});
        return;
      } else {
        myUserBasic.UserName = UserName;
        myUserBasic.FullName = FullName!;
        myUserBasic.ClassID = ClassID!;
        myUserBasic.ClassName = ClassName!;
        myUserBasic.UserAgent = UserAgent!;
        myUserBasic.UserAgent2 = UserAgent2!;
        myUserBasic.UserAgentN = UserAgentN!;
        myUserBasic.UserAgent2N = UserAgent2N!;
        myUserBasic.UserSee = UserSee!;
        myUserBasic.UserSee2 = UserSee2!;
        myUserBasic.UserSeeN = UserSeeN!;
        myUserBasic.UserSee2N = UserSee2N!;
        Control_Username.text = myUserBasic.UserName;
        Control_Fullname.text = "您好:" + myUserBasic.FullName;
      }
    } else {
      isGetUser = true;
      Control_Fullname.text = "您好:訪客";
      setState(() {});
      return;
    }

    if (islogin == true) {
      print('now is login');
    } else {
      print('now isnot login');
    }

    isGetUser = true;
    setState(() {});
  }

  //TODO 預計這裡取得新的 loginUser
  Future<String> GetNewLoginUser() async {
    //---這裡己可正確的抓到使用者的輸入的帳密,並且傳入API,得回員工資料,
    //--目前還沒做驗證部份,不過照理應是可以實現了!!

    String tt = m_url_PersonBasic + "/" + Control_Login_Username.text;

    final response = await Dio().get(tt);
    String sss = "";
    if (response.statusCode == HttpStatus.ok) {
      ListPersonBasic = (response.data as List<dynamic>)
          .map((e) => Modal_Person_basic.fromJson((e as Map<String, dynamic>)))
          .toList();
      setState(() {});
      var row = ListPersonBasic[0];
      mySharedPreferences.set_UserName(row.UserName);
      mySharedPreferences.set_FullName(row.FullName);
      mySharedPreferences.set_ClassID(row.ClassID);
      mySharedPreferences.set_ClassName(row.ClassName);
      mySharedPreferences.set_test(row.UserName);
      mySharedPreferences.set_UserAgent(row.UserAgent);
      mySharedPreferences.set_UserAgent2(row.UserAgent2);
      mySharedPreferences.set_UserAgentN(row.UserAgentN);
      mySharedPreferences.set_UserAgent2N(row.UserAgent2N);
      mySharedPreferences.set_UserSee(row.UserSee);
      mySharedPreferences.set_UserSee2(row.UserSee2);
      mySharedPreferences.set_UserSeeN(row.UserSeeN);
      mySharedPreferences.set_UserSee2N(row.UserSee2N);
      mySharedPreferences.set_islogin(true);

      _loadStoredText();
      print('測試讀取人員' + row.UserAgentN);
    }

    return "";
  }

  void _getNewUser() async {
    mySharedPreferences.set_FullName("小犬中3");
    mySharedPreferences.set_islogin(true);
  }

  void _loadStoredText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    GetUserInfo();
  }

  @override
  void initState() {
    _loadStoredText();
  }

  @override
  Widget build(BuildContext context) {
    return _homemenu2(context);
  }

  //TODO 目前body在這裡
  Widget _homemenu2(BuildContext context) {
    List spans = [];

    spans.add(TextSpan(text: 'dddd2'));

    RichText _test1;
    RichText _test2;
    _test1 = RichText(
      text: TextSpan(
        //outer span
        style: TextStyle(
            fontWeight: FontWeight.w500, color: Colors.black54, fontSize: 24),
        text: Control_Fullname.text,
      ),
    );
    _test2 = RichText(
      text: TextSpan(
        //outer span
        style: TextStyle(
            fontWeight: FontWeight.w400, color: Colors.black54, fontSize: 20),
        text: "well com AMC FaceBook",
      ),
    );
    //  isGetUser = true;

    return new Scaffold(
      body: !isGetUser
          ? Center(
              child: MyLoadingWidget(
                m_Strload: '',
                // m_btnStopShow: true,
              ),
            )
          : Column(children: [
              Container(
                alignment: Alignment.bottomLeft,
                width: double.infinity,
                height: 500,
                decoration: new BoxDecoration(
                    image: DecorationImage(
                      // image: AssetImage("assets/images/index_top1.jpg"),
                      image: AssetImage("assets/images/index_top1_new.png"),
                      fit: BoxFit.fill,
                    ),
                    color: Colors.greenAccent),
                child: Column(
                  children: [
                    isGetUser
                        ? Container(
                            margin: const EdgeInsets.only(left: 10, top: 25),
                            alignment: Alignment.bottomLeft,
                            width: double.infinity,
                            child: Row(children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: _test1,
                              ),
                              //右邊icon button
                              Expanded(
                                  //    child: _iconbutton(context)
                                  child: Text('')),
                              Visibility(
                                visible: islogin,
                                child: homeiconButton(context, 2),
                              ),

                              SizedBox(
                                width: 2,
                              ),
                              Visibility(
                                visible: !islogin,
                                child: homeiconButton(context, 1),
                              ),

                              SizedBox(
                                width: 2,
                              ),
                              homeiconButton(context, 99),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              // homeiconButton(context, 98),
                              // SizedBox(
                              //   width: 5,
                              // )
                            ]),
                          )
                        : Container(),

                    //TODO 上方的icon產出
                  ],
                ),
              ),
              //TODO 下方的button產出
              Container(
                  child: Column(children: [
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    tempIconButton(
                        myitype: 0,
                        mytext: '請假單',
                        my_onPressed: () {
                          RouterUtil_test.callpage(
                              context, en_runterType.jobLeaveSch);
                          //  RouterUtil_test.toJobLeaveList(context);
                        }),
                    //tempicontest(),
                    SizedBox(
                      width: 30,
                    ),
                    tempIconButton(
                        myitype: 0, mytext: '加班單', my_onPressed: () {}),
                  ],
                )),
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //TODO testicon
                  children: [
                    tempIconButton(
                        myitype: 0, mytext: '補休單', my_onPressed: () {}),
                    //tempicontest(),
                    SizedBox(
                      width: 30,
                    ),
                    tempIconButton(
                        myitype: 0, mytext: '公出單', my_onPressed: () {}),
                  ],
                )),
              ])),
            ]),
    );
  }

  Widget mybutton(BuildContext _context, btnType _type) {
    String _ttt = '';

    if (_type == btnType.type1) {
      _ttt = '請假單';
    }
    if (_type == btnType.type2) {
      _ttt = '加班單';
    }
    if (_type == btnType.type3) {
      _ttt = '補休單';
    }
    if (_type == btnType.type4) {
      _ttt = '公出單';
    }

    var d = '';

    BuildContext _myContext;

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(140, 40),
          onPrimary: Colors.white,
          primary: Color.fromRGBO(8, 93, 185, 1.0),
          onSurface: Colors.grey,
          //side: BorderSide(color: Colors.black, width: 1),
          elevation: 10,
        ),
        onPressed: () {
          if (_type == btnType.type1) {
            RouterUtil_test.toJobLeaveList(_context);
          }
          if (_type == btnType.type2) {}
          if (_type == btnType.type3) {}
          if (_type == btnType.type4) {}
        },
        child: RichText(
          text: TextSpan(
            //outer span
            style: TextStyle(
                fontWeight: FontWeight.w400,
                // color: Colors.black54,
                fontSize: 18),
            text: _ttt,
          ),
        ));
  }

  Widget tempicontest() {
    return TextButton.icon(
      onPressed: () {
// 按钮被点击时的操作
      },
      icon: Padding(
        padding: EdgeInsets.zero, // 将图标的内边距设置为零
        child: Icon(Icons.favorite),
      ),
      label: Padding(
        padding: EdgeInsets.zero, // 将标签的内边距设置为零
        child: Text('喜欢'),
      ),
    );
  }

  Widget homeiconButton(BuildContext context, int itype) {
    String sss = "";
    Icon ccc = Icon(
      Icons.person,
      color: Color.fromRGBO(129, 70, 68, 1.0),
    );
    if (itype == 1) {
      ccc = Icon(
        Icons.person,
        color: Color.fromRGBO(129, 70, 68, 1.0),
      );
      sss = "登入";
    }
    if (itype == 2) {
      ccc = Icon(
        Icons.exit_to_app,
        color: Color.fromRGBO(129, 70, 68, 1.0),
      );
      sss = "登出";
    }
    if (itype == 99) {
      ccc = Icon(
        Icons.accessibility_new,
        color: Color.fromRGBO(129, 70, 68, 1.0),
      );
      sss = "test2";
    }
    if (itype == 98) {
      ccc = Icon(
        Icons.accessibility_new,
        color: Color.fromRGBO(129, 70, 68, 1.0),
      );
      sss = "設定";
    }
    _displayDialog3(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // 调整这个值以改变圆角的大小
              ),
              // title: Text('Dialog Title'),
              contentPadding: EdgeInsets.zero,
              content: myContain(
                m_heght: 500,
                m_weight: 250,
                m_boxDecoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    // image: AssetImage("assets/images/index_top1.jpg"),
                    image: AssetImage("assets/images/testlogin.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                m_child: Stack(children: [
                  Positioned(
                      top: 250,
                      left: 30,
                      child: myContain(
                        m_heght: 110,
                        m_weight: 220,
                        m_boxDecoration: new BoxDecoration(
                            //color: Colors.lightGreenAccent,
                            ),
                        m_child: Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: myText(
                                    m_text: 'username',
                                    m_color: Colors.white,
                                  ),
                                ),
                                myContain(
                                  m_weight: 250,
                                  m_child: myContain(
                                    m_heght: 30,
                                    m_boxDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                    ),
                                    m_child: TextField(
                                      controller: Control_Login_Username,
                                      style: TextStyle(
                                        color: Colors.white, // 設定文字顏色為紅色
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        // labelText: 'password',
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: myText(
                                    m_text: 'password',
                                    m_color: Colors.white,
                                  ),
                                ),
                                myContain(
                                  m_weight: 250,
                                  m_child: myContain(
                                    m_heght: 30,
                                    m_boxDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                    ),
                                    m_child: TextField(
                                      controller: Control_Login_PassWord,
                                      obscureText: true,
                                      style: TextStyle(
                                        color: Colors.white, // 設定文字顏色為紅色
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        // labelText: 'password',
                                        prefixIcon: Icon(
                                          Icons.password_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      )),
                  Positioned(
                    top: 380,
                    left: 30,
                    //TODO 登入
                    child: mypopButton(
                      m_onPressed: () {
                        ClearUserInfo();
                        GetNewLoginUser();
                        // _getNewUser();
                        // _loadStoredText();
                        Navigator.pop(context, "我登入");
                      },
                      // m_backcolor: Colors.white,
                      m_child: myText(
                        m_text: '登入',
                        m_color: Colors.white,
                      ),
                    ),
                  ),
                ]),
              ));
        },
      );
    }

    return myContain(
      m_weight: 47,
      m_heght: 47,
      m_boxDecoration: new BoxDecoration(
        border: Border.all(
          color: Color.fromRGBO(129, 70, 68, 1.0),
          width: 1.0, // 邊框寬度
        ),
        color: Color.fromRGBO(225, 230, 197, 1.0),
        borderRadius: BorderRadius.circular(2),
      ),
      m_child: InkWell(
        splashColor: Colors.green,
        onTap: () async {
          if (itype == 1) {
            //TODO 呼叫login 畫面
            _displayDialog3(context);
          }
          if (itype == 2) {
            //TODO 呼叫登出

            myConfirmAction? result =
                (await myDialog.Dialog_yesorno(context, '確定要登出?'))
                    as myConfirmAction?;
            if (result == myConfirmAction.ACCEPT) {
              mySharedPreferences.set_islogin(false);
              mySharedPreferences.set_UserName('');
              mySharedPreferences.set_FullName('');
              mySharedPreferences.set_test('');
              GetUserInfo();
            } else if (result == myConfirmAction.no) {}
          }
          if (itype == 99) {
            //TODO 呼叫testmenu 畫面
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => TryMenu()));
          }

          if (itype == 98) {
            //TODO 呼叫設定 畫面

            RouterUtil_test.mySetting(context);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ccc,
            myText(
              m_text: sss,
              m_color: Color.fromRGBO(129, 70, 68, 1.0),
              m_fontsize: 12,
            ), // <-- Text
          ],
        ),
      ),
    );
  }
//TODO State結尾
}

class tempIconButton2 extends StatelessWidget {
  final int myitype;
  final IconData? myicon;
  final Function my_onPressed;
  final String mytext;
  const tempIconButton2({
    required this.myitype,
    this.myicon,
    required this.my_onPressed,
    required this.mytext,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? my_Backcolor = MyColor.back_COLOR1;

    Widget tempIcon;
    tempIcon = myContain(
      m_weight: 50,
      m_heght: 50,
      m_child: Image(
        image: AssetImage("assets/images/myicon1_1.png"),
        fit: BoxFit.fill,
      ),
    );

    Widget ssss;
    ssss = Container(
      width: 90, // 指定按钮的宽度
      height: 50, // 指定按钮的高度
      decoration: BoxDecoration(
        color: Colors.blue, // 按钮的背景颜色
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25), // 右上角的圆角
          bottomRight: Radius.circular(25), // 右下角的圆角
        ),
      ),
      child: Center(
        child: Text(
          mytext,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
    Widget tempLabel;
    tempLabel = myContain(
      m_weight: 130,
      m_heght: 50,
      m_boxDecoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/myicon1_2.png"),
          fit: BoxFit.cover, // 图像填充容器，保持纵横比并覆盖整个容器
        ),
      ),
      m_child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            'aabbcc',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );

    if (myitype == 0) {}

    return Container(
        alignment: Alignment.centerLeft,
        child: InkWell(
            onTap: () {
              my_onPressed();
            },
            child: Row(
              children: [tempIcon, tempLabel],
            )));
  }
}

class tempIconButton extends StatelessWidget {
  final int myitype;
  final IconData? myicon;
  final Function my_onPressed;
  final String mytext;
  const tempIconButton({
    required this.myitype,
    this.myicon,
    required this.my_onPressed,
    required this.mytext,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? my_Backcolor = MyColor.back_COLOR1;

    Widget tempIcon;
    tempIcon = myContain(
      m_weight: 50,
      m_heght: 50,
      m_child: Image(
        image: AssetImage("assets/images/myicon1_1.png"),
        fit: BoxFit.fill,
      ),
    );

    Widget tempLabel;
    tempLabel = Container(
      width: 130, // 指定按钮的宽度
      height: 35, // 指定按钮的高度
      decoration: BoxDecoration(
        color: Colors.blue, // 按钮的背景颜色
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25), // 右上角的圆角
          bottomRight: Radius.circular(25), // 右下角的圆角
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black26,
              offset: Offset(3.0, 3.0), //陰影y軸偏移量
              blurRadius: 2, //陰影模糊程度
              spreadRadius: 0 //陰影擴散程度
              )
        ],
      ),
      child: Center(
        child: Text(
          mytext,
          style: TextStyle(
            fontFamily: 'NotoSansHK',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 2.0,
          ),
        ),
      ),
    );

    if (myitype == 0) {}

    return Container(
        alignment: Alignment.centerLeft,
        child: InkWell(
            onTap: () {
              my_onPressed();
            },
            child: Container(
                height: 50,
                width: 160.0,
                child: Stack(children: [
                  Positioned(left: 30, top: 7, child: tempLabel),
                  Positioned(left: 0, child: tempIcon),
                ]))));
  }
}

_displayDialog2(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: SimpleDialog(
            //title: Text('訊息'),
            children: [
              myContain(
                m_heght: 500,
                m_weight: 300,
                m_boxDecoration: new BoxDecoration(
                  color: Colors.amberAccent,
                  // borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    // image: AssetImage("assets/images/index_top1.jpg"),
                    image: AssetImage("assets/images/testlogin.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              )
            ],
          ),
        );
      }).then((value) => debugPrint(value));
}

testfff() {
  print('dddd');
}
