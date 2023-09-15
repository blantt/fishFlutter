import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Modal_Person_basic myUserBasic = Modal_Person_basic(
    UserName: '',
    FullName: '',
    RosterN: '',
    ClassID: '',
    ClassName: '',
    SHH: '',
    EHH: '',
    SleepHH1: '',
    SleepHH2: '',
    UserAgent: '',
    UserAgentN: '',
    UserAgent2: '',
    UserAgent2N: '',
    UserSee: '',
    UserSeeN: '',
    UserSee2: '',
    UserSee2N: '',
    UserBoss: '',
    UserBossN: '');

class classUserInfo {
  SharedPreferences? _prefs; // 使用可空類型來表示可能為 null 的情況

  // 建構子，初始化 SharedPreferences
  classUserInfo() {
    _initPrefs();
  }

  // 初始化 SharedPreferences
  void _initPrefs() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      // 在這裡處理異常，你可以記錄錯誤信息或者執行其他適當的處理
      print('初始化SharedPreferences時出現異常: $e');
    }

    String tt;
  }

  void ccc() async {
    String? sss = _prefs?.getString('UserName');
  }

  void set_test(String value) async {
    await _prefs?.setString('UserName', value);
  }

  Future<String?> get_test() async {
    String? sss = _prefs?.getString('UserName');
    return sss;
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

  void set_ClassID(String value) async {
    await _prefs?.setString('ClassID', value);
  }

  Future<String?> get_ClassID() async {
    String? sss = _prefs?.getString('ClassID');
    return sss;
  }

  void set_ClassName(String value) async {
    await _prefs?.setString('ClassName', value);
  }

  Future<String?> get_ClassName() async {
    String? sss = _prefs?.getString('ClassName');
    return sss;
  }

  void set_UserAgent(String value) async {
    await _prefs?.setString('UserAgent', value);
  }

  Future<String?> get_UserAgent() async {
    String? sss = _prefs?.getString('UserAgent');
    return sss;
  }

  void set_UserAgent2(String value) async {
    await _prefs?.setString('UserAgent2', value);
  }

  Future<String?> get_UserAgent2() async {
    String? sss = _prefs?.getString('UserAgent2');
    return sss;
  }

  void set_UserAgentN(String value) async {
    await _prefs?.setString('UserAgentN', value);
  }

  Future<String?> get_UserAgentN() async {
    String? sss = _prefs?.getString('UserAgentN');
    return sss;
  }

  void set_UserAgent2N(String value) async {
    await _prefs?.setString('UserAgent2N', value);
  }

  Future<String?> get_UserAgent2N() async {
    String? sss = _prefs?.getString('UserAgent2N');
    return sss;
  }

  void set_UserSee(String value) async {
    await _prefs?.setString('UserSee', value);
  }

  void set_UserSeeN(String value) async {
    await _prefs?.setString('UserSeeN', value);
  }

  Future<String?> get_UserSee() async {
    String? sss = _prefs?.getString('UserSee');
    return sss;
  }

  Future<String?> get_UserSeeN() async {
    String? sss = _prefs?.getString('UserSeeN');
    return sss;
  }

  void set_UserSee2(String value) async {
    await _prefs?.setString('UserSee2', value);
  }

  Future<String?> get_UserSee2() async {
    String? sss = _prefs?.getString('UserSee2');
    return sss;
  }

  void set_UserSee2N(String value) async {
    await _prefs?.setString('UserSee2N', value);
  }

  Future<String?> get_UserSee2N() async {
    String? sss = _prefs?.getString('UserSee2N');
    return sss;
  }
}

class Modal_Person_basic {
  Modal_Person_basic({
    required this.UserName,
    required this.FullName,
    required this.RosterN,
    required this.ClassID,
    required this.ClassName,
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
  String ClassName;
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
        ClassName: json["ClassName"] ?? '',
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
        "ClassName": ClassName,
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
