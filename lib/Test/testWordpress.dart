import 'package:flutter/material.dart';
import 'package:blantt_love_test/component/blanttButton.dart';
import 'package:blantt_love_test/utils/dt_router.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

class classWordpress extends StatefulWidget {
  classWordpress({Key? key}) : super(key: key);
  @override
  testWordpress createState() => testWordpress();
}

class testWordpress extends State<classWordpress> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('wordpress')),
      body: Center(
          child: Column(children: [
        myContain(
          m_child: myButton(
            m_child: myText(
              m_text: 'wp文章列表',
            ),
            m_onPressed: () {
              callsch();
            },
          ),
        ),
        myContain(
          m_child: myButton(
            m_child: myText(
              m_text: '查單篇文章',
            ),
            m_onPressed: () {
              getwpapi2();
            },
          ),
        ),
        myContain(
          m_child: myButton(
            m_child: myText(
              m_text: 'api查詢',
            ),
            m_onPressed: () {
              getwpapi();
            },
          ),
        ),
        myContain(
          m_child: myButton(
            m_child: myText(
              m_text: 'api刪除',
            ),
            m_onPressed: () {
              apiDel();
            },
          ),
        ),
        myContain(
          m_child: myButton(
            m_child: myText(
              m_text: 'apiedit',
            ),
            m_onPressed: () {
              apiEdit();
            },
          ),
        ),
        myContain(
          m_child: myButton(
            m_child: myText(
              m_text: 'testcust',
            ),
            m_onPressed: () {
              testcust();
            },
          ),
        ),
      ])),
    );
  }

  void callsch() {
    RouterUtil_test.callpage(context, en_runterType.wp_sch);
  }

  Future<String> apiEdit() async {
    String url = 'http://10.0.2.2:80/godlove/wp-json/myplugin/v1/edit';
    final response = await Dio().post(url);
    String sss = "";

    if (response.statusCode == HttpStatus.ok) {
      print('edit get');
    } else {
      print('edit not ok');
    }
    //print('aaa2333');
    setState(() {});
    print(response.data);
    return "";
  }

  Future<String> testcust() async {
    String url = 'http://clockappservice.english4u.com.tw/api/SelectERPCust';
    var data = {
      'CustID': 'B101990008', // 文章的 ID
      'BigCustID': '',
    };

    // 發送 POST 請求
    var response = await Dio().post(
      url,
      data: data,
    );
    if (response.statusCode == HttpStatus.ok) {
      print('edit get');
    } else {
      print('edit not ok');
    }
    //print('aaa2333');
    setState(() {});
    print(response.data);
    return "";
  }

  Future<String> apiDel() async {
    String url = 'http://10.0.2.2:80/godlove/wp-json/myplugin/v1/del/16';
    final response = await Dio().post(url);
    String sss = "";

    if (response.statusCode == HttpStatus.ok) {
      print('get');
    } else {
      print('not ok');
    }
    print('aaa2222');
    setState(() {});
    print(response.data);
    return "";
  }

  Future<String> getwpapi() async {
    //String url = 'http://127.0.0.1:8000/godlove/wp-json/wp/v2/note/';
    String url = 'http://10.0.2.2:80/godlove/wp-json/wp/v2/note';
    final response = await Dio().get(url);
    String sss = "";

    if (response.statusCode == HttpStatus.ok) {
      print('get');
      List<dynamic> posts = response.data;
      for (var post in posts) {
        // 提取文章的 ID、標題和內容
        int id = post['id'];
        String title = post['title']['rendered'];
        String content = post['content']['rendered'];

        // 在這裡使用 ID、標題和內容進行你想要的操作
        print('Post ID: $id');
        print('Post Title: $title');
        print('Post Content: $content');
      }
    } else {
      print('not ok');
    }
    print('aaa2222');
    setState(() {});
    return "";
  }

  Future<String> getwpapi2() async {
    //String url = 'http://127.0.0.1:8000/godlove/wp-json/wp/v2/note/';
    String url = 'http://10.0.2.2:80/godlove/wp-json/wp/v2/note/7';
    final response = await Dio().get(url);
    String sss = "";

    if (response.statusCode == HttpStatus.ok) {
      var post = response.data;
      int id = post['id'];
      String title = post['title']['rendered'];
      String content = post['content']['rendered'];

      // 在這裡使用 ID、標題和內容進行你想要的操作
      print('Post ID: $id');
      print('Post Title: $title');
      print('Post Content: $content');
    } else {
      print('not ok');
    }
    print('aaa2222');
    setState(() {});
    return "";
  }
}
