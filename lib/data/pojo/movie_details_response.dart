// To parse this JSON data, do
//
//     final movieDetailsResponse = movieDetailsResponseFromJson(jsonString);


class MovieDetailsResponse {
  int budget;
  String homepage;
  String imdbId;
  String originalLanguage;
  String originalTitle;
  DateTime releaseDate;
  int revenue;
  int runtime;
  String status;
  String tagline;
  String title;
  bool video;
  int movieId;
  int id;

  MovieDetailsResponse(
      {this.budget,
      this.homepage,
      this.imdbId,
      this.originalLanguage,
      this.originalTitle,
      this.releaseDate,
      this.revenue,
      this.runtime,
      this.status,
      this.tagline,
      this.title,
      this.video,
      this.id});

  factory MovieDetailsResponse.fromJson(Map<String, dynamic> json) =>
      MovieDetailsResponse(
        budget: json["budget"] == null ? null : json["budget"],
        homepage: json["homepage"] == null ? null : json["homepage"],
        imdbId: json["imdb_id"] == null ? null : json["imdb_id"],
        originalLanguage: json["original_language"] == null
            ? null
            : json["original_language"],
        originalTitle:
            json["original_title"] == null ? null : json["original_title"],
        releaseDate: json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
        revenue: json["revenue"] == null ? null : json["revenue"],
        runtime: json["runtime"] == null ? null : json["runtime"],
        status: json["status"] == null ? null : json["status"],
        tagline: json["tagline"] == null ? null : json["tagline"],
        title: json["title"] == null ? null : json["title"],
        video: json["video"] == null ? null : json["video"] == 1,
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "budget": budget == null ? null : budget,
        "homepage": homepage == null ? null : homepage,
        "imdb_id": imdbId == null ? null : imdbId,
        "original_language": originalLanguage == null ? null : originalLanguage,
        "original_title": originalTitle == null ? null : originalTitle,
        "release_date": releaseDate == null
            ? null
            : "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "revenue": revenue == null ? null : revenue,
        "runtime": runtime == null ? null : runtime,
        "status": status == null ? null : status,
        "tagline": tagline == null ? null : tagline,
        "title": title == null ? null : title,
        "video": video == null ? null : video,
        'movieId': movieId,
        'id': id
      };
}
