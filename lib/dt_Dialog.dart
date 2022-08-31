import 'dart:io';
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
Widget _menu(BuildContext context) {
  return Scaffold(
      body: Center(
          child: Column(children: [
    Container(
      margin: EdgeInsets.fromLTRB(0, 65, 0, 0),
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
        _displayDialog2(context);
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
                Navigator.of(context).pop();
              },
              child: Text(
                'YES',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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
  );
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

var _selected = "";
_displayDialog2(BuildContext context) async {
  _selected = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return Expanded(
        child: SimpleDialog(
          title: Text('Choose food'),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, "Pizza");
              },
              child: const Text('Pizza'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, "Burger");
              },
              child: const Text('Burger'),
            ),
          ],
          elevation: 10,
          //backgroundColor: Colors.green,
        ),
      );
    },
  );

  // if(_selected != null)
  // {
  //   setState(() {
  //     _selected = _selected;
  //   });
  // }
}
