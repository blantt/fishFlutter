import 'package:lovetest2/Test/TestForm3.dart';
import 'package:lovetest2/component/blanttButton.dart';
import 'package:flutter/material.dart';
import 'package:lovetest2/utils/dt_router.dart';
import 'package:lovetest2/Model/modalBasic.dart';
import 'main.dart';

void main() {
  runApp(MySetting());
}

classUserInfo mySharedPreferences = classUserInfo();
TextEditingController Control_Username = new TextEditingController();
TextEditingController Control_Fullname = new TextEditingController();

class MySetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ccc',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: sttingMenu());
  }
}

class sttingMenu extends StatefulWidget {
  sttingMenu({Key? key}) : super(key: key);
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<sttingMenu> {
  classUserInfo mySharedPreferences = classUserInfo();

  @override
  void initState() {
    // GetUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //leading: Icon(Icons.arrow_back),
          backgroundColor: Color.fromRGBO(56, 163, 210, 1.0),
          title: Text(
            '設定',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                // color: Colors.black54,
                fontSize: 18),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 65, 0, 0),
            ),
            myText(
              m_text: '人員:' + myUserBasic.FullName,
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
          ])),
        ));
  }

  void GetUserInfo() async {
    String? UserName = await mySharedPreferences.get_UserName();
    String? FullName = await mySharedPreferences.get_FullName();

    Control_Username.text = UserName!;
    Control_Fullname.text = FullName!;

    print('取人員基本');
  }
}
