import 'package:blantt_love_test/component/blanttButton.dart';
import 'package:blantt_love_test/page/JobLeave.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:blantt_love_test/myConn.dart';
import 'package:blantt_love_test/Model/model_wp.dart';
import 'package:blantt_love_test/routesPage.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:blantt_love_test/utils/dt_router.dart';
import 'package:blantt_love_test/WP/wp_page_edit.dart';
import '../component/blanttList.dart';
//參收參33數參考 https://fightwennote.blogspot.com/2020/04/flutter-widget.html?m=0
//https://github.com/yogitakumar/navigation
void main() {
  runApp(class_wpSrc(
    value: '',
  ));
}

bool isGetUser = false;
//list_Modal_PsersonSch_new 是用來判斷是否己經有抓過資料庫,給list值了,
//如果用list 過濾資料時,FutureBuilder ,會再啓動一次,這是就判斷不會再回抓資料庫了
//這個做法是綜合許多後自己發明的,有沒有更好的寫法,再觀查一下
List<Modal_wp> list_Modal_wp = [Modal_wp(id: 0, title: '', content: '')];

class class_wpSrc extends StatefulWidget {
  //如要用Route ,能正確的用pop返迴值到上一面,需舕叫這個 StatefulWidget ,不能用 StatelessWidget
  //真正原理為何,其實不太懂,有機會要去再深入了解一下, 但應該和 BuildContext 是有關的

  late final String value;
  class_wpSrc({required this.value});

  @override
  _wpSrcState createState() => _wpSrcState();
}

final ItemScrollController itemScrollController = ItemScrollController();

class _wpSrcState extends State<class_wpSrc> {


 // final GlobalKey<FishListViewState> _listViewKey2 = GlobalKey<FishListViewState>();
  // @override
  void initState() {
    //這個states應該只會進來一次,所以在這裡做初始值
    print('schinit2');
    //_listViewKey2.currentState?.reloadData();
    list_Modal_wp.clear();
    GetDatePersonSch();
    super.initState();
  }
   
  String getvalue = "";
  @override
  Widget build(BuildContext context) {
    getvalue = widget.value;
    return Scaffold(
      appBar: AppBar(
        title: myButton(
          m_child: Text('新增3'),
          m_onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => class_wpedit(
                        value: '',
                        pagetype: 'sch',
                      )),
            );
          },
        ),
        backgroundColor: Color.fromRGBO(56, 163, 210, 1.0),
      ),
      //TODO now body
      body: mylistview5,
      //body: mylistview,
      //--舊版
      // body: isGetUser
      //     ? _buildList(context)
      //     : !isGetUser
      //         ? CircularProgressIndicator() // Show a loading indicator
      //         : Container(),
    );
  }

  Future<String> GetDatePersonSch() async {
    if (list_Modal_wp.length > 0) {
      //代表有取過值了,過濾時,不要再去回調資料api了
      return "已取值";
    }
//getapi url
    String url = m_url_wpBasic  + '/wp-json/wp/v2/note';

    final response = await Dio().get(url);
    String sss = "";
    if (response.statusCode == HttpStatus.ok) {
      //List<dynamic> posts = response.data;
      List<dynamic> posts = response.data is List ? response.data : [];
      for (var post in posts) {
        // 提取文章的 ID、標題和內容
        int id = post['id'];
        String title = post['title']['rendered'];
        String content = post['content']['rendered'];

        Modal_wp temprow = Modal_wp(id: id, title: title, content: content);

        list_Modal_wp.add(temprow);
      }
    } else {}
    setState(() {
      isGetUser = true;
    });
    return "";
  }


  Widget _buildList(BuildContext context) {
      //TODO _buildList(old)
    var itemCount = list_Modal_wp.length;
    if (itemCount == 0) {
      itemCount = 1;
    }

    return ScrollablePositionedList.builder(
        itemCount: list_Modal_wp.length,
        // itemScrollController: itemScrollController,
        itemBuilder: (context, index) {
          final user = list_Modal_wp[index];
          var row = list_Modal_wp[index];
          //TODO listview迴圈時
          return Card(
            child: ListTile(
                title: Container(
              child: Row(
                children: [
                  myButton(
                    m_child: myText(
                      m_text: '查詢',
                      m_color: Color.fromARGB(255, 23, 100, 232),
                    ),
                    m_onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => class_wpedit(
                                  value: row.id.toString(),
                                  pagetype: 'sch',
                                )),
                      );
                    },
                  ),
                  myButton(
                    m_child: myText(
                      m_text: 'edit',
                      m_color: Color.fromARGB(255, 23, 100, 232),
                    ),
                    m_onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => class_wpedit(
                                  value: row.id.toString(),
                                  pagetype: 'edit',
                                )),
                      );
                    },
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(_subStr(row.title)),
                ],
              ),
            )),
          );
        });
  }

  //-----------------

  //----------------

  Widget _body(BuildContext context) {
    return FutureBuilder<String>(
      future: GetDatePersonSch(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // 请求已结束
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            // 请求失败，显示错误
            return Text("Error: ${snapshot.error}");
            //  return CircularProgressIndicator();
          } else {
            // 请求成功，显示数据

            return _buildList(context);
          }
        } else {
          // 请求未结束，显示loading
          //  itemScrollController.jumpTo(index: 50);

          return new Center(child: CircularProgressIndicator());
          // return CircularProgressIndicator();
        }
      },
    );
  }
}

FishListView mylistview5=FishListView(
  //TODO fishlistview
  funcCallData: fetchDataFromAPI, // 這是你的資料獲取函數
  myitemBuilder: (context, row) {
     int id = row['id'];
     String content = row['content']['rendered'];
     String title = row['title']['rendered'];
    return Card(
            child: ListTile(
                title: Container(
              child: Row(
                children: [
                  myButton(
                    m_child: myText(
                      m_text: '查詢2',
                      m_color: Color.fromARGB(255, 23, 100, 232),
                    ),
                    m_onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => class_wpedit(
                                  value: id.toString(),
                                  pagetype: 'sch',
                                )),
                      );
                    },
                  ),
                  myButton(
                    m_child: myText(
                      m_text: 'edit',
                      m_color: Color.fromARGB(255, 23, 100, 232),
                    ),
                    m_onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => class_wpedit(
                                  value: row.id.toString(),
                                  pagetype: 'edit',
                                )),
                      );
                    },
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("a"+_subStr(title)),
                 
                ],
              ),
            )),
          );
  },
);

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

 
  String _subStr(String text) {
    final int maxChars = 12;

    String displayText;
    if (text.length > maxChars) {
      displayText = text.substring(0, maxChars) + '..';
    } else {
      displayText = text;
    }
    return displayText;
  }
