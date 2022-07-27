import 'package:flutter/material.dart';

//參考 https://tw-hkt.blogspot.com/2019/08/flutter-image.html
void main() {
  runApp(Myimage());
}

class Myimage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      // appBar: AppBar(
      //   title: Text('HKT線上教室'),
      // ),
      body: HomePage(),
    ));
  }
}

class Myimage2 extends StatelessWidget {
  const Myimage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return aaa(context);
  }
}

Widget aaa(BuildContext context) {
  return Align(
    alignment: Alignment.topCenter,
    child: Container(
      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: Image.asset(
        'assets/images/fblogo2.png',
        fit: BoxFit.fill,
      ),
      width: 300.0,
      height: 180.0,
    ),

    // child: Center(child: Image.asset('assets/images/fblogo2.png')),
  );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
        child: Image.asset(
          'assets/images/fblogo2.png',
          fit: BoxFit.fill,
        ),
        width: 300.0,
        height: 180.0,
      ),

      // child: Center(child: Image.asset('assets/images/fblogo2.png')),
    );
  }
}
