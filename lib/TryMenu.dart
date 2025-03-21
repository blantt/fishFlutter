import 'package:lovetest2/Test/TestForm3.dart';
import 'package:flutter/material.dart';
import 'package:lovetest2/utils/dt_router.dart';

void main() {
  runApp(MyTryMenu());
}

class MyTryMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ccc',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: TryMenu());
  }
}

class TryMenu extends StatefulWidget {
  TryMenu({Key? key}) : super(key: key);
  @override
  _PageState2 createState() => _PageState2();
}

class _PageState2 extends State<TryMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //leading: Icon(Icons.arrow_back),
          backgroundColor: Color.fromRGBO(56, 163, 210, 1.0),
          title: Text(
            'testmenu',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                // color: Colors.black54,
                fontSize: 18),
          ),
        ),
        // body: buildLivtView_Kind(context));
        //  body: _body(context));
        body: SingleChildScrollView(
          child: Center(
              child: Column(children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 65, 0, 0),
            ),
            OutlinedButton(
              child: Text(
                'wordpress',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                RouterUtil_test.callpage(context, en_runterType.linkWrodpressTest);
              },
            ),
            OutlinedButton(
              child: Text(
                'testtime',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                RouterUtil_test.toJTestTime(context);
              },
            ),
            OutlinedButton(
              child: Text(
                'Login',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                RouterUtil_test.toLoginPage(context);
              },
            ),
            OutlinedButton(
              child: Text(
                '請假單查詢',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                RouterUtil_test.toJobLeaveList(context);
              },
            ),
            OutlinedButton(
              child: Text(
                '連線測試',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                RouterUtil_test.toConnTest(context);
              },
            ),
            OutlinedButton(
              child: Text(
                '彈跳視窗',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                RouterUtil_test.toDialogTest(context);
              },
            ),
            OutlinedButton(
              child: Text(
                'selectTime',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                RouterUtil_test.toSelectTimeTest(context);
              },
            ),
            OutlinedButton(
              child: Text(
                'selectDate',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                RouterUtil_test.toSelectDateTest(context);
              },
            ),
            OutlinedButton(
              child: Text(
                '測試表單',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                RouterUtil_test.totestform(context);
              },
            ),
             OutlinedButton(
              child: Text(
                '測試摪單2',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                RouterUtil_test.toTestForm2(context);
              },
            ),
             OutlinedButton(
              child: Text(
                '測試表BasicForm',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                RouterUtil_test.totestBasic(context);
              },
            ),
            OutlinedButton(
              child: Text(
                'listview簳例1',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                RouterUtil_test.toListViewSample1(context);
              },
            ),
            OutlinedButton(
              child: Text(
                '測試listview分頁',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                RouterUtil_test.toTestForm4(context);
              },
            ),
            OutlinedButton(
              child: Text(
                '測試彈跳視窗2',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TestFomr3()));
                // RouterUtil_test.toTestForm3(context);
              },
            ),
           
            OutlinedButton(
              child: Text(
                'test 人員選單',
                style: TextStyle(color: Colors.deepOrange),
              ),
              onPressed: () {
                RouterUtil_test.toLeaveType(context);
              },
            ),
          ])),
        ));
  }
}
