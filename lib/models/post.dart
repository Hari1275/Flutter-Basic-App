import 'dart:convert';

List<Posts> postsFromJson(String str) =>
    List<Posts>.from(json.decode(str).map((x) => Posts.fromJson(x)));

String postsToJson(List<Posts> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Posts {
  Posts({
    required this.userId,
    required this.title,
    this.id,
    this.body,
  });

  int userId;
  String title;
  String? body;
  int? id;

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        userId: json["userId"],
        title: json["title"],
        id: json["id"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "title": title,
        "id": id,
        "body": body,
      };
}
