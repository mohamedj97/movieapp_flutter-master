import 'package:movieapp/data/database/DbService.dart';
import 'package:movieapp/data/network/ApiResponse.dart';
import 'package:movieapp/data/network/NetworkService.dart';
import 'package:movieapp/data/pojo/MovieResponse.dart';

import '../utils/di.dart' as di;

class MovieRepository {
  DbService _dbService;
  NetworkService _networkService;

  MovieRepository() {
    _networkService = di.getIt<NetworkService>();
    _dbService = di.getIt<DbService>();
  }

  Future<ApiResponse<List<Movie>>> fetchMovies(
      {bool fetchFromDb = false, int page = 1}) async {
    if (fetchFromDb) {
      return ApiResponse.completed(await _dbService.getMovies());
    } else {
      ApiResponse apiResponse = await _networkService.getMovies(page);
      if (apiResponse.status == Status.COMPLETED) {
        Set<int> movieIds = await _dbService.getMoviesID();
        List<Movie> movies = apiResponse.data;
        for (var movie in movies) {
          movie.isFavorite = movieIds.contains(movie.id);
        }
      }
      return apiResponse;
    }
  }

  Future<void> favouriteMovie(Movie movie) async {
    return _dbService.insertMovie(movie);
  }

  Future<void> unFavouriteMovie(Movie movie) async {
    return _dbService.deleteMovie(movie.id);
  }

  Future<void> clearFavorite() async {
    return _dbService.clearFavorite();
  }
}

var movieRepository = MovieRepository();
