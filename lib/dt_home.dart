import 'package:flutter/material.dart';
import 'dart:io';

class classhome extends StatelessWidget {
  const classhome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _menu(context);
  }
}

Widget _menu(BuildContext context) {
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

  return Column(children: <Widget>[
    Container(
      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
      width: double.infinity,
      height: 280,
      decoration: new BoxDecoration(color: Colors.white),
      child: Card(
        child: Image.asset(
          'assets/images/indexback.jpg',
          fit: BoxFit.fill,
        ),
        elevation: 8,
        shadowColor: Colors.green,
        margin: EdgeInsets.all(20),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white)),
      ),
    ),
    Container(
      padding: EdgeInsets.fromLTRB(15, 33, 0, 0),
      width: double.infinity,
      height: 130,
      alignment: Alignment.topLeft,
      decoration: new BoxDecoration(color: Colors.white),
      child: Column(children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: _test1,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: _test2,
        ),
      ]),
    ),
    Expanded(
      child: Container(
        width: double.infinity,
        decoration: new BoxDecoration(color: Colors.lightGreenAccent),
      ),
    ),
  ]);
}
