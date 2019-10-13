// To parse this JSON data, do
//
//     final client = clientFromJson(jsonString);

import 'dart:convert';

User clientFromJson(String str) => User.fromJson(json.decode(str));

String clientToJson(User data) => json.encode(data.toJson());

class User {
  String id;
  String password;

  User({
    this.id,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "password": password,
  };
}
