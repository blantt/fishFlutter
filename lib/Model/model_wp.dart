class Modal_wp {
  Modal_wp({
    required this.id,
    required this.title,
    required this.content,
  });

  int id;
  String title;
  String content;
  factory Modal_wp.fromJson(Map<String, dynamic> json) => Modal_wp(
        id: json["id"] ?? '',
        title: json["title"] ?? '',
        content: json["content"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
      };
}
