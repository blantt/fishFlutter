import 'package:flutter/material.dart';

class testform2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: '/',
      // routes: <String, WidgetBuilder>{
      //   '/abc': (_) => new HomePage_list2(),
      // },
      title: 'dddd',

      home: _testform2(),
    );
  }
}

class _testform2 extends StatefulWidget {
  const _testform2({Key? key}) : super(key: key);

  @override
  State createState() => _TextFieldExampleState();
}

class _TextFieldExampleState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ffff'),
      ),
      body: Text('dd3'),
    );
  }
}
