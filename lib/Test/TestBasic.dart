import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:lovetest2/Test/TestForm3.dart';
import 'package:lovetest2/component/blanttColor.dart';
import 'package:lovetest2/Model/model_wp.dart';
import '../component/blanttButton.dart';
import 'package:flutter/material.dart';
import '../component/blanttList.dart';
import '../myBasic.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lovetest2/Model/modalBasic.dart';
import 'package:lovetest2/selectDate.dart';


class TestBasic extends StatefulWidget {
  const TestBasic({Key? key}) : super(key: key); 
  @override 
  State<TestBasic> createState() => _TestBasicState(); 
}
class _TestBasicState extends State<TestBasic> {
  @override
  void initState() {
    super.initState();
  }
 
  FishListView mylistview=FishListView(
  funcCallData: fetchDataFromAPI, // 這是你的資料獲取函數
  myitemBuilder: (context, row) {
     String title = row['title']['rendered'];
    return Card(
      child: ListTile(
        // title: Text(row['title']),
        
        title: Text(title),
      ),
    );
  },
);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('基本頁面3'),
      ),
      //body: Text('testform') ,
      body: mylistview,
    );
  }
}

Future<List<dynamic>> fetchDataFromAPI() async {
  String url = m_url_wpBasic_old + '/wp-json/wp/v2/note';
   final response = await Dio().get(url);
    String sss = "";
    if (response.statusCode == HttpStatus.ok) {
       print('getdata');
       return response.data is List ? response.data : [];
    }
    else {
      throw Exception('Failed to load data');

    }
 
}