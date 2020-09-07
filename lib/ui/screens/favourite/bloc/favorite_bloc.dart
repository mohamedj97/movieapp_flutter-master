import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movieapp/data/database/DbService.dart';
import 'package:movieapp/utils/di.dart';

import 'favorite_event.dart';
import 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  DbService _dbService;

  FavoriteBloc() {
    _dbService = getIt<DbService>();
  }

  @override
  FavoriteState get initialState => InitialFavoriteState();

  @override
  Stream<FavoriteState> mapEventToState(FavoriteEvent event) async* {
    if (event is FavoriteMovie) {
      await _dbService.insertMovie(event.movie);
      var movies = await _dbService.getMovies();
      yield FavoriteMoviesLoaded(movies);
    } else if (event is UnFavoriteMovie) {
      await _dbService.deleteMovie(event.movie.id);
      var movies = await _dbService.getMovies();
      yield FavoriteMoviesLoaded(movies);
    } else if (event is FetchFavoriteMovies) {
      yield FavoriteMoviesLoading();
      var movies = await _dbService.getMovies();
      yield FavoriteMoviesLoaded(movies);
    } else if (event is ClearFavorite) {
      yield FavoriteMoviesLoading();
      await _dbService.clearFavorite();
      yield FavoriteMoviesLoaded([]);
    }
  }
}
