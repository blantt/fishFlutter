import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../component/blanttButton.dart';

class doorSelectTime extends StatefulWidget {
  String name1;
  String name2;
  doorSelectTime({required this.name1, required this.name2});
  // doorSelectTime(String time1, String Time2);

  @override
  doorSelectTime2 createState() => doorSelectTime2();
}

class doorSelectTime2 extends State<doorSelectTime> {
  void initState() {
    super.initState();

    print(widget.name1);
    if (widget.name1 != '') {
      _date = DateTime.parse(widget.name1);
      _date2 = DateTime.parse(widget.name2);
    }
    // dynamic args = ModalRoute.of(context)!.settings.arguments
    // dynamic args = ModalRoute.of(context)!.settings.arguments;

    // final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    //final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
  }

  Color m_btncolor = Color.fromRGBO(9, 111, 148, 1.0);
  DateTime _date = DateTime(1911, 11, 10, 7, 15);
  DateTime _date2 = DateTime(1911, 11, 11, 12, 15);
  void _selectTime(int itype) async {
    print(widget.name1);
    DateTime tempDate;
    tempDate = DateTime.now();
    if (itype == 0) {
      tempDate = _date;
    }
    if (itype == 1) {
      tempDate = _date2;
    }

    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: tempDate.hour, minute: tempDate.minute),
    );
    if (newTime != null) {
      setState(() {
        TimeOfDay Selecttime;
        Selecttime = newTime;
        if (itype == 0) {
          _date = DateTime(tempDate.year, tempDate.month, tempDate.day,
              Selecttime.hour, Selecttime.minute);
        }
        if (itype == 1) {
          _date2 = DateTime(tempDate.year, tempDate.month, tempDate.day,
              Selecttime.hour, Selecttime.minute);
        }
      });
    }
  }

  //TODO select Date
  void _selectDate(int itype) async {
    DateTime tempDate;
    tempDate = DateTime.now();
    DateTime maxDate;
    DateTime minDate;
    minDate = DateTime(DateTime.now().year - 10, 1);
    maxDate = DateTime(DateTime.now().year + 10, 1);
    if (itype == 0) {
      tempDate = _date;
    }
    if (itype == 1) {
      tempDate = _date2;
    }

    if (tempDate.year == 1911) {
      //如果是新進來空,ui上是空值,預設帶今天
      tempDate = DateTime.now();
    }

    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: tempDate,
      firstDate: minDate,
      lastDate: maxDate,
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        DateTime selectdate;
        selectdate = newDate;
        //   _date = newDate;
        // formattedDate = DateFormat('yyyy-MM-dd').format(_date);
        if (itype == 0) {
          _date = DateTime(selectdate.year, selectdate.month, selectdate.day,
              tempDate.hour, tempDate.minute);
        }
        if (itype == 1) {
          _date2 = DateTime(selectdate.year, selectdate.month, selectdate.day,
              tempDate.hour, tempDate.minute);
        }
      });
    }
  }

  Widget fomr1() {
    return Container(
      alignment: Alignment.center,
      //color: Colors.greenAccent,
      height: 400,
      child: Column(children: [
        Container(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                myIconButton(
                    m_text: '取起始日期',
                    m_Icon: new Image.asset(
                      "assets/images/date1.png",
                      width: 30,
                    ),
                    m_Backcolor: m_btncolor,
                    m_onPressed: () {
                      _selectDate(0);
                    }),
                SizedBox(
                  width: 5,
                ),
                myIconButton(
                    m_text: '取起始時間',
                    m_Icon: new Image.asset(
                      "assets/images/date2.png",
                      width: 30,
                    ),
                    m_Backcolor: m_btncolor,
                    m_onPressed: () {
                      _selectTime(0);
                    })
              ],
            )),
        Row(
          children: [
            Expanded(
              child: classFild(hh: _date),
            )
          ],
        ),

        //----截止時間==============================
        Container(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                myIconButton(
                    m_text: '取截止日期',
                    m_Icon: new Image.asset(
                      "assets/images/date1.png",
                      width: 30,
                    ),
                    m_Backcolor: m_btncolor,
                    m_onPressed: () {
                      _selectDate(1);
                    }),
                SizedBox(
                  width: 5,
                ),
                myIconButton(
                    m_text: '取截止時間',
                    m_Icon: new Image.asset(
                      "assets/images/date2.png",
                      width: 30,
                    ),
                    m_Backcolor: m_btncolor,
                    m_onPressed: () {
                      _selectTime(1);
                    }),
              ],
            )),
        Row(
          children: [
            Expanded(
              child: classFild(hh: _date2),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: myContain(
                m_heght: 50,
                m_Alignment: Alignment.center,
                m_child: myButton(
                    m_minimumSize: Size(100, 40),
                    m_color: Color.fromRGBO(225, 138, 49, 1.0),
                    m_onPressed: () {
                      //TODO tiem 回傳值
                      Navigator.pop(
                          context,
                          DateFormat('yyyy-MM-dd HH:mm').format(_date) +
                              '@' +
                              DateFormat('yyyy-MM-dd HH:mm').format(_date2));
                    },
                    m_child: myText(
                      m_text: '取回',
                      m_color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    // dynamic args = ModalRoute.of(context)!.settings.arguments;
    // name1 = args["name1"];
    // name2 = args["name2"];
    // if (name1 != '') {
    //   _date = DateTime.parse(name1);
    //   _date2 = DateTime.parse(name2);
    // }

    print('kkk');
    return Scaffold(
      appBar: AppBar(
        //leading: Icon(Icons.arrow_back),
        backgroundColor: Color.fromRGBO(56, 163, 210, 1.0),
        title: Text('時段選單'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: fomr1(),
        color: Color.fromRGBO(221, 232, 202, 1.0),
      ),
    );
  }
}

String message(bool isValid) {
  return 1 == 1 ? 'This is valid' : 'This is not valid';
}

void dd() {
  BoxDecoration bb = BoxDecoration();
  BoxDecoration? cc;
  final Widget dd;
  bool isReturningCustomer;

  BorderRadius kk;
}

class classFild extends StatelessWidget {
  DateTime mytime = DateTime.now();

  classFild({required DateTime hh}) {
    this.mytime = hh;
  }

  @override
  Widget build(BuildContext context) {
    String tempdate = "";
    if (this.mytime.year == 1911) {
      tempdate = "";
    } else {
      tempdate = DateFormat('yyyy-MM-dd HH:mm').format(mytime);
    }
    return Container(
      height: 40,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
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
      child: new Text(
        tempdate,
        //DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
        style: new TextStyle(
            fontWeight: FontWeight.w400, color: Colors.indigo, fontSize: 18),
      ),
    );
  }
}

class KBigButton extends StatelessWidget {
  String text = "";

  KBigButton({String gggggg = ""}) {
    this.text = gggggg;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      padding: EdgeInsets.all(0),
      width: MediaQuery.of(context).size.width - 20,
      height: 48,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, // ⚠️ `textColor` → `foregroundColor`
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
        ),
        child: Text(this.text),
      ),
    );
  }
}

Widget ttt(BuildContext context) {
  return TextInputWithIcon(iconPath: "");
}

class TextInputWithIcon extends StatelessWidget {
  final String iconPath;
  final String placeHolder;
  final Function(bool)? onFocusChange; // nullable and optional

  const TextInputWithIcon({
    Key? key,
    required this.iconPath, // non-nullable and required
    this.placeHolder = "", // non-nullable but optional with a default value
    this.onFocusChange, // nullable and optional
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        padding: EdgeInsets.all(0),
        width: MediaQuery.of(context).size.width - 20,
        height: 48,
        child: Text('ddd'));
  }
}
