import 'dart:typed_data';

import 'package:lovetest2/Test/TestForm3.dart';
import 'package:lovetest2/component/blanttColor.dart';

import '../component/blanttButton.dart';
import 'package:flutter/material.dart';
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

class doorForm2 extends StatefulWidget {
  doorForm2({Key? key}) : super(key: key);
  @override
  aaa createState() => aaa();
}

Future<String> _getLocalDocumentFile() async {
  final dir = await getApplicationDocumentsDirectory();
  print(dir.path);
  return dir.path;
  //return File('${dir.path}/str.txt');
}

/// 获取临时目录文件
Future<String> _getLocalTemporaryFile() async {
  final dir = await getTemporaryDirectory();
  print(dir.path);
  return dir.path;
  //return File('${dir.path}/str.txt');
}

/// 获取应用程序目录文件
Future<String> _getLocalSupportFile() async {
  final dir = await getApplicationSupportDirectory();
  print(dir.path);
  return dir.path;
  // File('${dir.path}/str.txt');
}

classUserInfo mySharedPreferences = classUserInfo();
void yourFunction() async {
  // classUserInfo mySharedPreferences = classUserInfo();
  String? sss = await mySharedPreferences.get_FullName();
  // 現在可以使用 sss 變數了
  if (sss != null) {
    print('get it ' + sss);
  } else {
    // 當 'UserName' 鍵不存在或者其值為 null 時的處理
  }
}

class aaa extends State<doorForm2> {
  String _storedText = "";
  String ttt = "";
  String? StrIOFilepath = "";
  AssetImage _AssetImage = AssetImage("assets/images/date2.png");

  @override
  void initState() {
    ttt = "abc";
    // classUserInfo mySharedPreferences = classUserInfo();
    // mySharedPreferences.getname();
    // print('new2:' + mySharedPreferences.myUserName);
    //yourFunction();
    _loadStoredText();
  }

  _testReresh() async {
    this.setState(() {
      ttt = "99999";
    });
  }

  //TODO 取得暫時資訊
  void _loadStoredText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      print(prefs.getString('UserName') ?? "");
      _storedText = prefs.getString('UserName') ?? "";
    });
  }

  Widget sss2() {
    String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return SingleChildScrollView(
      child: Column(
        //动态创建一个List<Widget>
        children: str
            .split("")
            //每一个字母都用一个Text显示,字体为原来的两倍
            .map((c) => Text(
                  c,
                  textScaleFactor: 2.0,
                ))
            .toList(),
      ),
    );
  }

  Widget tempList() {
    return ListView(
      children: [
        Card(
            child: ListTile(
          title: Text("List Item 1"),
        )),
        Card(
          child: ListTile(
            title: Text("List Item 2"),
          ),
        ),
        Card(
            child: ListTile(
          title: Text("List Item 3"),
        )),
      ],
      padding: EdgeInsets.all(10),
    );
  }

  Widget ttt2() {
    return SizedBox(
      height: 40.0,
      width: 40.0,
      child: TextButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          //side: BorderSide(width: 1.0, color: Colors.blueAccent),
        ),
        child: Icon(Icons.person),
        onPressed: () {},
      ),
    );
  }

  Future<String> get _appDocPath async {
    final directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    return directory.path;
  }

  Future<File> get _messageFile async {
    final path = await _appDocPath;
    print('OK2');
    return File('$path/message123.txt');
  }

  Future<String> readMessage() async {
    final file = await _messageFile;
    String contents = await file.readAsString();
    print(contents);
    return contents;
  }

  Future<File> writeMessage(String message) async {
    final file = await _messageFile;

    print('OK');
    return file.writeAsString('$message');
  }

  // Future<void> testimagetest() async {
  //   final sss = await getAssetStrig("assets/images/date1.png");
  //   print(sss);
  //   this.setState(() {
  //     //_AssetImage = AssetImage(sss);
  //   });
  // }

  Future<void> testimagetest2() async {}

  Future<String> testpath() async {
    // 获取应用程序文档目录路径
    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;

    // 获取本地端文档目录的路径
    final localAppDocPath = path.join(Directory.current.path, 'documents');
    print('local:' + Directory.current.path);
    print('应用程序文档目录路径：$appDocPath');
    print('本地端文档目录路径：$localAppDocPath');
    return '';
  }

  Future<File> getAssetFile(String assetPath) async {
    // 將檔案複製到應用程式的檔案系統中
    final ByteData data = await rootBundle.load(assetPath);
    final Uint8List bytes = data.buffer.asUint8List();
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = '${tempDir.path}/${assetPath.split('/').last}';
    final File file = File(tempPath);
    await file.writeAsBytes(bytes);
    print(tempPath);
    print('my getAssetFile');
    // 返回檔案 File 實例
    return file;
  }

  Future<void> getimage() async {
    String tempPath = '';
    try {
      final Directory tempDir = await getApplicationSupportDirectory();
      tempPath = '${tempDir.path}/date1.png';
      // final File file = File(tempPath);
      // _AssetImage = AssetImage("assets/images/date1.png");
      print('get image' + tempPath);
      StrIOFilepath = tempPath;
      String tt;
      //Function which may throw an exception
    } catch (error) {
      //Error handle
      print('i am error');
    }
  }

  Future<String> saveAssetStrig(String assetPath) async {
    // 將檔案複製到應用程式的檔案系統中
    String tempPath = '';
    try {
      final ByteData data = await rootBundle.load(assetPath);
      final Uint8List bytes = data.buffer.asUint8List();
      final Directory tempDir = await getApplicationSupportDirectory();
      tempPath = '${tempDir.path}/${assetPath.split('/').last}';
      final File file = File(tempPath);
      await file.writeAsBytes(bytes);
      print('save image' + tempPath);
      String tt;
      //Function which may throw an exception
    } catch (error) {
      //Error handle
      print('i am error');
    }

    return tempPath;
  }

  Widget sss() {
    Widget imageWidget;
    if (StrIOFilepath != null && StrIOFilepath!.isNotEmpty) {
      imageWidget = Image.file(
        File(StrIOFilepath!),
        fit: BoxFit.cover,
      );
    } else {
      imageWidget = Text('No Image');
    }

    void _saveText() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('UserName', 'blantt55');
      _loadStoredText(); // Update the displayed text after saving.
    }

    void _testlink() {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => selectDate()),
      // );

      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new selectDate()));

      //Navigator.of(context).pop();
    }

    //TODO 存暫時資訊
    void _saveText2() async {
      //   classUserInfo mySharedPreferences = classUserInfo();
      //mySharedPreferences.set_UserName("阿中7");

      mySharedPreferences.set_islogin(true);
      //mySharedPreferences.myUserName = "999";
      _loadStoredText(); // Update the displayed text after saving.
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        child: Column(
          children: [
            Text('Stored Text: $_storedText'),
            myButton(
                m_child: Text('測試router連結'),
                m_onPressed: () {
                  _testlink();
                }),
            myButton(
                m_child: Text('暫存資訊'),
                m_onPressed: () {
                  _saveText2();
                }),
            myButton(
                m_child: Text('取得路徑'),
                m_onPressed: () {
                  writeMessage("hallo888");
                }),
            myButton(
                m_child: Text('讀取檔案'),
                m_onPressed: () {
                  readMessage();
                }),
            myButton(
                m_child: Text('看能否取得路徑'),
                m_onPressed: () {
                  testpath();
                }),
            myButton(
                m_child: Text('saveimage'),
                m_onPressed: () {
                  saveAssetStrig("assets/images/date1.png");

                  //getAssetFile("assets/images/date1.png");
                }),
            myButton(
                m_child: Text('saveimage_測試用webapi'),
                m_onPressed: () {
                  sendfileFromWebpage();

                  //getAssetFile("assets/images/date1.png");
                }),
            myButton(
                m_child: Text('webapitest2'),
                m_onPressed: () {
                  sendWebapitest();
                }),
            myButton(
                m_child: Text('got image'),
                m_onPressed: () {
                  this.setState(() {
                    ttt = "99999";
                    getimage();
                    // _AssetImage = AssetImage("assets/images/date1.png");
                  });
                }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    UnderlineInputBorder tempenabledBorder;
    tempenabledBorder = UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10.0), // 圆角半径
      borderSide: BorderSide(color: Colors.red), // 边框颜色//<-- SEE HERE
    );
    return Scaffold(
      appBar: AppBar(title: Text('測試單元2_3')),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),

          // 添加更多按鈕
        ],
      ),
      body: Center(
          child: Column(children: [
        Container(
          color: Colors.grey, // 父Container的背景色
          height: 200, // 父Container的高度
          width: 200, // 父Container的宽度
          child: Stack(
            children: [
              Positioned(
                top: 50, // 外部子Container相对于父Container顶部的距离
                left: 50, // 外部子Container相对于父Container左侧的距离
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue, // 外部子Container的背景色
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.red, // 内部Container的背景色
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: sss(),
        )
      ])),
    );
  }
}

Widget myformfield() {
  Widget dd;

  return Text('data');
}

Future<String?> uploadFile(String filename, List<int> fileBytes) async {
  try {
    String url = 'your_web_api_url'; // 替換為你的網頁版API的URL

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['filename'] = filename;
    request.files.add(
        http.MultipartFile.fromBytes('file', fileBytes, filename: filename));

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      return responseData;
    } else {
      print('API request failed with status code: ${response.statusCode}');
      return null;
    }
  } catch (error) {
    print('API request failed with error: $error');
    return null;
  }
}

Future<void> sendWebapitest() async {
  try {
    String url =
        'https://editor.4kids.com.tw/Portal/blantt/testWebapi/test1.html'; // 替換為你的 API 端點 URL

    Uri uri = Uri.parse(url);
    Map<String, String> queryParams = {
      'aa': '888',
      'bb': '999',
    };
    uri = uri.replace(queryParameters: queryParams);

    var response = await http.get(uri);
    if (response.statusCode == 200) {
      print('OK');
      print(response.body);
    } else {
      print('API request failed with status code: ${response.statusCode}');
    }
  } catch (error) {
    print('API request failed with error: $error');
  }
}

Future<void> sendfileFromWebpage() async {
  String filename = 'your_filename.pdf'; // 替換為你的檔案名稱
  List<int> fileBytes =
      await File('path_to_your_file').readAsBytes(); // 替換為讀取檔案的方式

  String? apiResponse = await uploadFile(filename, fileBytes);
  if (apiResponse != null) {
    // 處理API回應
  } else {
    // API請求失敗的處理
  }
}
