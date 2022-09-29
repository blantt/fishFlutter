import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

//假單查詢
List<Modal_LeaveSch2> list_Modal_LeaveSch2 = [
  Modal_LeaveSch2(
      BatchID: '',
      UserName: '',
      UserNameN: '',
      LeaveTypeN: '',
      DeptID: '',
      LeaveType: '',
      ClassType: '',
      Reason: '',
      ReturnReason: '',
      MStatusN: '')
];

//Modal_LeaveSch 假單查詢
class Modal_LeaveSch2 {
  Modal_LeaveSch2({
    required this.BatchID,
    required this.UserName,
    required this.UserNameN,
    required this.LeaveTypeN,
    required this.DeptID,
    required this.LeaveType,
    required this.ClassType,
    required this.Reason,
    required this.ReturnReason,
    required this.MStatusN,
  });

  String BatchID;
  String UserName;
  String UserNameN;
  String LeaveTypeN;
  String DeptID;
  String LeaveType;
  String ClassType;
  String Reason;
  String ReturnReason;
  String MStatusN;

  factory Modal_LeaveSch2.fromJson(Map<String, dynamic> json) =>
      Modal_LeaveSch2(
        BatchID: json["BatchID"] ?? '',
        UserName: json["UserName"] ?? '',
        UserNameN: json["UserNameN"] ?? '',
        LeaveTypeN: json["LeaveTypeN"] ?? '',
        DeptID: json["DeptID"] ?? '',
        LeaveType: json["LeaveType"] ?? '',
        ClassType: json["ClassType"] ?? '',
        Reason: json["Reason"] ?? '',
        ReturnReason: json["ReturnReason"] ?? '',
        MStatusN: json["MStatusN"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "BatchID": BatchID,
        "UserName": UserName,
        "UserNameN": UserNameN,
        "LeaveTypeN": LeaveTypeN,
        "DeptID": DeptID,
        "LeaveType": LeaveType,
        "ClassType": ClassType,
        "Reason": Reason,
        "ReturnReason": ReturnReason,
        "MStatusN": MStatusN,
      };
}
