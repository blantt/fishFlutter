import 'package:flutter/material.dart';
import 'dart:io';
import 'TryMenu.dart';
import 'package:blantt_love_test/testButton.dart';
import 'ListView.dart';
import 'package:blantt_love_test/selectDate.dart';
import 'package:blantt_love_test/JobLeave.dart';

const page1 = "/testButton";
const page2 = "/selectDate";
const page3 = "/Jobleave";

var RoutePath = {
  "$page1": (context) => testButton(),
  "$page2": (context) => selectDate(),
  "$page3": (context) => Jobleave()
};
