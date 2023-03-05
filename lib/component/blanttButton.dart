import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

//=========

class myContain extends StatelessWidget {
  final Widget? m_child;
  final double? m_heght;
  final double? m_weight;
  final EdgeInsets? m_margin;
  final EdgeInsets? m_padding;
  final BoxDecoration? m_boxDecoration;
  final Alignment? m_Alignment;

  const myContain({
    this.m_heght,
    this.m_weight,
    this.m_margin,
    this.m_padding,
    this.m_child,
    this.m_boxDecoration,
    this.m_Alignment,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: m_Alignment,
      decoration: m_boxDecoration,
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
  final Function m_onPressed;
  final Color? m_Backcolor;

  const myIconButton({
    required this.m_text, // non-nullable and required
    required this.m_Icon,
    required this.m_onPressed,
    this.m_Backcolor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        m_onPressed();
      },
      style: ElevatedButton.styleFrom(primary: m_Backcolor),
      icon: m_Icon,
      label: Text(m_text), // <-- Text
    );
  }
}

class myButton extends StatelessWidget {
  final Color m_color;
  final Widget m_child;
  final Size? m_minimumSize;
  final Function m_onPressed;
  const myButton({
    required this.m_child,
    required this.m_onPressed,
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
      onPressed: () {
        m_onPressed();
      },
    );
  }
}

class myText extends StatelessWidget {
  final String m_text;
  final Color? m_color;
  final FontWeight? m_fountWeight;
  final Function(bool)? onFocusChange; // nullable and optional
  final double? m_fontsize;
  const myText(
      {Key? key,
      required this.m_text, // non-nullable and required
      this.m_color, // non-nullable but optional with a default value
      this.onFocusChange, // nullable and optional
      this.m_fontsize,
      this.m_fountWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      m_text,
      style: TextStyle(
          color: m_color, fontWeight: m_fountWeight, fontSize: m_fontsize),
    );
  }
}