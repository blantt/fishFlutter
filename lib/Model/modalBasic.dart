import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class classUserInfo {
  SharedPreferences? _prefs; // 使用可空類型來表示可能為 null 的情況

  // 建構子，初始化 SharedPreferences
  classUserInfo() {
    _initPrefs();
  }

  // 初始化 SharedPreferences
  void _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void set_UserName(String value) async {
    await _prefs?.setString('UserName', value);
  }

  Future<String?> get_UserName() async {
    String? sss = _prefs?.getString('UserName');
    return sss;
  }

  void set_FullName(String value) async {
    await _prefs?.setString('FullName', value);
  }

  Future<String?> get_FullName() async {
    String? sss = _prefs?.getString('FullName');
    return sss;
  }

  void set_islogin(bool value) async {
    await _prefs?.setBool('islogin', value);
  }

  Future<bool?> get_islogin() async {
    bool? sss = _prefs?.getBool('islogin');
    return sss;
  }
}

class Modal_Person_basic {
  Modal_Person_basic({
    required this.UserName,
    required this.FullName,
    required this.RosterN,
    required this.ClassID,
    required this.SHH,
    required this.EHH,
    required this.SleepHH1,
    required this.SleepHH2,
    required this.UserAgent,
    required this.UserAgentN,
    required this.UserAgent2,
    required this.UserAgent2N,
    required this.UserSee,
    required this.UserSeeN,
    required this.UserSee2,
    required this.UserSee2N,
    required this.UserBoss,
    required this.UserBossN,
  });
  String UserName;
  String FullName;
  String RosterN;
  String ClassID;
  String SHH;
  String EHH;
  String SleepHH1;
  String SleepHH2;
  String UserAgent;
  String UserAgentN;
  String UserAgent2;
  String UserAgent2N;
  String UserSee;
  String UserSeeN;
  String UserSee2;
  String UserSee2N;
  String UserBoss;
  String UserBossN;

  factory Modal_Person_basic.fromJson(Map<String, dynamic> json) =>
      Modal_Person_basic(
        UserName: json["UserName"] ?? '',
        FullName: json["FullName"] ?? '',
        RosterN: json["RosterN"] ?? '',
        ClassID: json["ClassID"] ?? '',
        SHH: json["SHH"] ?? '',
        EHH: json["EHH"] ?? '',
        SleepHH1: json["SleepHH1"] ?? '',
        SleepHH2: json["SleepHH2"] ?? '',
        UserAgent: json["UserAgent"] ?? '',
        UserAgentN: json["UserAgentN"] ?? '',
        UserAgent2: json["UserAgent2"] ?? '',
        UserAgent2N: json["UserAgent2N"] ?? '',
        UserSee: json["UserSee"] ?? '',
        UserSee2: json["UserSee2"] ?? '',
        UserSeeN: json["UserSeeN"] ?? '',
        UserSee2N: json["UserSee2N"] ?? '',
        UserBoss: json["UserBoss"] ?? '',
        UserBossN: json["UserBossN"] ?? '',
      );
  Map<String, dynamic> toJson() => {
        "UserName": UserName,
        "FullName": FullName,
        "RosterN": RosterN,
        "ClassID": ClassID,
        "SHH": SHH,
        "EHH": EHH,
        "SleepHH1": SleepHH1,
        "SleepHH2": SleepHH2,
        "UserAgent": UserAgent,
        "UserAgent2": UserAgent2,
        "UserAgentN": UserAgentN,
        "UserAgent2N": UserAgent2N,
        "UserSee": UserSee,
        "UserSee2": UserSee2,
        "UserSeeN": UserSeeN,
        "UserSee2N": UserSee2N,
        "UserBoss": UserBoss,
        "UserBossN": UserBossN,
      };
}

class Modal_basic {
  Modal_basic({
    required this.name1,
    required this.name2,
  });

  String name1;
  String name2;

  factory Modal_basic.fromJson(Map<String, dynamic> json) => Modal_basic(
        name1: json["name1"] ?? '',
        name2: json["name2"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name1": name1,
        "name2": name2,
      };
}

class Modal_basic_LeaveTime {
  Modal_basic_LeaveTime({
    required this.BatchID,
    required this.STime,
    required this.ETime,
    required this.STime2,
    required this.ETime2,
    required this.DetailClassID,
  });

  String BatchID;
  String STime;
  String ETime;
  String STime2;
  String ETime2;
  String DetailClassID;

  factory Modal_basic_LeaveTime.fromJson(Map<String, dynamic> json) =>
      Modal_basic_LeaveTime(
        BatchID: json["BatchID"] ?? '',
        STime: json["STime"] ?? '',
        ETime: json["ETime"] ?? '',
        STime2: json["STime2"] ?? '',
        ETime2: json["ETime2"] ?? '',
        DetailClassID: json["DetailClassID"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "BatchID": BatchID,
        "STime": STime,
        "ETime": ETime,
        "STime": STime2,
        "ETime": ETime2,
        "DetailClassID": DetailClassID,
      };
}
