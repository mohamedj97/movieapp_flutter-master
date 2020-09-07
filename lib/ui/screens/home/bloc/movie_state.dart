import 'package:equatable/equatable.dart';
import 'package:movieapp/data/pojo/MovieResponse.dart';

abstract class MovieState extends Equatable {
  @override
  List<Object> get props => [];
}

class MoviesLoading extends MovieState {
  @override
  List<Object> get props => [];
}

class InitialState extends MovieState {
  @override
  List<Object> get props => [];
}

class MoviesError extends MovieState {
  final String msg;

  MoviesError(this.msg);

  @override
  List<Object> get props => [msg];
  @override
  String toString() => 'ErrorFetchingMovies{\'msg\': $msg}';
}

class MoviesLoaded extends MovieState {
  final List<Movie> movies;
  final int pageNumber;
  MoviesLoaded(this.movies, this.pageNumber);

  @override
  List<Object> get props => [movies, this.pageNumber];

  @override
  String toString() => 'FetchMovies {movies:${movies.length}';
}
