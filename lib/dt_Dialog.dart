import 'dart:io';
import 'package:blantt_love_test/textForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class classDialog extends StatelessWidget {
  const classDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _menu(context);
  }
}

TimeOfDay selectedTime = TimeOfDay.now();

void fff(String x) {
  print(x);
}

Widget _menu(BuildContext context) {
  return Scaffold(
      body: Center(
          child: Column(children: [
    Container(
      margin: EdgeInsets.fromLTRB(0, 65, 0, 0),
    ),
    OutlinedButton(
      child: Text(
        '測試回傳',
        style: TextStyle(color: Colors.deepOrange),
      ),
      onPressed: () {
        showDialog(builder: (_) => _displayDialog3(), context: context)
            .then((value) {
          // if (value != null) {
          //   print(value);
          // }

          print(value);
        });
      },
    ),
    OutlinedButton(
      child: Text(
        'yes or no',
        style: TextStyle(color: Colors.deepOrange),
      ),
      onPressed: () {
        _showDialog(context);
      },
    ),
    OutlinedButton(
      child: Text(
        'full',
        style: TextStyle(color: Colors.deepOrange),
      ),
      onPressed: () {
        _displayDialog(context);
      },
    ),
    OutlinedButton(
      child: Text(
        'simple',
        style: TextStyle(color: Colors.deepOrange),
      ),
      onPressed: () {
        String ddd = _displayDialog2(context);
      },
    ),
    OutlinedButton(
      child: Text(
        'datetime',
        style: TextStyle(color: Colors.deepOrange),
      ),
      onPressed: () {
        showTimePicker(
            context: context,
            initialTime: selectedTime,
            initialEntryMode: TimePickerEntryMode.dial,
            confirmText: "CONFIRM",
            cancelText: "NOT NOW",
            helpText: "BOOKING TIME");
      },
    ),
  ])));
}

enum ConfirmAction { no, ACCEPT, CANCEL }

class _displayDialog3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('測試可以用模組接收回傳值'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              OutlinedButton(
                child: Text(
                  'test1',
                  style: TextStyle(color: Colors.deepOrange),
                ),
                onPressed: () {
                  Navigator.pop(context, ConfirmAction.ACCEPT);
                },
              ),
              OutlinedButton(
                child: Text(
                  'test2',
                  style: TextStyle(color: Colors.deepOrange),
                ),
                onPressed: () {
                  Navigator.pop(context, ConfirmAction.CANCEL);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

//TODO simple2
_displayDialog2(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: SimpleDialog(
            title: Text('訊息'),
            children: [
              TextButton(
                onPressed: () {
                  //  Navigator.of(context).pop();
                  Navigator.pop(context, "OK");
                },
                child: Text(
                  'YES',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, "NO");
                },
                child: Text(
                  'NO',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        );
      }).then((value) => debugPrint(value));
}

ttt(BuildContext context) {}

_showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Expanded(
        child: AlertDialog(
          title: Text('訊息'),
          content: Text('確定要進入嗎?'),
          actions: [
            TextButton(
              onPressed: () {
                //  Navigator.of(context).pop();
                Navigator.pop(context, "OK");
              },
              child: Text(
                'YES',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, "NO");
              },
              child: Text(
                'NO',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      );
    },
  ).then((value) => debugPrint(value));
}

_displayDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    transitionDuration: Duration(milliseconds: 2000),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: animation,
          child: child,
        ),
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) {
      return SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(20),
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Hai This Is Full Screen Dialog',
                  style: TextStyle(color: Colors.red, fontSize: 20.0),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "DISMISS",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
