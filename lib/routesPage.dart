import 'package:flutter/material.dart';
import 'dart:io';
import 'TryMenu.dart';
import 'page/JobLeaveSch.dart';
import 'package:blantt_love_test/selectDate.dart';
import 'package:blantt_love_test/page/JobLeave.dart';

const page1 = "/testButton";
const page2 = "/selectDate";
const page3 = "/Jobleave";

var RoutePath = {
  "$page2": (context) => selectDate(),
  "$page3": (context) => Jobleave('')
};
