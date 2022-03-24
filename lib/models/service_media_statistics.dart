import 'dart:convert';

import 'package:social_manager/models/service.dart';

class ServiceMediaStatistics {
  ServiceMediaStatistics({
    required this.media,
    required this.count,
    required this.saved,
  });

  final MediaService media;
  final int count;
  final int saved;

  factory ServiceMediaStatistics.fromRawJson(String str) =>
      ServiceMediaStatistics.fromJson(json.decode(str));
  static List<ServiceMediaStatistics> listFromJson(List json) =>
      json.map((e) => ServiceMediaStatistics.fromJson(e)).toList();
  String toRawJson() => json.encode(toJson());

  factory ServiceMediaStatistics.fromJson(Map<String, dynamic> json) =>
      ServiceMediaStatistics(
        media: MediaService.fromJson(json["media"]),
        count: json["count"],
        saved: json["saved"],
      );

  Map<String, dynamic> toJson() => {
        "media": media.toJson(),
        "count": count,
        "saved": saved,
      };
}
