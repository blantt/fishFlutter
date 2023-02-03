import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class classTestTime extends StatelessWidget {
  const classTestTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _date = DateTime(2020, 11, 17);
  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2022, 7),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: [
      Container(
        margin: EdgeInsets.fromLTRB(0, 65, 0, 0),
      ),
      Text('aa'),
      Text('aa2'),
      OutlinedButton(
        child: Text(
          '測試回傳',
          style: TextStyle(color: Colors.deepOrange),
        ),
        onPressed: () {
          _selectDate();
        },
      ),
      Text(
        'Selected date: $_date',
      ),
    ])));
  }
}
