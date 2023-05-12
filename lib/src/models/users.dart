// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

User userFromMap(str) => User.fromMap(str);

String userToMap(User data) => json.encode(data.toMap());

class User {
  User({
    this.id,
    this.email,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.gender,
    this.interest,
    this.name,
    this.topics,
    this.images,
  });

  String? id;
  String? email;
  String? password;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? gender;
  String? interest;
  String? name;
  List<String>? topics;
  List<String>? images;

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["_id"],
        email: json["email"],
        password: json["password"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        gender: json["gender"],
        interest: json["interest"],
        name: json["name"],
        topics: List<String>.from(json["topics"].map((x) => x)),
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "email": email,
        "password": password,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "gender": gender,
        "interest": interest,
        "name": name,
        "topics": List<dynamic>.from(topics!.map((x) => x)),
        "images": List<dynamic>.from(images!.map((x) => x)),
      };
}
