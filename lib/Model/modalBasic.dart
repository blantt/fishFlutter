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

// public string BatchID { get; set; }
// public string STime { get; set; }
// public string ETime { get; set; }
// public string STime2 { get; set; }
// public string ETime2 { get; set; }
// public string DetailClassID { get; set; }
// public string DetailClassName { get; set; }
// public int LeaveHour { get; set; }
class Modal_basic_LeaveTime {
  Modal_basic_LeaveTime({
    required this.BatchID,
    required this.STime,
    required this.ETime,
    required this.DetailClassID,
  });

  String BatchID;
  String STime;
  String ETime;
  String DetailClassID;

  factory Modal_basic_LeaveTime.fromJson(Map<String, dynamic> json) =>
      Modal_basic_LeaveTime(
        BatchID: json["BatchID"] ?? '',
        STime: json["STime"] ?? '',
        ETime: json["ETime"] ?? '',
        DetailClassID: json["DetailClassID"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "BatchID": BatchID,
        "STime": STime,
        "ETime": ETime,
        "DetailClassID": DetailClassID,
      };
}
