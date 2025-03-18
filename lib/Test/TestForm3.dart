import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../component/blanttButton.dart';
import '../component/blanttFileControl.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'dart:typed_data';
import 'package:lovetest2/Test/TestForm2.dart';

void main() {
  runApp(TestFomr3());
}

Future<String> getLocalPath(String Filename) async {
  // 將檔案複製到應用程式的檔案系統中
  String tempPath = '';

  final Directory tempDir = await getTemporaryDirectory();
  tempPath = '${tempDir.path}/' + Filename;
  final File file = File(tempPath);

  return tempPath;
}

Future<String> testPath(String Filename) async {
  return 'ttttt';
}

void gettestpath() async {
  String result = await testPath('example.txt');
}

class TestFomr3status extends State<TestFomr3> {
  // 文件下载示例
  Future<void> downloadFile(String fileUrl, String savePath) async {
    try {
      // 发送 GET 请求并下载文件
      Response response = await Dio().download(
        fileUrl,
        savePath,
      );

      print('fileUrl:' + fileUrl);
      print('savePath:' + savePath);

      // this.setState(() {
      //   //--消除圖片的暫緩,需在圖片download完成之後
      //   evictImage();
      //   //StrIOFilepath = savePath;
      // });

    } catch (e) {}
  }

// 文件上传示例
  Future<void> uploadFile(String filePath) async {
    // 创建 FormData 对象并添加要上传的文件
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(filePath),
    });

    try {
      // 发送 POST 请求并上传文件
      Response response = await Dio().post(
        "http://example.com/upload",
        data: formData,
      );
    } catch (e) {
      // 处理错误

    }
  }

  void ssss() {
    executeFunction(callback: () {});
  }

  void executeFunction({Function? callback}) {
    if (callback != null) {
      callback();
    } else {}
  }

  Future<String> setimage2(String imageurl, String filename,
      {Function? funcCall}) async {
    final path = await getLocalPath(filename);

    await downloadFile(imageurl, path);
    //funcCall 是download完成後才執行的function(例如清除圖片暫緩)
    if (funcCall != null) {
      funcCall();
    }

    return path;
  }

  Future<String> setimage(String imageurl, String filename, funcCall) async {
    final path = await getLocalPath(filename);

    await downloadFile(imageurl, path);
    //funcCall 是download完成後才執行的function(例如清除圖片暫緩)
    funcCall();

    return path;
  }

  // String? StrIOFilepath =
  //   //     "/data/user/0/com.example.blantt_love_test/cache/aaa3.png";

  String? StrIOFilepath =
      "/data/user/0/com.example.blantt_love_test/cache/blantt/aaa3.png";
  late File _imageFile;

  void evictImage() {
    // final NetworkImage provider = NetworkImage(StrIOFilepath!);
    _imageFile = File(StrIOFilepath!);

    final FileImage provider = FileImage(_imageFile);
    provider.evict().then<void>((bool success) {
      if (success) {
      } else {}
    });
  }

  void testcall() {
    this.setState(() {
      evictImage();
    });
  }

  //---刪暫存
  void callevictImage(String FileName) {
    this.setState(() {
      classMyFile.evictImage(FileName);
    });
  }

  MyFileControl classMyFile = MyFileControl(otherFolder: 'blantt');
  int iicount = 0;
  @override
  Widget build(BuildContext context) {
    Widget bb;
    Widget imageWidget;

    print(StrIOFilepath);
    if (StrIOFilepath != null && StrIOFilepath!.isNotEmpty) {
      File file;
      file = File(
        StrIOFilepath!,
      );

      String tempkey = DateTime.now().millisecondsSinceEpoch.toString();
      iicount += 1;
      //TODO 測試進來段

      //evictImage();
      imageWidget = Image.file(
        File(StrIOFilepath!),
        key: ValueKey(tempkey),
        height: 100,
        width: 100,
        //fit: BoxFit.cover,
      );
    } else {
      imageWidget = Text('No Image');
      bb = Text('No Image');
    }
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('filetest')),
        body: Center(
            child: Column(
          children: [
            myButton(
                m_child: Text('dio讀取並寫入sss'),
                m_onPressed: () {
                  // setimage2('','',funcCall: testcall);

                  // setimage2(
                  //     'https://editor.4kids.com.tw/Portal/imageClock/A202303170002/0316.jpg' +
                  //         '?' +
                  //         DateTime.now().millisecondsSinceEpoch.toString(),
                  //     'aaa3.png',
                  //     funcCall: testcall);

                  classMyFile.setimage(
                      'https://editor.4kids.com.tw/Portal/imageClock/A202303170002/0316.jpg' +
                          '?' +
                          DateTime.now().millisecondsSinceEpoch.toString(),
                      'aaa3.png', funcCall: () {
                    callevictImage('aaa3.png');
                  });
                }),
            myButton(
                m_child: Text('get'),
                m_onPressed: () {
                  // setimage2(
                  //     'https://cdn-icons-png.flaticon.com/512/3884/3884851.png' +
                  //         '?' +
                  //         DateTime.now().millisecondsSinceEpoch.toString(),
                  //     'aaa3.png',
                  //     funcCall: testcall);
                  classMyFile.setimage(
                      'https://cdn-icons-png.flaticon.com/512/3884/3884851.png' +
                          '?' +
                          DateTime.now().millisecondsSinceEpoch.toString(),
                      'aaa3.png', funcCall: () {
                    callevictImage('aaa3.png');
                  });
                }),
            myButton(
                m_child: Text('TestNewlink'),
                m_onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => doorForm2()));
                }),
            myButton(
                m_child: Text('取得文件內容'),
                m_onPressed: () {
                  classMyFile.getFileList();
                }),
            myButton(
                m_child: Text('刪除文件內容'),
                m_onPressed: () {
                  classMyFile.delFilefolder('');
                }),
            myButton(
                m_child: Text('清暫存測試'),
                m_onPressed: () {
                  this.setState(() {
                    evictImage();
                  });
                }),
            myButton(
                m_child: Text('classtest'),
                m_onPressed: () {
                  setState(() {
                    classMyFile.setimage(
                        'https://editor.4kids.com.tw/Portal/imageClock/A202303170002/0316.jpg' +
                            '?' +
                            DateTime.now().millisecondsSinceEpoch.toString(),
                        'aaa3.png', funcCall: () {
                      callevictImage('aaa3.png');
                    });

                    // tt.setimage(
                    //     'https://cdn-icons-png.flaticon.com/512/3884/3884851.png' +
                    //         '?' +
                    //         DateTime.now().millisecondsSinceEpoch.toString(),
                    //     'aaa3.png',
                    //     funcCall: testcall);
                  });
                }),
            imageWidget,
          ],
        )),
      ),
    );
  }
}

void delFilefolder() async {
  Directory tempDir = await getTemporaryDirectory();
  Directory directory = new Directory('${tempDir.path}');

  if (directory.existsSync()) {
    List<FileSystemEntity> files = directory.listSync();

    if (files.length > 0) {
      files.forEach((file) {
        file.deleteSync();
      });
    }

    directory.deleteSync();
  }
}

void getFileList() async {
  // Directory tempDir = await getApplicationSupportDirectory();
  Directory tempDir = await getTemporaryDirectory();
  Directory directory = new Directory('${tempDir.path}');

  directory.listSync().forEach((file) {});
}

class TestFomr3 extends StatefulWidget {
  TestFomr3({Key? key}) : super(key: key);
  @override
  TestFomr3status createState() => TestFomr3status();
}
