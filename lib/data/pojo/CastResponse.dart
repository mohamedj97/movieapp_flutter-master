// To parse this JSON data, do
//
//     final cast = castFromJson(jsonString);

import 'dart:convert';

class CastResponse {
  int id;
  List<CastElement> cast;

  CastResponse({
    this.id,
    this.cast,
  });

  factory CastResponse.fromJson(Map<String, dynamic> json) => CastResponse(
        id: json["id"] == null ? null : json["id"],
        cast: json["cast"] == null
            ? null
            : List<CastElement>.from(
                json["cast"].map((x) => CastElement.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "cast": cast == null
            ? null
            : List<dynamic>.from(cast.map((x) => x.toMap())),
      };
}

class CastElement {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;
  int movieId;

  CastElement({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  factory CastElement.fromJson(String str) =>
      CastElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CastElement.fromMap(Map<String, dynamic> json) => CastElement(
        castId: json["cast_id"] == null ? null : json["cast_id"],
        character: json["character"] == null ? null : json["character"],
        creditId: json["credit_id"] == null ? null : json["credit_id"],
        gender: json["gender"] == null ? null : json["gender"],
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        order: json["order"] == null ? null : json["order"],
        profilePath: json["profile_path"] == null ? null : json["profile_path"],
      );

  factory CastElement.fromDBMap(Map<String, dynamic> json) => CastElement(
        castId: json["cast_id"] == null ? null : json["cast_id"],
        character: json["character"] == null ? null : json["character"],
        creditId: json["credit_id"] == null ? null : json["credit_id"],
        gender: json["gender"] == null ? null : json["gender"],
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        order: json["order2"] == null ? null : json["order2"],
        profilePath: json["profile_path"] == null ? null : json["profile_path"],
      );

  Map<String, dynamic> toMap() => {
        "cast_id": castId == null ? null : castId,
        "character": character == null ? null : character,
        "credit_id": creditId == null ? null : creditId,
        "gender": gender == null ? null : gender,
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "order2": order == null ? null : order,
        "profile_path": profilePath == null ? null : profilePath,
        "movieId": movieId == null ? null : movieId,
      };
}
