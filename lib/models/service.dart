// To parse this JSON data, do
//
//     final mediaService = mediaServiceFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:social_manager/utils/store.dart';

class MediaService {
  MediaService({
    required this.id,
    required this.namesMap,
    required this.domain,
    required this.icon,
    required this.iconFont,
    required this.iconPackage,
    required this.iconColor,
    required this.homeUrl,
  });
  @override
  // ignore: hash_and_equals
  operator ==(Object other) => other is MediaService && id == other.id;

  String get name => namesMap[Store.locale.languageCode]!;

  final int id;
  final Map<String, String> namesMap;
  final String domain;
  final int icon;
  final String iconFont;
  final String iconPackage;
  final Color iconColor;
  final Uri homeUrl;

  MediaService copyWith({
    int? id,
    Map<String, String>? namesMap,
    String? domain,
    int? icon,
    String? iconFont,
    String? iconPackage,
    Color? iconColor,
    Uri? homeUrl,
  }) =>
      MediaService(
        id: id ?? this.id,
        namesMap: namesMap ?? this.namesMap,
        domain: domain ?? this.domain,
        icon: icon ?? this.icon,
        iconFont: iconFont ?? this.iconFont,
        iconPackage: iconPackage ?? this.iconPackage,
        iconColor: iconColor ?? this.iconColor,
        homeUrl: homeUrl ?? this.homeUrl,
      );

  factory MediaService.fromRawJson(String str) =>
      MediaService.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MediaService.fromJson(Map<String, dynamic> json) => MediaService(
        id: json["id"],
        namesMap: Map<String, String>.from(json["name"]),
        domain: json["domain"],
        icon: json["icon"],
        iconFont: json["icon_font"],
        iconPackage: json["icon_package"],
        iconColor: Color(int.parse(json["icon_color"])),
        homeUrl: Uri.parse(json["home_url"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": namesMap,
        "domain": domain,
        "icon": icon,
        "icon_font": iconFont,
        "icon_package": iconPackage,
        "icon_color": iconColor.value.toString(),
        "home_url": homeUrl.toString(),
      };
}
