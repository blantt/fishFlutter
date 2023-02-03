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
