import 'package:flutter/material.dart';
import 'package:blantt_love_test/testView.dart';
import 'package:blantt_love_test/ListView.dart';
import 'package:blantt_love_test/dt_rounter.dart';
import 'package:blantt_love_test/myConn.dart';
import 'package:blantt_love_test/dt_Dialog.dart';
import 'package:blantt_love_test/selectTime.dart';
import 'package:blantt_love_test/selectDate.dart';
import 'package:blantt_love_test/textForm.dart';
import 'package:blantt_love_test/testListSch.dart';
import 'package:blantt_love_test/JobLeave.dart';
import 'package:blantt_love_test/ListPerson.dart';
import 'package:blantt_love_test/testView2.dart';
import 'package:blantt_love_test/page/pop/pop_LeaveType.dart';
import 'package:blantt_love_test/testTime.dart';
import 'package:blantt_love_test/TestFrom2.dart';

class RouterUtil_test {
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

  static totestform(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => testform()),
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
      MaterialPageRoute(builder: (context) => MyListView()),
    );
  }

  static toRounterTest(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyRunter()),
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
      //MaterialPageRoute(builder: (context) => testView2()),
    );
  }
}
