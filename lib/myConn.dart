import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

//參考
//https://codertw.com/%e7%a8%8b%e5%bc%8f%e8%aa%9e%e8%a8%80/647362/

// public static string m_url班表資訊 = "http://clockappservice.english4u.com.tw/api/funcPersonSet";
// public static string m_urlperson = "http://clockappservice.english4u.com.tw/api/funcPerson/admin";
// public static string m_url假別 = "http://clockappservice.english4u.com.tw/api/func假別/admin";
// public static string m_urlTest = "http://clockappservice.english4u.com.tw/api/AddProduct";
// public static string m_urlAdd請假單 = "http://clockappservice.english4u.com.tw/api/Add請假單";
// public static string m_urlAddFolder = "http://clockappservice.english4u.com.tw/api/AddFolder";
// public static string m_FileUp_JobLeave = "http://clockappservice.english4u.com.tw/api/FileUp_JobLeave";
// public static string m_get請假單BatchID = "http://clockappservice.english4u.com.tw/api/GetJovLeaveBatchID";
// /// <summary>
// /// para: /BatchID
// /// </summary>
// public static string m_url請假單Sch = "http://clockappservice.english4u.com.tw/api/SelectAmcJobLeave/all";
// public static string m_url請假單Detail = "http://clockappservice.english4u.com.tw/api/SelectAmcJobLeaveDetail";

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

//人員查詢 ,/admin 是查全部
String m_PersonSch = "http://clockappservice.english4u.com.tw/api/funcPerson";

//假別
String m_LeaveType =
    "http://clockappservice.english4u.com.tw/api/funcLeaveType/admin";
//假單明細
String m_LeaveDetail =
    "http://clockappservice.english4u.com.tw/api/SelectAmcJobLeaveDetail";

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
