import 'package:blantt_love_test/component/blanttButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'TryMenu.dart';
import 'package:blantt_love_test/utils/router_test.dart';
import 'package:blantt_love_test/component/blanttColor.dart';
import 'package:blantt_love_test/Model/modalBasic.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:blantt_love_test/Model/modalBasic.dart';
import 'package:blantt_love_test/myConn.dart';

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

//TODO 取得人員資料
void GetUserInfo() async {
  // classUserInfo mySharedPreferences = classUserInfo();
  String? UserName = await mySharedPreferences.get_UserName();
  String? FullName = await mySharedPreferences.get_FullName();
  bool? islogin = await mySharedPreferences.get_islogin();
  // 現在可以使用 sss 變數了
  if (UserName != null) {
    Control_Username.text = UserName;
  } else {
    // 當 'UserName' 鍵不存在或者其值為 null 時的處理
  }

  if (FullName != null) {
    Control_Fullname.text = "您好:" + FullName;
  } else {
    Control_Fullname.text = "您好:訪客";
  }
}

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
      mySharedPreferences.set_islogin(true);

      _loadStoredText();
      print('測試讀取人員' + row.UserName);
    }

    return "";
  }

  void _getNewUser() async {
    mySharedPreferences.set_FullName("小犬中3");
    mySharedPreferences.set_islogin(true);
  }

  void _loadStoredText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      GetUserInfo();
      //GetNewLoginUser();
      print('test com in ');
    });
  }

  @override
  void initState() {
    _loadStoredText();
  }

  @override
  Widget build(BuildContext context) {
    //TODO 目前想把 _homemenu2 內容都移到State裡,這樣登入時去更新畫面
    return _homemenu2(context);
  }

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

    return new Scaffold(
      body: new Column(children: [
        // Container(
        //   width: double.infinity,
        //   height: 20,
        //   child: Image.asset(
        //     'assets/images/index_top2.jpg',
        //     fit: BoxFit.fill,
        //   ),
        // ),
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
              Container(
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
                  homeiconButton(context, 2),
                  SizedBox(
                    width: 2,
                  ),
                  homeiconButton(context, 1),
                  SizedBox(
                    width: 2,
                  ),
                  homeiconButton(context, 99),
                  SizedBox(
                    width: 5,
                  )
                ]),
              ),
            ],
          ),
        ),
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
                    RouterUtil_test.toJobLeaveList(context);
                  }),
              //tempicontest(),
              SizedBox(
                width: 30,
              ),
              tempIconButton(myitype: 0, mytext: '加班單', my_onPressed: () {}),
            ],
          )),
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            //TODO testicon
            children: [
              tempIconButton(myitype: 0, mytext: '補休單', my_onPressed: () {}),
              //tempicontest(),
              SizedBox(
                width: 30,
              ),
              tempIconButton(myitype: 0, mytext: '公出單', my_onPressed: () {}),
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

    _displayDialog3(BuildContext context) {
      UnderlineInputBorder tempenabledBorder;
      tempenabledBorder = UnderlineInputBorder(
        //borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(color: Colors.red, width: 3),
        borderRadius: BorderRadius.zero, // 边框圆角半径为0
      );

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
                    child: InkWell(
                      child: myContain(
                          m_weight: 220,
                          m_child: Align(
                            alignment: Alignment.topCenter,
                            child: myContain(
                                m_heght: 30,
                                m_weight: 100,
                                m_boxDecoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20.0),
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(3.0, 3.0), //陰影y軸偏移量
                                        blurRadius: 2, //陰影模糊程度
                                        spreadRadius: 0 //陰影擴散程度
                                        )
                                  ],
                                ),
                                m_child: Align(
                                  alignment: Alignment.topCenter,
                                  child: myText(
                                    m_text: '登入',
                                    m_color: Colors.white,
                                  ),
                                )),
                          )),
                      onTap: () {
                        print('我登入');
                        GetNewLoginUser();
                        // _getNewUser();
                        // _loadStoredText();
                        Navigator.pop(context, "我登入");
                      },
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
        onTap: () {
          if (itype == 1) {
            //TODO 呼叫login 畫面
            _displayDialog3(context);
          }
          if (itype == 99) {
            //TODO 呼叫testmenu 畫面
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => TryMenu()));
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
