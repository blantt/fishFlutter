import 'package:flutter/material.dart';
import 'dart:io';
import 'TryMenu.dart';
import 'package:blantt_love_test/testButton.dart';
import 'ListView.dart';

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
              image: AssetImage("assets/images/index_top1.jpg"),
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
            children: [
              mybutton(context, btnType.type1),
              SizedBox(
                width: 30,
              ),
              mybutton(context, btnType.type2)
            ],
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              mybutton(context, btnType.type3),
              SizedBox(
                width: 30,
              ),
              mybutton(context, btnType.type4)
            ],
          ),
        )
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
          Navigator.push(
              _context, MaterialPageRoute(builder: (context) => MyListView()));
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
