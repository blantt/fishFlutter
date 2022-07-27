import 'package:blantt_love_test/ListView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blantt_love_test/testView.dart';

//不錯的做法! https://www.youtube.com/watch?v=4tG8M4wK4F0

void main() {
  runApp(MyListView());
}

class MyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter App Learning',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class User {
  final String username;
  final String email;
  final String myUrl;

  const User(
      {required this.username, required this.email, required this.myUrl});
}

List<User> users = [
  const User(username: 'PP', email: 'dd', myUrl: 'MM'),
  const User(username: 'PP2', email: 'dd', myUrl: 'MM')
];

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter GridView"),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Card(
              child: ListTile(
                title: Text(user.username),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => testview()));
                },
              ),
            );
          }

          //=> Card(
          //   child: ListTile(
          //     title: Text('UserName,$index'),
          //   ),
          ),
      // )

      // body: ListView(
      //   children: [
      //     Card(
      //         child: ListTile(
      //       title: Text("List Item 1"),
      //       onTap: () {
      //         Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => testview()));
      //       },
      //     )),
      //     Card(
      //       child: ListTile(
      //         title: Text("List Item 2"),
      //       ),
      //     ),
      //     Card(
      //         child: ListTile(
      //       title: Text("List Item 3"),
      //     )),
      //   ],
      //   shrinkWrap: true,
      // )
    );
  }
}
