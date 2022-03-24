import 'dart:convert';

import 'package:social_manager/models/service.dart';

class ServiceTab {
  ServiceTab({
    required this.id,
    required this.service,
    required this.url,
  });

  @override
  operator ==(Object other) => other is ServiceTab && other.id == id;
  final String id;
  final MediaService service;
  final Uri url;

  factory ServiceTab.fromRawJson(String str) =>
      ServiceTab.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServiceTab.fromJson(Map<String, dynamic> json) => ServiceTab(
        id: json["id"],
        service: MediaService.fromJson(json["service"]),
        url: Uri.parse(json["url"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service": service.toJson(),
        "url": url,
      };

  @override
  int get hashCode => id.hashCode;
}
