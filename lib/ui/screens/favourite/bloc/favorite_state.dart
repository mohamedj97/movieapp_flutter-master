import 'package:equatable/equatable.dart';
import 'package:movieapp/data/pojo/MovieResponse.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();
}

class InitialFavoriteState extends FavoriteState {
  @override
  List<Object> get props => [];
}

class FavoriteMoviesLoaded extends FavoriteState {
  final List<Movie> movies;

  FavoriteMoviesLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class FavoriteMoviesLoading extends FavoriteState {
  @override
  List<Object> get props => [];
}
