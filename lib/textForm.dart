import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class TextFieldExample extends StatefulWidget {
  const TextFieldExample({Key? key}) : super(key: key);

  @override
  State createState() => _TextFieldExampleState();
}

class _TextFieldExampleState extends State {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Text('ddd2'),
          SizedBox(
            height: 200,
            child: Text('T1'),
          ),
          SizedBox(
            height: 600,
            child: Text('T2'),
          )
        ]));

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ddd2'),
          SizedBox(
            height: 200,
            child: Text('T1'),
          ),
          SizedBox(
            height: 200,
            child: Text('T2'),
          )
        ]);
  }
}
