import 'package:flutter/material.dart';

//這是自己在測試範例textform
class testview extends StatefulWidget {
  const testview({Key? key}) : super(key: key);
  @override
  createState() => _testview2();
}

class _testview2 extends State<testview> {
  bool _numberInputIsValid = true;

  Widget _buildBorderlessTextField() {
    return const TextField(
      maxLines: 3,
      decoration: InputDecoration.collapsed(hintText: 'borderless input'),
    );
  }

  TextEditingController emailController = new TextEditingController();
  String textHolder = 'Old Sample Text...!!!';

  changeText() {
    setState(() {
      textHolder = 'New Sample Text...';
    });
  }

  //表單測試
  //TODO form test
  Widget _tetform() {
    return Form(
        child: Column(children: <Widget>[
      // TextFormField(initialValue: "I am smart"),
      //Text('$textHolder'),
      TextFormField(
        //'$textHolder'
        //initialValue: '$textHolder',
        controller: emailController,
        decoration:
            InputDecoration(icon: Icon(Icons.people), labelText: 'UserName'),
      ),
      TextFormField(
        obscureText: true,
        decoration: InputDecoration(icon: Icon(Icons.lock), labelText: "密碼"),
      ),
      Container(
          margin: EdgeInsets.fromLTRB(150, 80, 0, 0),
          child: OutlinedButton(
            child: Text(
              '登入',
              style: TextStyle(color: Colors.deepOrange),
            ),
            onPressed: () {
              //changeText();
              emailController.text = 'bbbb';
              print(emailController.text);
            },
          ))
    ]));
  }

  Widget _newob() {
    return Row(
      children: <Widget>[
        // Card(
        //       child: ListTile(
        //         title:Text("List Item 999") ,
        //       )
        //   ),
        // ListTile(
        //       title:Text("List Item 999") ),
        Icon(
          Icons.account_circle,
          size: 80,
        ),
        Icon(
          Icons.account_circle,
          size: 80,
        ),
        Icon(
          Icons.account_circle,
          size: 80,
        ),
      ],
    );
  }

  //TODO form 設計2(是否可以Container重複?)
  Widget _testobj3() {
    return Scaffold(
        body: Center(
            child: Container(
                child: Column(children: <Widget>[
      // Card(
      //     child: ListTile(
      //       title: Text("Codesinsider.com"),
      //     ),
      //     elevation: 3,
      //     shadowColor: Colors.green,
      //     shape:  OutlineInputBorder(
      //         borderRadius: BorderRadius.circular(10),
      //         borderSide: BorderSide(color: Colors.green, width: 1)
      //     ),
      //   ),

      Container(
        padding: EdgeInsets.fromLTRB(0, 160, 0, 0),
        //margin: EdgeInsets.fromLTRB(0, 120, 0, 0),
        height: 200,
        width: double.infinity,
        decoration: new BoxDecoration(
          color: Color.fromRGBO(192, 225, 170, 1.0),
        ),
        child: Column(
          children: [
            Text('AMC臉書系統',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    shadows: [
                      Shadow(
                          color: Colors.black54,
                          offset: Offset(1, 2),
                          blurRadius: 4)
                    ]
                    // foreground: Paint()
                    //   ..style = PaintingStyle.stroke
                    //   ..strokeWidth = 6
                    //   ..color = Colors.black
                    )),
          ],
        ),
        // child: Center(
        //   child: Text('ddddd'),
        // ),
      ),

      Container(
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.all(20.0),
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
        height: 300,
        width: 300,
        child: _tetform(),
      ),
      Container(
        color: Colors.cyan,
        //child: Text('ddddd'),
      )
    ]))));
  }

  Widget _testobj2() {
    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 236, 232, 1.0),
      body: Center(
          child: Container(
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.all(20.0),
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
        height: 300,
        width: 300,
        //child: _tetform(),
      )),

      // body: ListView(
      //     children:  [
      //
      //       Card(
      //           child: ListTile(
      //             title:Text("List Item 999") ,
      //           )
      //       ),
      //       Card(
      //         child: ListTile(
      //           title: Text("Codesinsider.com"),
      //         ),
      //         elevation: 3,
      //         shadowColor: Colors.green,
      //         shape:  OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(10),
      //             borderSide: BorderSide(color: Colors.green, width: 1)
      //         ),
      //       ),
      //       Card(
      //           child:TextField(
      //             decoration: InputDecoration(
      //                 hintText: "Username",
      //                 labelText: "Login",
      //                 prefixIcon: Icon(Icons.email,color: Colors.deepOrange,)
      //             ),
      //           )
      //       ),
      //
      //     ]
      //
      // ),
    );
  }

  Widget _testobj() {
    return ListView(children: [
      Card(
          child: ListTile(
        title: Text("List Item 122"),
      )),
    ]);
  }

  Widget _buildNumberTextField2() {
    return TextField(
      keyboardType: TextInputType.number,
      style: Theme.of(context).textTheme.headline4,
      decoration: InputDecoration(
        icon: const Icon(Icons.attach_money),
        labelText: 'Enter an integer:',
        errorText: _numberInputIsValid ? null : 'Please enter an integer!',
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      //onSubmitted: (val) => Fluttertoast.showToast(msg: 'You entered: ${int.parse(val)}'),
      onChanged: (String val) {
        final v = int.tryParse(val);
        debugPrint('parsed value = $v');
        if (v == null) {
          setState(() => _numberInputIsValid = false);
        } else {
          setState(() => _numberInputIsValid = true);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _testobj3();
  }
}

class _testview extends State<testview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter GridView"),
        ),
        body: ListView(
          shrinkWrap: true,
          children: const [
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
        ));
  }
}
