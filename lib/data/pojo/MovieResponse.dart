// To parse this JSON data, do
//
//     final movieResponse = movieResponseFromJson(jsonString);

import 'dart:convert';

import 'package:movieapp/data/network/NetworkService.dart';
import 'package:movieapp/data/pojo/CastResponse.dart';
import 'package:movieapp/data/pojo/movie_details_response.dart';
import 'package:movieapp/data/pojo/review_response.dart';
import 'package:movieapp/data/pojo/trailers_entity.dart';

class MovieResponse {
  int page;
  int totalMovies;
  int totalPages;
  List<Movie> movies;

  MovieResponse({
    this.page,
    this.totalMovies,
    this.totalPages,
    this.movies,
  });

  String toJson() => json.encode(toMap());

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
        page: json["page"] == null ? null : json["page"],
        totalMovies: json["total_Movies"] == null ? null : json["total_Movies"],
        totalPages: json["total_pages"] == null ? null : json["total_pages"],
        movies: json["results"] == null
            ? null
            : List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "page": page == null ? null : page,
        "total_Movies": totalMovies == null ? null : totalMovies,
        "total_pages": totalPages == null ? null : totalPages,
        "results": movies == null
            ? null
            : List<dynamic>.from(movies.map((x) => x.toMap())),
      };
}

class Movie {
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalTitle;
  String title;
  double voteAverage;
  String overview;
  DateTime releaseDate;
  bool isFavorite = false;
  List<TrailersResult> trailers = [];
  List<Review> reviews = [];
  List<CastElement> cast = [];
  MovieDetailsResponse movieDetails;

  Movie setData(MovieHolder movieHolder) {
    this.trailers = movieHolder.trailers;
    this.reviews = movieHolder.reviews;
    this.movieDetails = movieHolder.s;
    this.cast = movieHolder.cast;

    return this;
  }

  Movie({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalTitle,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Movie.fromMap(Map<String, dynamic> json) => Movie(
        popularity:
            json["popularity"] == null ? null : json["popularity"].toDouble(),
        voteCount: json["vote_count"] == null ? null : json["vote_count"],
        video: json["video"] == null ? null : json["video"],
        posterPath: json["poster_path"] == null ? null : json["poster_path"],
        id: json["id"] == null ? null : json["id"],
        adult: json["adult"] == null ? null : json["adult"],
        backdropPath:
            json["backdrop_path"] == null ? null : json["backdrop_path"],
        originalTitle:
            json["original_title"] == null ? null : json["original_title"],
        title: json["title"] == null ? null : json["title"],
        voteAverage: json["vote_average"] == null
            ? null
            : json["vote_average"].toDouble(),
        overview: json["overview"] == null ? null : json["overview"],
        releaseDate: json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
      );
  factory Movie.fromDBMap(Map<String, dynamic> json) => Movie(
        popularity: json["popularity"] == null
            ? null
            : double.parse(json["popularity"]),
        voteCount: json["vote_count"] == null ? null : json["vote_count"],
        video: json["video"] == null ? null : json["video"] == 1,
        posterPath: json["poster_path"] == null ? null : json["poster_path"],
        id: json["id"] == null ? null : json["id"],
        adult: json["adult"] == null ? null : json["adult"] == 1,
        backdropPath:
            json["backdrop_path"] == null ? null : json["backdrop_path"],
        originalTitle:
            json["original_title"] == null ? null : json["original_title"],
        title: json["title"] == null ? null : json["title"],
        voteAverage: json["vote_average"] == null
            ? null
            : json["vote_average"].toDouble(),
        overview: json["overview"] == null ? null : json["overview"],
        releaseDate: json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
      );

  Map<String, dynamic> toMap() => {
        "popularity": popularity == null ? null : popularity,
        "vote_count": voteCount == null ? null : voteCount,
        "video": video == null ? null : video,
        "poster_path": posterPath == null ? null : posterPath,
        "id": id == null ? null : id,
        "adult": adult == null ? null : adult,
        "backdrop_path": backdropPath == null ? null : backdropPath,
        "original_title": originalTitle == null ? null : originalTitle,
        "title": title == null ? null : title,
        "vote_average": voteAverage == null ? null : voteAverage,
        "overview": overview == null ? null : overview,
        "release_date": releaseDate == null
            ? null
            : "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
//        "trailer": trailers == null
//            ? null
//            : List<dynamic>.from(trailers.map((x) => x)),
//        "reviews":
//            reviews == null ? null : List<dynamic>.from(reviews.map((x) => x)),
//        "actors": cast == null ? null : List<dynamic>.from(cast.map((x) => x)),
//        "details": movieDetails == null ? null : movieDetails.toMap(),
      };
}
