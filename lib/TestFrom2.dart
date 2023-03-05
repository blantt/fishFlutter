import 'package:blantt_love_test/component/blanttColor.dart';

import 'component/blanttButton.dart';
import 'package:flutter/material.dart';
import 'myBasic.dart';

class doorForm2 extends StatefulWidget {
  doorForm2({Key? key}) : super(key: key);
  @override
  aaa createState() => aaa();
}

class aaa extends State<doorForm2> {
  String ttt = "";

  @override
  void initState() {
    ttt = "abc";
  }

  _testReresh() async {
    this.setState(() {
      ttt = "99999";
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
          primary: Colors.amber,
          //side: BorderSide(width: 1.0, color: Colors.blueAccent),
        ),
        child: Icon(Icons.person),
        onPressed: () {},
      ),
    );

    // return SizedBox(
    //   height: 30, //height of button
    //   width: 100, //width of button
    //   child: ElevatedButton.icon(
    //       style: ButtonStyle(
    //
    //           backgroundColor: MaterialStateProperty.all(Colors.red),
    //           padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
    //           textStyle:
    //               MaterialStateProperty.all(const TextStyle(fontSize: 15))),
    //       onPressed: () {},
    //       icon: Icon(
    //         Icons.abc_sharp,
    //         size: 30,
    //       ),
    //       label: Text('')),
    // );
    //
  }

  Widget sss() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        child: Column(
          children: [
            Row(
              children: [Expanded(child: Text('KKK'))],
            ),

            Column(
              children: [
                Text('ddd'),
                ttt2(),
              ],
            ),
            myContain(
              m_heght: 800,
              m_boxDecoration: new BoxDecoration(
                color: MyColor.back_COLOR1,
              ),
              m_child: Text('ABCC'),
            ),
            // Expanded(
            //   child: SingleChildScrollView(
            //     child: tempList(),
            //   ),
            //   flex: 0,
            // ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('測試單元2_3')),
      body: Center(
          child: Column(children: [
        Expanded(
          child: myContain(
            m_child: Text('662'),
            m_boxDecoration: new BoxDecoration(color: MyColor.back_COLOR1),
            m_heght: 15,
          ),
          flex: 0,
        ),
        Expanded(
          child: myContain(
            m_child: tempList(),
            m_heght: 80,
          ),
          flex: 0,
        ),
        Expanded(
          child: sss(),
        )
      ])),
    );
  }
}
