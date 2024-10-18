import 'package:blantt_love_test/page/dt_home.dart';
import 'package:flutter/material.dart';
import 'package:blantt_love_test/testView.dart';
import 'package:blantt_love_test/page/JobLeaveSch.dart';
import 'package:blantt_love_test/utils/dt_router.dart';
import 'package:blantt_love_test/myConn.dart';
import 'package:blantt_love_test/dt_Dialog.dart';
import 'package:blantt_love_test/selectTime.dart';
import 'package:blantt_love_test/selectDate.dart';
import 'package:blantt_love_test/textForm.dart';
import 'package:blantt_love_test/testListSch.dart';
import 'package:blantt_love_test/page/JobLeave.dart';
import 'package:blantt_love_test/pop/popPerson.dart';
import 'package:blantt_love_test/testView2.dart';
import 'package:blantt_love_test/pop/pop_LeaveType.dart';
import 'package:blantt_love_test/pop/popTime.dart';
import 'package:blantt_love_test/Test/TestForm2.dart';
import 'package:blantt_love_test/Test/TestForm3.dart';
import 'package:blantt_love_test/Test/TestForm4.dart';
import 'package:blantt_love_test/main.dart';
import 'package:blantt_love_test/dt_Setting.dart';
import 'package:blantt_love_test/Test/testWordpress.dart';
import 'package:blantt_love_test/WP/wp_page_sch.dart';

enum en_runterType { jobLeaveSch, jobLeave, testWordpress, wp_sch }

class RouterUtil_test {
  static void callpage(BuildContext context, en_runterType stype) {
    if (stype == en_runterType.wp_sch) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => class_wpSrc(value: "104259")),
      );
    }

    if (stype == en_runterType.testWordpress) {
      //wordpress 測試入口
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => classWordpress()),
      );
    }

    if (stype == en_runterType.jobLeaveSch) {
      //請假單查詢
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ListViewSch()),
      );
    }
  }

  static mySetting(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MySetting()),
    );
  }

  static myhome(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => classhome()),
      // MaterialPageRoute(builder: (context) => MyApp2()),
      //MaterialPageRoute(builder: (context) => testView2()),
    );
  }

  static totestform(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => testform()),
    );
  }

  static toPersonSch(BuildContext context, String _value) {
    //人員POP選單
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => newPersonState(value: _value)),
      //context, page3, arguments: PageSend(BatchID)
    ).then((value) => {});
  }

  static toJTestTime(BuildContext context) {
    // Navigator.push(
    //   context,
    //
    //   MaterialPageRoute(builder: (context) => doorSelectTime('', '')),
    //
    // );
  }

  static toJobleaveForm(BuildContext context, String _BatchID) {
    //假單表單edit
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Jobleave(_BatchID)),
      //context, page3, arguments: PageSend(BatchID)
    );
  }

  static toListViewSample1(BuildContext context) {
    // listview簳例1
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage_list()),
    );
  }

  static toSelectDateTest(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => selectDate()),
    );
  }

  static toSelectTimeTest(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => classSelectTime()),
    );
  }

  static toDialogTest(BuildContext context) {
    //彈跳視窗測試
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => classDialog()),
    );
  }

  static toLoginPage(BuildContext context) {
    //login 界面
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => testview()),
    );
  }

  static toJobLeaveList(BuildContext context) {
    //請假單查詢畫面
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListViewSch()),
    );
  }

  static toConnTest(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => menu_conn()),
    );
  }

  static toLeaveType(BuildContext context) {
    //pop假別查詢視窗
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => doorLeaveType()),
      //MaterialPageRoute(builder: (context) => testView2()),
    );
  }

  static toTestForm2(BuildContext context) {
    //測試專用
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => doorForm2()),
    );
  }

  static toTestForm3(BuildContext context) {
    //測試專用
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TestFomr3()),
    );
  }

  static toTestForm4(BuildContext context) {
    //測試專用
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyAppLoad()),
      //MaterialPageRoute(builder: (context) => testView2()),
    );
  }
}
