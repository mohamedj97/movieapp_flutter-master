class TrailersEntity {
  int id;
  List<TrailersResult> results = [];

  TrailersEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        results = List<TrailersResult>.from(
            json["results"].map((x) => TrailersResult.fromJson(x)));

  Map<String, dynamic> toJson() => {
        'id': id,
        'results': results,
      };
}

class TrailersResult {
  String id;
  String iso6391;
  String iso31661;
  String key;
  String name;
  String site;
  int size;
  String type;
  int movieId;

  TrailersResult.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        iso6391 = json['iso6391'],
        iso31661 = json['iso31661'],
        key = json['key'],
        name = json['name'],
        site = json['site'],
        size = json['size'],
        type = json['type'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'iso6391': iso6391,
        'iso31661': iso31661,
        'key': key,
        'name': name,
        'site': site,
        'size': size,
        'type': type,
        'movieId': movieId,
      };
}
