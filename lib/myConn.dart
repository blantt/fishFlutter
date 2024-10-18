import 'package:blantt_love_test/Model/modalBasic.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

//---人員基本檔
String m_url_PersonBasic =
    "http://clockappservice.english4u.com.tw/api/funcPersonSet";

//--存圖檔
String m_url_SaveUploadFile2 =
    "http://clockappservice.english4u.com.tw/api/UploadFile2";

//---表頭表身一起存
String m_url_SaveJovLeaveAll =
    "http://clockappservice.english4u.com.tw/api/Add請假單All";

//---存請假單時間區段
String m_url_SaveJovLeaveDetail =
    "http://clockappservice.english4u.com.tw/api/Add請假單明細";

//--請假單存檔
String m_url_SaveJovLeave =
    "http://clockappservice.english4u.com.tw/api/Add請假單";

//--請假單修改存檔
String m_url_UpdateJovLeave =
    "http://clockappservice.english4u.com.tw/api/Update請假單";

//假別
String m_url_ClocjClass =
    "http://clockappservice.english4u.com.tw/api/func假別/admin";
//請假單查詢 ,/all 是查全部
String m_url_LeaveSch =
    "http://clockappservice.english4u.com.tw/api/SelectAmcJobLeave";
String SelectAmcJobLeave_appEasy =
    "http://clockappservice.english4u.com.tw/api/SelectAmcJobLeave_appEasy";

String SelectAmcJobLeave_appEasyTest =
    "http://clockappservice.english4u.com.tw/api/SelectAmcJobLeave_appEasyTest";

//人員查詢 ,/admin 是查全部
String m_PersonSch = "http://clockappservice.english4u.com.tw/api/funcPerson";

//假別
String m_LeaveType =
    "http://clockappservice.english4u.com.tw/api/funcLeaveType/admin";
//假單明細
String m_LeaveDetail =
    "http://clockappservice.english4u.com.tw/api/SelectAmcJobLeaveDetail";

String m_LeaveDetailTest =
    "http://clockappservice.english4u.com.tw/api/SelectAmcJobLeaveDetailTest";

//取得假單圖檔名稱 ,回傳 image1/image2..
String m_GetAmcJobLeaveImage =
    "http://clockappservice.english4u.com.tw/api/GetAmcJobLeaveImage";

String m_GetAmcJobLeaveImageTest =
    "http://clockappservice.english4u.com.tw/api/GetAmcJobLeaveImageTest";

String GetGetAmcJobLeaveImage() {
  if (m_isTest == true) {
    return m_GetAmcJobLeaveImageTest;
  } else {
    return m_GetAmcJobLeaveImage;
  }
}

String GetLeaveDetail() {
  if (m_isTest == true) {
    return m_LeaveDetailTest;
  } else {
    return m_LeaveDetail;
  }
}

String GetSelectAmcJobLeave_appEasy() {
  if (m_isTest == true) {
    return SelectAmcJobLeave_appEasyTest;
  } else {
    return SelectAmcJobLeave_appEasy;
  }
}

enum CostType {
  /// 按平方
  BySquare,

  /// 按長度
  ByLength,

  /// 按重量
  ByWeight,

  /// 按數量
  ByNum,
}

@JsonSerializable()
class User {
  User(this.name, this.assetName);

  //CostType.ByLength

  String name;
  String assetName;
}

class User2 {
  final String name1;
  final String name2;

  User2(this.name1, this.name2);

  User2.fromJson(Map<String, dynamic> json)
      : name1 = json['name1'],
        name2 = json['name2'];

  Map<String, dynamic> toJson() => {
        'name1': name1,
        'name2': name2,
      };
}

class menu_conn extends StatelessWidget {
  const menu_conn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _menu_conn(context);
  }
}

Widget _menu_conn(BuildContext context) {
  return Scaffold(
      body: Center(
          child: Column(children: [
    Container(
      margin: EdgeInsets.fromLTRB(0, 65, 0, 0),
    ),
    OutlinedButton(
      child: Text(
        'TEST',
        style: TextStyle(color: Colors.deepOrange),
      ),
      onPressed: () {
        getHttp();
      },
    ),
    OutlinedButton(
      child: Text(
        'test2',
        style: TextStyle(color: Colors.deepOrange),
      ),
      onPressed: () {
        getHttp2();
      },
    ),
  ])));
}

List<Nametry> nametryFromJson(String str) =>
    List<Nametry>.from(json.decode(str).map((x) => Nametry.fromJson(x)));

String nametryToJson(List<Nametry> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Modal_LeaveSch {
  Modal_LeaveSch({
    required this.BatchID,
  });

  String BatchID;

  factory Modal_LeaveSch.fromJson(Map<String, dynamic> json) => Modal_LeaveSch(
        BatchID: json["BatchID"],
      );

  Map<String, dynamic> toJson() => {
        "BatchID": BatchID,
        // "UserName": UserName,
        // "UserNameN": UserNameN,
        // "LeaveTypeN": LeaveTypeN,
        // "DeptID": DeptID,
        // "LeaveType": LeaveType,
        // "ClassType": ClassType,
        // "Reason": Reason,
        //  "ReturnReason": ReturnReason,
      };
}

//網頁幫忙產生model  https://app.quicktype.io/
class Nametry {
  Nametry({
    required this.name1,
    required this.name2,
  });

  String name1;
  String name2;

  factory Nametry.fromJson(Map<String, dynamic> json) => Nametry(
        name1: json["name1"],
        name2: json["name2"],
      );

  Map<String, dynamic> toJson() => {
        "name1": name1,
        "name2": name2,
      };
}

class testname {
  final String name1;
  final String name2;
  const testname({required this.name1, required this.name2});
}

void getHttp2() async {
  Response response = await Dio().get(m_url_LeaveSch);
  String sss = "";
  try {
    Response response = await Dio().get(m_url_LeaveSch);
    String sss = "";
    if (response.statusCode == HttpStatus.ok) {
      // var teststr = '{"name1":"0","name2":"特休"}';
      // var data2 = jsonDecode(teststr);
      // var aa = User2.fromJson(data2);
      // print(aa.name2);

      // String ttt = '[{"name1":"0","name2":"特休"},{"name1":"1","name2":"特休2"}]';
      List<Modal_LeaveSch> list = (response.data as List<dynamic>)
          .map((e) => Modal_LeaveSch.fromJson((e as Map<String, dynamic>)))
          .toList();
      print(list[0].BatchID);
    }
  } catch (e) {
    print(e);
  }
}

void getHttp() async {
  try {
    Response response = await Dio().get(m_url_ClocjClass);
    String sss = "";
    if (response.statusCode == HttpStatus.ok) {
      //print('return:' + response.data.toString());

      //----如果是單筆的json,可以直接醬取資料!
      //var teststr = '{"name1":"0","name2":"特休"}';
      // var data = jsonDecode(teststr);
      // var result = data['name2'];
      // print(result);

      //----如果是單筆的json,用class接
      var teststr = '{"name1":"0","name2":"特休"}';
      var data2 = jsonDecode(teststr);
      var aa = User2.fromJson(data2);
      print(aa.name2);

      // print(data2[1]["name2"]);

      //---取得多組json成功版!
      String ttt = '[{"name1":"0","name2":"特休"},{"name1":"1","name2":"特休2"}]';
      List<Nametry> list = (response.data as List<dynamic>)
          .map((e) => Nametry.fromJson((e as Map<String, dynamic>)))
          .toList();
      print(list[1].name2);
    }
  } catch (e) {
    print(e);
  }
}

void getHttpFromData() async {
  // Response response = await Dio().get("http://liuwangshu.com");
  // FormData formData = new FormData.from({
  //   "name": "liuwangshu",
  //   "age": 18,
  // });
  // response = await dio.post("/info", data: formData);
}
