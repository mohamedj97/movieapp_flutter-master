import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/data/pojo/MovieResponse.dart';
import 'package:movieapp/resources/AppColors.dart';
import 'package:movieapp/ui/screens/favourite/bloc/favorite_state.dart';
import 'package:movieapp/ui/screens/favourite/favorite_item_widget.dart';
import 'package:movieapp/utils/Locale.dart';
import 'package:movieapp/utils/di.dart';

import '../../AppWidgets.dart';
import 'bloc/favorite_bloc.dart';
import 'bloc/favorite_event.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({Key key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  FavoriteBloc _favoriteBloc;

  @override
  void initState() {
    super.initState();
    _favoriteBloc = getIt<FavoriteBloc>();
    _favoriteBloc.add(FetchFavoriteMovies());
  }

  unFavoriteMovie(Movie movie) {
    _favoriteBloc.add(UnFavoriteMovie(movie));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) => Container(
        width: double.infinity,
        color: Colors.blueGrey[900],
        child: getWidget(state),
      ),
    );
  }

  Widget getWidget(FavoriteState movieState) {
    print(movieState.runtimeType.toString());
    if (movieState is FavoriteMoviesLoading) {
      return ProgressBar();
    } else if (movieState is FavoriteMoviesLoaded) {
      if (movieState.movies.length == 0) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: AutoSizeText(
              appLocale.tr('Favourite_empty'),
              minFontSize: 20,
              maxFontSize: 30,
              style: TextStyle(color: AppColors.TEXT_COLOR),
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else
        return ListView.builder(
          itemCount: movieState.movies.length,
          itemBuilder: (context, index) {
            return FavoriteItemWidget(
              movieState.movies[index],
              () => unFavoriteMovie(movieState.movies[index]),
            );
          },
        );
    }
    return null;
  }
}
