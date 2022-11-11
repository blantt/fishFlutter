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
    ClassTypeN: '',
    Reason: '',
    ReturnReason: '',
    MStatusN: '',
    UserAgent: '',
    UserAgent2: '',
    UserAgentN: '',
    UserAgent2N: '',
    UserSee: '',
    UserSee2: '',
    UserSeeN: '',
    UserSee2N: '',
  )
];

List<Modal_PsersonSch> list_Modal_PsersonSch = [
  Modal_PsersonSch(
    name1: '',
    name2: '',
  )
];

class Modal_PsersonSch {
  Modal_PsersonSch({
    required this.name1,
    required this.name2,
  });
  String name1;
  String name2;

  factory Modal_PsersonSch.fromJson(Map<String, dynamic> json) =>
      Modal_PsersonSch(
        name1: json["name1"] ?? '',
        name2: json["name2"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name1": name1,
        "name2": name2,
      };
}

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
    required this.ClassTypeN,
    required this.Reason,
    required this.ReturnReason,
    required this.MStatusN,
    required this.UserAgent,
    required this.UserAgent2,
    required this.UserAgentN,
    required this.UserAgent2N,
    required this.UserSee,
    required this.UserSee2,
    required this.UserSeeN,
    required this.UserSee2N,
  });

  String BatchID;
  String UserName;
  String UserNameN;
  String LeaveTypeN;
  String DeptID;
  String LeaveType;
  String ClassType;
  String ClassTypeN;
  String Reason;
  String ReturnReason;
  String MStatusN;
  String UserAgent;
  String UserAgent2;
  String UserAgentN;
  String UserAgent2N;
  String UserSee;
  String UserSee2;
  String UserSeeN;
  String UserSee2N;

  factory Modal_LeaveSch2.fromJson(Map<String, dynamic> json) =>
      Modal_LeaveSch2(
        BatchID: json["BatchID"] ?? '',
        UserName: json["UserName"] ?? '',
        UserNameN: json["UserNameN"] ?? '',
        LeaveTypeN: json["LeaveTypeN"] ?? '',
        DeptID: json["DeptID"] ?? '',
        LeaveType: json["LeaveType"] ?? '',
        ClassType: json["ClassType"] ?? '',
        ClassTypeN: json["ClassTypeN"] ?? '',
        Reason: json["Reason"] ?? '',
        ReturnReason: json["ReturnReason"] ?? '',
        MStatusN: json["MStatusN"] ?? '',
        UserAgent: json["UserAgent"] ?? '',
        UserAgent2: json["UserAgent2"] ?? '',
        UserAgentN: json["UserAgentN"] ?? '',
        UserAgent2N: json["UserAgent2N"] ?? '',
        UserSee: json["UserSee"] ?? '',
        UserSee2: json["UserSee2"] ?? '',
        UserSeeN: json["UserSeeN"] ?? '',
        UserSee2N: json["UserSee2N"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "BatchID": BatchID,
        "UserName": UserName,
        "UserNameN": UserNameN,
        "LeaveTypeN": LeaveTypeN,
        "DeptID": DeptID,
        "LeaveType": LeaveType,
        "ClassType": ClassType,
        "ClassTypeN": ClassTypeN,
        "Reason": Reason,
        "ReturnReason": ReturnReason,
        "MStatusN": MStatusN,
        "UserAgent": UserAgent,
        "UserAgent2": UserAgent2,
        "UserAgentN": UserAgentN,
        "UserAgent2N": UserAgent2N,
        "UserSee": UserSee,
        "UserSee2": UserSee2,
        "UserSeeN": UserSeeN,
        "UserSee2N": UserSee2N,
      };
}
