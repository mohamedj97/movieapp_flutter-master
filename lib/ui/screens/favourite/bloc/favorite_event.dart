import 'package:equatable/equatable.dart';
import 'package:movieapp/data/pojo/MovieResponse.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();
}

class FavoriteMovie extends FavoriteEvent {
  final Movie movie;

  FavoriteMovie(this.movie);

  @override
  List<Object> get props => [movie];
}

class UnFavoriteMovie extends FavoriteEvent {
  final Movie movie;

  UnFavoriteMovie(this.movie);

  @override
  List<Object> get props => [movie];
}

class FetchFavoriteMovies extends FavoriteEvent {
  @override
  List<Object> get props => [];
}

class ClearFavorite extends FavoriteEvent {
  @override
  List<Object> get props => [];
}
