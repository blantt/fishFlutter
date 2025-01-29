
String m_url_wpBasic =
    "https://wordpress-1399006-5191588.cloudwaysapps.com";
    //本地端http://10.0.2.2:80/fish2
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
