import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyLoadingWidget extends StatelessWidget {
  final bool? m_btnStopShow;
  final String? m_Strload;
  final Function? m_onPressed;
  const MyLoadingWidget({
    this.m_btnStopShow,
    this.m_Strload,
    this.m_onPressed,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border.all(
            width: 1,
            color: Colors.redAccent,
          ),
        ),
        //height: 500,
        child: myContain(
          m_heght: 300,
          m_boxDecoration: new BoxDecoration(
              //color: Colors.lightBlue,
              ),
          m_child: Column(
            children: [
              SpinKitChasingDots(
                color: Colors.blue,
                size: 50.0,
              ),
              SizedBox(
                height: 10,
              ),
              myText(
                m_text: m_Strload ?? "loading",
                m_fontsize: 18,
                m_color: Colors.blue,
              ),
              // Text(m_Strload ?? "loading"),
              //' onPressed: m_onPressed != null ? () => m_onPressed!() : null,'
              Visibility(
                visible: m_btnStopShow ?? false,
                child: OutlinedButton(
                    onPressed: () {
                      // do something
                    },
                    child: myButton(
                        m_child: Text('stop'),
                        m_onPressed:
                            m_onPressed != null ? () => m_onPressed!() : null)),
              )
            ],
          ),
        ));
  }
}

class myContain extends StatelessWidget {
  final Widget? m_child;
  final double? m_heght;
  final double? m_weight;
  final EdgeInsets? m_margin;
  final EdgeInsets? m_padding;
  final BoxDecoration? m_boxDecoration;
  final Alignment? m_Alignment;
  final BoxConstraints? m_Constraints;

  const myContain({
    this.m_heght,
    this.m_weight,
    this.m_margin,
    this.m_padding,
    this.m_child,
    this.m_boxDecoration,
    this.m_Alignment,
    this.m_Constraints,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: m_Alignment,
      decoration: m_boxDecoration,
      constraints: m_Constraints,
      width: m_weight,
      height: m_heght,
      margin: m_margin,
      padding: m_padding,
      child: m_child,
    );
  }
}

class myIconButton extends StatelessWidget {
  final String m_text;
  final Widget m_Icon;
  final Function? m_onPressed;
  final Color? m_Backcolor;

  const myIconButton({
    required this.m_text, // non-nullable and required
    required this.m_Icon,
    this.m_onPressed,
    this.m_Backcolor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      //
      onPressed: m_onPressed != null ? () => m_onPressed!() : null,
      style: ElevatedButton.styleFrom(primary: m_Backcolor),
      icon: m_Icon,
      label: Text(m_text), // <-- Text
    );
  }
}

class mypopButton extends StatelessWidget {
  final Color? m_backcolor;
  final Color? m_fontcolor;
  final double? m_with;
  final double? m_height;
  final Function? m_onPressed;
  final Widget m_child;
  const mypopButton({
    required this.m_child,
    this.m_onPressed,
    this.m_with = 100,
    this.m_height = 40,
    this.m_backcolor = Colors.blue,
    this.m_fontcolor = Colors.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          m_onPressed!();
        },
        child: myContain(
          m_heght: m_height,
          m_Alignment: Alignment.center,
          m_boxDecoration: new BoxDecoration(),
          m_child: myContain(
              m_heght: m_height,
              m_weight: m_with,
              m_boxDecoration: BoxDecoration(
                color: m_backcolor,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(3.0, 3.0), //陰影y軸偏移量
                      blurRadius: 2, //陰影模糊程度
                      spreadRadius: 0 //陰影擴散程度
                      )
                ],
              ),
              m_child: Align(alignment: Alignment.center, child: m_child)),
        ));
  }
}

class myButton extends StatelessWidget {
  final Color m_color;
  final Widget m_child;
  final Size? m_minimumSize;
  final Function? m_onPressed;
  const myButton({
    required this.m_child,
    this.m_onPressed,
    this.m_minimumSize,
    this.m_color = Colors.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: m_minimumSize,
        backgroundColor: m_color, //<-- SEE HERE
      ),
      child: m_child,
      onPressed: m_onPressed != null ? () => m_onPressed!() : null,
    );
  }
}

class myText extends StatelessWidget {
  final String m_text;
  final Color? m_color;
  final FontWeight? m_fountWeight;
  final double? m_letterSpacing;
  final Function(bool)? onFocusChange; // nullable and optional
  final double? m_fontsize;
  const myText(
      {Key? key,
      required this.m_text, // non-nullable and required
      this.m_color, // non-nullable but optional with a default value
      this.onFocusChange, // nullable and optional
      this.m_fontsize,
      this.m_fountWeight,
      this.m_letterSpacing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      m_text,
      style: TextStyle(
        color: m_color,
        fontWeight: m_fountWeight,
        fontSize: m_fontsize,
        letterSpacing: m_letterSpacing,
      ),
    );
  }
}
