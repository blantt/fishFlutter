import 'package:blantt_love_test/component/blanttButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'TryMenu.dart';
import 'package:blantt_love_test/utils/router_test.dart';
import 'package:blantt_love_test/component/blanttColor.dart';

class classhome extends StatelessWidget {
  const classhome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _homemenu2(context);
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

//TODO home
Widget _homemenu2(BuildContext context) {
  List spans = [];
  spans.add(TextSpan(text: 'dddd2'));

  // RichText(
  //   text:TextSpan(children: spans),
  //   maxLines:4,//最多显示四行
  //   overflow: TextOverflow.ellipsis,//显示省略号
  //   softWrap:true,
  // );
  RichText _test1;
  RichText _test2;
  _test1 = RichText(
    text: TextSpan(
      //outer span
      style: TextStyle(
          fontWeight: FontWeight.w500, color: Colors.black54, fontSize: 24),
      text: "Hallo Blantt !!",
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
      Container(
        width: double.infinity,
        height: 20,
        child: Image.asset(
          'assets/images/index_top2.jpg',
          fit: BoxFit.fill,
        ),
      ),
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
                    child: Align(
                        alignment: Alignment.topRight,
                        child: SizedBox(
                            width: 30,
                            height: 30,
                            child: Container(
                              decoration:
                                  new BoxDecoration(color: Colors.white),
                              child: InkWell(
                                child: Image(
                                  image: AssetImage("assets/images/login.png"),
                                  fit: BoxFit.fill,
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyTryMenu()));
                                },
                              ),
                            )))),
                SizedBox(
                  width: 10,
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
          //TODO testicon
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

        // Container(
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       mybutton(context, btnType.type1),
        //       SizedBox(
        //         width: 30,
        //       ),
        //       mybutton(context, btnType.type2)
        //     ],
        //   ),
        // ),
        // Container(
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       mybutton(context, btnType.type3),
        //       SizedBox(
        //         width: 30,
        //       ),
        //       mybutton(context, btnType.type4)
        //     ],
        //   ),
        // )
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
