import 'dart:convert';

class History {
  History({
    required this.id,
    required this.link,
    required this.userId,
    required this.mediaId,
    required this.visitedAt,
  });

  @override
  operator ==(Object other) => other is History && other.id == id;
  final int id;
  final String link;
  final String userId;
  final int mediaId;
  final DateTime visitedAt;

  History copyWith({
    int? id,
    String? link,
    String? userId,
    int? mediaId,
    DateTime? visitedAt,
  }) =>
      History(
        id: id ?? this.id,
        link: link ?? this.link,
        userId: userId ?? this.userId,
        mediaId: mediaId ?? this.mediaId,
        visitedAt: visitedAt ?? this.visitedAt,
      );

  factory History.fromRawJson(String str) => History.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        link: json["link"],
        userId: json["user_id"],
        mediaId: json["media_id"],
        visitedAt: DateTime.parse(json["visited_at"]),
      );

  static List<History> listFromJson(List json) =>
      json.map((e) => History.fromJson(e)).toList();

  Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
        "user_id": userId,
        "media_id": mediaId,
        "visited_at": visitedAt.toIso8601String(),
      };

  @override
  int get hashCode => id.hashCode;
}
