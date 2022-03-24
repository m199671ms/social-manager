import 'dart:convert';

import 'package:social_manager/models/service.dart';

class User {
  User({
    required this.phone,
    required this.name,
    required this.password,
    required this.services,
  });

  final String phone;
  final String name;
  final String password;
  final List<MediaService> services;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        phone: json["phone"],
        name: json["name"],
        password: json["password"],
        services: List<MediaService>.from(
            json["services"].map((x) => MediaService.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "name": name,
        "password": password,
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
      };
}
