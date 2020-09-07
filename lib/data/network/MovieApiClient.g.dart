// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MovieApiClient.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements MovieApiClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://api.themoviedb.org/3/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getMovies(page) async {
    ArgumentError.checkNotNull(page, 'page');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{'page': page};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'discover/movie?sort_by=popularity.desc',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MovieResponse.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getMovieDetails(movieID) async {
    ArgumentError.checkNotNull(movieID, 'movieID');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'movie/$movieID',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MovieDetailsResponse.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getTrailers(movieID) async {
    ArgumentError.checkNotNull(movieID, 'movieID');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'movie/$movieID/videos',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TrailersEntity.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getCast(movieID) async {
    ArgumentError.checkNotNull(movieID, 'movieID');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'movie/$movieID/credits',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CastResponse.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getReviews(movieID) async {
    ArgumentError.checkNotNull(movieID, 'movieID');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'movie/$movieID/reviews',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ReviewResponse.fromJson(_result.data);
    return Future.value(value);
  }
}
