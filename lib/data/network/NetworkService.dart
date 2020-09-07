import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/data/network/ApiResponse.dart';
import 'package:movieapp/data/network/MovieApiClient.dart';
import 'package:movieapp/data/pojo/CastResponse.dart';
import 'package:movieapp/data/pojo/MovieResponse.dart';
import 'package:movieapp/data/pojo/movie_details_response.dart';
import 'package:movieapp/data/pojo/review_response.dart';
import 'package:movieapp/data/pojo/trailers_entity.dart';
import 'package:movieapp/utils/di.dart';
import 'package:rxdart/rxdart.dart';

class NetworkService {
  MovieApiClient _restClient;
  String _apiKey;

  NetworkService(String apiKey, {locale = const Locale('en', 'US')}) {
    _apiKey = apiKey;
    resetDio(locale: locale);
  }

  resetDio({Locale locale}) {
    Dio dio = Dio(); // Provide a dio instance
    Locale temp = getIt<Locale>(LANG_NAME);
    if (temp != null) {
      locale = temp;
    }
    dio.interceptors.add(LogInterceptor(responseBody: true));
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions requestOptions) {
      requestOptions.queryParameters['api_key'] = _apiKey;
      if (!(requestOptions.uri.toString().contains('video')) &&
          !(requestOptions.uri.toString().contains('reviews'))) {
        requestOptions.queryParameters['language'] =
            '${locale.languageCode}-${locale.countryCode}';
      }
    }));

    dio.options.headers["Content-Type"] = "application/json";
    _restClient = MovieApiClient(dio);
  }

  Future<ApiResponse<List<Movie>>> getMovies(int page) async {
    try {
      var movies = await _getMovies(page);

      List<MovieHolder> list = await Future.wait(movies.map((itemId) =>
          ZipStream.zip4<MovieDetailsResponse, List<Review>,
                  List<TrailersResult>, List<CastElement>, MovieHolder>(
              Stream.fromFuture(_getMovieDetails(itemId.id)),
              Stream.fromFuture(_getReviews(itemId.id)),
              Stream.fromFuture(_getTrailers(itemId.id)),
              Stream.fromFuture(_getActors(itemId.id)),
              (MovieDetailsResponse response, List<Review> reviews,
                      List<TrailersResult> trailer, List<CastElement> crew) =>
                  MovieHolder(response, trailer, reviews, crew)).first));

      int index = 0;
      return ApiResponse<List<Movie>>.completed(list.map((response) {
        return movies[index++].setData(response);
      }).toList());
    } on DioError catch (e) {
      return ApiResponse.error(e);
    }
  }

  Future<List<Movie>> _getMovies(int page) async {
    var moveResponse = await _restClient.getMovies(page);
    return moveResponse.movies;
  }

  Future<List<TrailersResult>> _getTrailers(int movieID) async {
    var moveResponse = await _restClient.getTrailers(movieID);
    return moveResponse.results;
  }

  Future<List<CastElement>> _getActors(int movieID) async {
    var moveResponse = await _restClient.getCast(movieID);
    return moveResponse.cast;
  }

  Future<MovieDetailsResponse> _getMovieDetails(int movieID) async {
    var moveResponse = await _restClient.getMovieDetails(movieID);
    return moveResponse;
  }

  Future<List<Review>> _getReviews(int movieID) async {
    var moveResponse = await _restClient.getReviews(movieID);
    return moveResponse.results;
  }
}

class MovieHolder {
  MovieDetailsResponse s;
  List<TrailersResult> trailers;
  List<Review> reviews;
  List<CastElement> cast;

  MovieHolder(this.s, this.trailers, this.reviews, this.cast);
}
