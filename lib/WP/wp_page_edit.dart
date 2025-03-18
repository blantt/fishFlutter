import 'package:lovetest2/component/blanttButton.dart';
import 'package:lovetest2/page/JobLeave.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lovetest2/myConn.dart';
import 'package:lovetest2/Model/model_wp.dart';
import 'package:lovetest2/routesPage.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:lovetest2/dt_Dialog.dart';
import 'package:lovetest2/utils/dt_router.dart';
import 'package:flutter_html/flutter_html.dart';

TextEditingController Controller_title = new TextEditingController();
TextEditingController Controller_content = new TextEditingController();

String myid = '0';
String mytitle = 't';
bool isGetUser = false;
bool bAdd = false;
bool bSch = false;
//參收參數參考 htt

//list_Modal_PsersonSch_new 是用來判斷是否己經有抓過資料庫,給list值了,
//如果用list 過濾資料時,FutureBuilder ,會再啓動一次,這是就判斷不會再回抓資料庫了
//這個做法是綜合許多後自己發明的,有沒有更好的寫法,再觀查一下
List<Modal_wp> list_Modal_wp = [Modal_wp(id: 0, title: '', content: '')];

class class_wpedit extends StatefulWidget {
  //如要用Route ,能正確的用pop返迴值到上一面,需舕叫這個 StatefulWidget ,不能用 StatelessWidget
  //真正原理為何,其實不太懂,有機會要去再深入了解一下, 但應該和 BuildContext 是有關的

  late final String value;
  late final String pagetype;
  class_wpedit({required this.value, required this.pagetype});

  @override
  _wpEditState createState() =>
      _wpEditState(value: this.value, pagetype: pagetype);
}

final ItemScrollController itemScrollController = ItemScrollController();

class _wpEditState extends State<class_wpedit> {
  // String SendBatchID = '';
  // _wpEditState(this.SendBatchID);
  late final String value;

  late final String pagetype;

  _wpEditState({required this.value, required this.pagetype});
  // @override
  void initState() {
    print('剛進來');
    bAdd = false;
    if (value == '') {
      bAdd = true;
    }

    if (this.pagetype == 'sch') {
      bSch = true;
    } else {
      bSch = false;
    }

    isGetUser = false;

    //這個states應該只會進來一次,所以在這裡做初始值
    print('get in:' + value);
    print('get pagetype:' + pagetype);
    print('get pagetype:' + bSch.toString());
    myid = value;
    if (bAdd == false) {
      getwpapi2();
    } else {
      print(value);
      AddNew();
    }

    list_Modal_wp.clear();
    super.initState();
  }

  String getvalue = "";
  @override
  Widget build(BuildContext context) {
    getvalue = widget.value;
    return Scaffold(
      appBar: AppBar(title: Text('wpedit1')),
      body: isGetUser
          ? _buildList(context)
          : !isGetUser
              ? CircularProgressIndicator() // Show a loading indicator
              : Container(),
      bottomNavigationBar: isGetUser
          ? BottomAppBar(
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: buildButton(),
              ),
            )
          : Container(),
    );
  }

  //TODO 下方按鈕
  List<Widget> buildButton() {
    List<Widget> children = <Widget>[];

    children.add(myButton(
      m_child: myText(
        m_text: '儲存',
        m_color: Colors.blue,
      ),
      m_onPressed: () {
        if (bAdd == true) {
          apiadd();
        } else {
          apiEdit();
        }
      },
    ));

    children.add(myButton(
      m_child: myText(
        m_text: '刪除',
        m_color: Colors.red,
      ),
      m_onPressed: () {
        apiDel();
      },
    ));

    children.add(myButton(
      m_child: myText(
        m_text: 'wp文章列表',
      ),
      m_onPressed: () {
        RouterUtil_test.callpage(context, en_runterType.wp_sch);
      },
    ));

    return children;
  }

  Widget _buildList(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: myContain(
                    m_weight: 150,
                    m_child: TextFormField(
                      controller: Controller_title,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'title',
                      ),
                    ),
                  )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  (bSch == true)
                      ? Expanded(child: myContain(m_child: HtmlRenderer()))
                      : Container(),
                  (bSch == false)
                      ? Expanded(
                          child: myContain(
                          m_child: TextFormField(
                            controller: Controller_content,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '內文',
                            ),
                            maxLines: 3,
                          ),
                        ))
                      : Container(),
                ],
              ),
            ],
          ),
        ));
 
  }

  String htmlchange(oldstr) {
    String newstr;
    newstr = oldstr.replaceAll('<br />', '\n');
    return newstr;
  }

  String htmlchange2(oldstr) {
    String newstr;
    newstr = oldstr.replaceAll('<br />', '');
    newstr = newstr.replaceAll('<p>', '');
    newstr = newstr.replaceAll('</p>', '');
    return newstr;
  }

  Widget _body(BuildContext context) {
    return Text(mytitle);
  }

//add
  Future<String> apiadd() async {
    String url = m_url_wpBasic+'/wp-json/myplugin/v1/add';
    // final response = await Dio().post(url);
    // String sss = "";
    var data = {
      'title': Controller_title.text, // 文章的標題
      'content': Controller_content.text, // 文章的內容
    };

    // 發送 POST 請求
    var response = await Dio().post(
      url,
      data: data,
    );
    if (response.statusCode == HttpStatus.ok) {
      print('傳送完成');
    } else {
      print('傳送失敗');
    }
    //print('aaa2333');
    setState(() {});
    print('myresponse:' + response.data);
    myDialog.Dialog_Message(context, '新增完成', 0);

    return "";
  }

  //編輯
  Future<String> apiEdit() async {
    String url = m_url_wpBasic+'/wp-json/myplugin/v1/edit';
    // final response = await Dio().post(url);
    // String sss = "";
    var data = {
      'id': myid, // 文章的 ID
      'title': Controller_title.text, // 文章的標題
      'content': Controller_content.text, // 文章的內容
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
    myDialog.Dialog_Message(context, '存檔完成', 0);

    return "";
  }

  //del
  Future<String> apiDel() async {
    String url = m_url_wpBasic+'/wp-json/myplugin/v1/del/' + myid;
    final response = await Dio().post(url);

    String sss = "";

    if (response.statusCode == HttpStatus.ok) {
      print('get');
    } else {
      print('not ok');
    }
    print('aaa2222');
    setState(() {});
    myDialog.Dialog_Message(context, '刪除完成', 0);
    return "";
  }

  void AddNew() {
    print('new');
    Controller_content.text = '';
    Controller_title.text = '';
    setState(() {
      isGetUser = true;
    });
  }

//get
  Future<String> getwpapi2() async {
    //String url = 'http://127.0.0.1:8000/godlove/wp-json/wp/v2/note/';
    String url = m_url_wpBasic+'/wp-json/wp/v2/note/' + myid;
    print('my api...'+url);
    final response = await Dio().get(url);
    String sss = "";
    // await Future.delayed(Duration(seconds: 5));
    if (response.statusCode == HttpStatus.ok) {
      var post = response.data;
      int id = post['id'];
      String title = post['title']['rendered'];
      String content = post['content']['rendered'];

      content = htmlchange2(content);
      Controller_content.text = content;
      Controller_title.text = title + '(new)';
      // Controller_content.text = json.decode(content);
      // Controller_content.text = Html(data: content) as String;
      mytitle = title;

      //
      // print(json.decode(content));
      // print(title);
      isGetUser = true;
      // testaaa = title;
      // 在這裡使用 ID、標題和內容進行你想要的操作
      // print('Post ID: $id');
      // print('Post Title: $title');
      // print('Post Content: $content');
    } else {
      print('not ok');
    }
    setState(() {
      isGetUser = true;
    });

    return "";
  }
}

class HtmlRenderer extends StatelessWidget {
  //HtmlRenderer
  late String htmlData = """
    <h1>標題</h1>
    <p>這是一段使用 <strong>HTML</strong> 撰寫的文字。</p>
    <a href='https://flutter.dev'>這是一個鏈接</a>
    <img src='https://via.placeholder.com/150' alt='圖片示例'>
  """;
  @override
  Widget build(BuildContext context) {
    htmlData = Controller_content.text;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Html(
        data: htmlData,
        // onLinkTap: (url, _, __, ___) {
        //   print("點擊的鏈接是: $url");
        //   // 這裡可以加入點擊鏈接後的行為，例如打開瀏覽器
        // },
        // onImageTap: (src, _, __, ___) {
        //   print("點擊的圖片來源是: $src");
        // },
      ),
    );
  }
}
