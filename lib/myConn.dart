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
// public static string m_url請假單Sch = "http://clockappservice.english4u.com.tw/api/SelectAmcJobLeave";
// public static string m_url請假單Detail = "http://clockappservice.english4u.com.tw/api/SelectAmcJobLeaveDetail";

//假別
String m_url_ClocjClass =
    "http://clockappservice.english4u.com.tw/api/func假別/admin";

@JsonSerializable()
class User {
  User(this.name, this.assetName);

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
        'no',
        style: TextStyle(color: Colors.deepOrange),
      ),
      onPressed: () {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => barview()));
      },
    ),
  ])));
}

List<Nametry> nametryFromJson(String str) =>
    List<Nametry>.from(json.decode(str).map((x) => Nametry.fromJson(x)));

String nametryToJson(List<Nametry> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
