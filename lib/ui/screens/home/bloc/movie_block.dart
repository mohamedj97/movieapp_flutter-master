import 'package:bloc/bloc.dart';
import 'package:movieapp/data/MovieRepository.dart';
import 'package:movieapp/data/network/ApiResponse.dart';
import 'package:movieapp/data/pojo/MovieResponse.dart';
import 'package:movieapp/ui/screens/favourite/bloc/bloc.dart';
import 'package:movieapp/ui/screens/home/bloc/movie_events.dart';
import 'package:movieapp/ui/screens/home/bloc/movie_state.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieRepository _movieRepository;
  FavoriteBloc favoriteBloc;
  List<Movie> _movies;
  int lastPageNumber = 1;

  MovieBloc({FavoriteBloc favoriteBloc}) {
    _movies = [];
    _movieRepository = MovieRepository();
    this.favoriteBloc = favoriteBloc;
    this.favoriteBloc?.listen((favouriteState) {
      if (favouriteState is FavoriteMoviesLoaded) {
        for (var value in _movies) {
          value.isFavorite = (favouriteState.movies
                  .where((movie) => movie.id == value.id)
                  .length >
              0);
        }
        this.add(RefreshMoviesEvent());
      }
    });
  }

  @override
  Stream<MovieState> transformEvents(Stream<MovieEvent> events, Function next) {
    if (events is FetchMoviesEvent)
      return super.transformEvents(
        events.debounceTime(
          Duration(milliseconds: 500),
        ),
        next,
      );
    else
      return super.transformEvents(
        events,
        next,
      );
  }

  @override
  MovieState get initialState => InitialState();

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is FetchMoviesEvent) {
      if (lastPageNumber == 1) yield MoviesLoading();
      yield await _getMovies(lastPageNumber);
    } else if (event is RefreshMoviesEvent) {
      if ((_movies == null || _movies.isEmpty))
        yield MoviesLoaded([], 0);
      else
        yield MoviesLoaded(_movies, lastPageNumber);
    } else if (event is ReFetchMoviesEvent) {
      yield MoviesLoading();
      lastPageNumber = 1;
      _movies.clear();
      yield await _getMovies(lastPageNumber);
    }
  }

  Future<MovieState> _getMovies(int pageNumber) async {
    ApiResponse apiResponse =
        await _movieRepository.fetchMovies(page: pageNumber);
    if (apiResponse.status == Status.COMPLETED) {
      _movies.addAll(apiResponse.data);
      return MoviesLoaded(_movies, lastPageNumber++);
    } else
      return MoviesError(apiResponse.messageKey);
  }

  @override
  void onTransition(Transition<MovieEvent, MovieState> transition) {
    print(transition);

    super.onTransition(transition);
  }
}
