import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:lovetest2/myConn.dart';
import 'Model/Model1.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class testView2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: Icon(Icons.arrow_back),
        backgroundColor: Color.fromRGBO(56, 163, 210, 1.0),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              color: Colors.cyan,
              child: Row(
                children: [
                  Text(
                    "aaaa",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        // color: Colors.black54,
                        fontSize: 18),
                  ),
                  OutlinedButton(
                    child: Text(
                      'testloading',
                      style: TextStyle(color: Colors.deepOrange),
                    ),
                    onPressed: () {
                      print('abc');
                    },
                  ),
                ],
              ),
              // child: Text(
              //   "aaaa",
              //   style: TextStyle(
              //       fontWeight: FontWeight.w400,
              //       // color: Colors.black54,
              //       fontSize: 18),
              // ),
            ),
            Expanded(
              child: _body(context),
            ),
          ],
        ),
      ),
    );
  }

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


  Future<String> GetDatePersonSch() async {
    final response = await Dio().get(m_PersonSch + '/admin');
    list_Modal_PsersonSch = (response.data as List<dynamic>)
        .map((e) => Modal_PsersonSch.fromJson((e as Map<String, dynamic>)))
        .toList();

    return "";
  }

  Widget _buildList(BuildContext context) {
    //原來是 ListView.builder
    print('nowlen' + list_Modal_PsersonSch.length.toString());

    var itemCount = list_Modal_PsersonSch.length;
    if (itemCount == 0) {
      itemCount = 1;
    }

    return ScrollablePositionedList.builder(
        itemCount: list_Modal_PsersonSch.length,
        itemBuilder: (context, index) {
          final user = list_Modal_PsersonSch[index];
          var row = list_Modal_PsersonSch[index];

          return Card(
            child: ListTile(
                title: Container(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => {

                      // debugPrint(row.name1)

                      Navigator.pop(context, row.name1 + '/' + row.name2)
                    },
                    icon: Icon(
                      Icons.touch_app_sharp,
                      color: Color.fromRGBO(51, 207, 222, 1.0),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(row.name1),
                  SizedBox(
                    width: 60,
                  ),
                  Text(row.name2),
                ],
              ),
            )),
          );
        });
  }
}
