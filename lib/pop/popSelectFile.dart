import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'component/blanttButton.dart';
import '../component/blanttFileControl.dart';

class popSelectFile extends StatefulWidget {
  String SelectFile;
  popSelectFile({required this.SelectFile});
  // doorSelectTime(String time1, String Time2);

  @override
  doorpopSelectFile createState() => doorpopSelectFile();
}

MyFileControl classMyFile = MyFileControl(otherFolder: 'blantt2');
MyFileControl classMyFileSelect = MyFileControl(otherFolder: 'blantt3');

class doorpopSelectFile extends State<popSelectFile> {
  void initState() {
    //String tt = classMyFileSelect.GetFolderPath() as String;
    super.initState();
  }

  Widget fomr1() {
    List<String> ListImage = [];
    // ListImage = classMyFile.getFileList2();
    String fileName = widget.SelectFile.split('/').last;
    classMyFileSelect.Copyimage(widget.SelectFile, fileName);

    String sss = classMyFileSelect.FolderPath;

    bool isnew = false;
    Widget myob;
    String sss2 = classMyFileSelect.FolderPath + '/' + fileName;
    File? myfile;

    Image? myimage;

    if (isnew == true) {
      //新增時沒有點案,給個空的
      myob = myContain(
        m_heght: 150,
        m_weight: 150,
      );
    } else {
      myimage = Image.file(
        File(widget.SelectFile),
        height: 250,
        // width: 150,
      );

      fileName = widget.SelectFile.split('/').last;
      myob = myimage;
    }

    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        myButton(
          m_child: Text('選擇檔案'),
          m_onPressed: () {
            _openImagePicker(fileName);
          },
        ),
        Row(
          children: [
            Expanded(
              child: myContain(
                // alignment: Alignment.center,
                m_Alignment: Alignment.topCenter,
                // color: Colors.greenAccent,
                // width: 400,
                //m_heght: 200,
                m_child: Column(children: [
                  myContain(
                    m_boxDecoration: new BoxDecoration(
                        //color: Colors.lightBlueAccent,

                        ),
                    m_Alignment: Alignment.topCenter,
                    m_child: myob,
                  )
                ]),
              ),
            ),
          ],
        ),
        myButton(
          m_child: Text('確定'),
          m_onPressed: () {
            Navigator.pop(context, widget.SelectFile);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: Icon(Icons.arrow_back),
        backgroundColor: Color.fromRGBO(56, 163, 210, 1.0),
        title: Text('附件選單'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: fomr1(),
        color: Color.fromRGBO(221, 232, 202, 1.0),
      ),
    );
  }

  Future<void> _openImagePicker(String oldfilename) async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery); // 打开手机相册

    if (pickedFile != null) {
      print('我選擇了圖片');
      //--(待驗證)取得圖片,取得文件名,刪除原來的檔案,並且寫入選擇的檔案

      //String fileName = basename(pickedFile.path);
      String filePath = pickedFile.path;
      File file = File(filePath);
      String fileName = file.path.split('/').last;
      print('选中的文件名：$fileName');

      // classMyFile.delFilefolder(oldfilename);
      // classMyFile.Copyimage(pickedFile.path, fileName);
      classMyFileSelect.Copyimage(pickedFile.path, fileName);
      print('這是完整的文件名嗎 ??：' + filePath);

      this.setState(() {
        widget.SelectFile = filePath;
      });
    }
  }
}

String message(bool isValid) {
  return 1 == 1 ? 'This is valid' : 'This is not valid';
}

void dd() {
  BoxDecoration bb = BoxDecoration();
  BoxDecoration? cc;
  final Widget dd;
  bool isReturningCustomer;

  BorderRadius kk;
}

class classFild extends StatelessWidget {
  DateTime mytime = DateTime.now();

  classFild({required DateTime hh}) {
    this.mytime = hh;
  }

  @override
  Widget build(BuildContext context) {
    String tempdate = "";
    if (this.mytime.year == 1911) {
      tempdate = "";
    } else {
      tempdate = DateFormat('yyyy-MM-dd HH:mm').format(mytime);
    }
    return Container(
      height: 40,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      decoration: new BoxDecoration(
        color: Color.fromRGBO(243, 255, 255, 1),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        border: new Border.all(
          width: 1,
          color: Color.fromRGBO(75, 41, 27, 1.0),
        ),
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(190, 183, 162, 1.0),
              //color: Colors.lightBlue,
              offset: Offset(-6.0, 6.0), //陰影x軸偏移量
              blurRadius: 10, //陰影模糊程度
              spreadRadius: 0 //陰影擴散程度
              )
        ],
      ),
      child: new Text(
        tempdate,
        //DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
        style: new TextStyle(
            fontWeight: FontWeight.w400, color: Colors.indigo, fontSize: 18),
      ),
    );
  }
}

class KBigButton extends StatelessWidget {
  String text = "";

  KBigButton({String gggggg = ""}) {
    this.text = gggggg;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      padding: EdgeInsets.all(0),
      width: MediaQuery.of(context).size.width - 20,
      height: 48,
      child: RaisedButton(
        onPressed: () {},
        child: Text(this.text),
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
    );
  }
}

Widget ttt(BuildContext context) {
  return TextInputWithIcon(iconPath: "");
}

class TextInputWithIcon extends StatelessWidget {
  final String iconPath;
  final String placeHolder;
  final Function(bool)? onFocusChange; // nullable and optional

  const TextInputWithIcon({
    Key? key,
    required this.iconPath, // non-nullable and required
    this.placeHolder = "", // non-nullable but optional with a default value
    this.onFocusChange, // nullable and optional
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        padding: EdgeInsets.all(0),
        width: MediaQuery.of(context).size.width - 20,
        height: 48,
        child: Text('ddd'));
  }
}
