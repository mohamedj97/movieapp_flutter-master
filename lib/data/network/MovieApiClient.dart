import 'package:dio/dio.dart';
import 'package:movieapp/data/pojo/CastResponse.dart';
import 'package:movieapp/data/pojo/MovieResponse.dart';
import 'package:movieapp/data/pojo/movie_details_response.dart';
import 'package:movieapp/data/pojo/review_response.dart';
import 'package:movieapp/data/pojo/trailers_entity.dart';
import 'package:retrofit/retrofit.dart';

import '../../constants.dart';

part 'MovieApiClient.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class MovieApiClient {
  factory MovieApiClient(Dio dio) = _RestClient;

  @GET(MOVIES_PATH)
  Future<MovieResponse> getMovies(@Query('page') int page);

  @GET(MOVIES_DETAILS_PATH)
  Future<MovieDetailsResponse> getMovieDetails(@Path('id') int movieID);

  @GET(MOVIES_TRAILER_PATH)
  Future<TrailersEntity> getTrailers(@Path('id') int movieID);

  @GET(MOVIES_CAST_PATH)
  Future<CastResponse> getCast(@Path('id') int movieID);

  @GET(MOVIES_REVIEW_PATH)
  Future<ReviewResponse> getReviews(@Path('id') int movieID);
}
