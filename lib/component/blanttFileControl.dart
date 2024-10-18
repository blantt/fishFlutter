import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'dart:typed_data';

//path_provider详解
//https://segmentfault.com/a/1190000040808286

void test() {
  MyFileControl tt = MyFileControl();
}

class MyFileControl {
  int itype; //1臨時目錄,2文檔目標
  String otherFolder = ''; //文檔裡,另創資料匣
  String FolderPath = '';
  MyFileControl({this.itype = 1, this.otherFolder = ''}) {
    //GetFolderPath();
    gettpathTest();
  }

  void gettpathTest() async {
    String result = await GetFolderPath();
  }

  Future<String> GetFolderPath() async {
    if (otherFolder != '') {
      otherFolder = otherFolder;
    }
    if (itype == 1) {
      final Directory tempDir = await getTemporaryDirectory();
      FolderPath = tempDir.path + '/' + otherFolder;
    }
    if (itype == 2) {
      final Directory tempDir = await getApplicationDocumentsDirectory();
      FolderPath = tempDir.path + '/' + otherFolder;
    }

    return FolderPath;
  }

  Future<String> Copyimage(String imageurl, String filename,
      {Function? funcCall}) async {
    final path = await GetFolderPath();
    String tempPath = path + '/' + filename;

    await File(imageurl).copy(tempPath);
    //funcCall 是download完成後才執行的function(例如清除圖片暫緩)
    if (funcCall != null) {
      funcCall();
    }

    return tempPath;
  }

  Future<String> setimage(String imageurl, String filename,
      {Function? funcCall}) async {
    final path = await GetFolderPath();
    String tempPath = path + '/' + filename;
    print('i set path2:' + tempPath);
    await downloadFile(imageurl, tempPath);
    //funcCall 是download完成後才執行的function(例如清除圖片暫緩)
    if (funcCall != null) {
      funcCall();
    }

    return tempPath;
  }

  Future<void> downloadFile(String fileUrl, String savePath) async {
    try {
      // 发送 GET 请求并下载文件
      Response response = await Dio().download(
        fileUrl,
        savePath,
      );

      //TODO download end

      // print('fileUrl2:' + fileUrl);
      // print('savePath2:' + savePath);
    } on FormatException catch (e) {
      // 捕获FormatException并获取错误信息
      print('捕获到downloadFile 異常：$e');
    } catch (e) {
      // 捕获其他类型的异常
      print('捕获到downloadFile 異常2：$e');
    }
  }

  //刪除文件暫緩
  void evictImage(String FileName) {
    late File _imageFile;
    _imageFile = File(FolderPath + '/' + FileName);

    final FileImage provider = FileImage(_imageFile);
    provider.evict().then<void>((bool success) {
      if (success) {
      } else {}
    });
  }

  //刪除資料匣內所有內容
  void delFilefolder(String delfile) async {
    Directory tempDir = await getTemporaryDirectory();
    Directory directory = new Directory(FolderPath);

    if (directory.existsSync()) {
      List<FileSystemEntity> files = directory.listSync();

      if (files.length > 0) {
        files.forEach((file) {
          if (delfile == "") {
            file.deleteSync();
          } else {
            String fileName = file.path.split('/').last;
            if (fileName == delfile) {
              file.deleteSync();
            }
          }
        });
      }
      if (delfile != "") {
        directory.deleteSync();
      }

      print('刪除完成');
    }
  }

  //讀取資料匣內所有內容
  void getFileList() async {
    List<String> ListImage = [];
    Directory directory = new Directory(FolderPath);
    directory.listSync().forEach((file) {
      //ListImage.add(file.path);
      print(file.path);
    });
  }

  List<String> getFileList2() {
    List<String> stringList = [];
    if (FolderPath == '') {
      //--防呆,如果頁面取值時,還沒有取到時,會有例外
      return stringList;
    }

    Directory directory = new Directory(FolderPath);
    directory.listSync().forEach((file) {
      stringList.add(file.path);
    });
    return stringList;
  }
}
