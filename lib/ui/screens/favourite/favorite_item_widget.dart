import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/data/pojo/MovieResponse.dart';
import 'package:movieapp/ui/AppWidgets.dart';
import 'package:movieapp/ui/screens/movie_detail/movie_details.dart';

import '../../../constants.dart';

class FavoriteItemWidget extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap2;

  FavoriteItemWidget(this.movie, this.onTap2);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => MovieDetails(movie))),
      child: new Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('$IMAGE_PATH${movie.backdropPath}'),
            fit: BoxFit.cover,
          ),
        ),
        child: ClipRect(
          child: new BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 05.0),
            child: Container(
              padding: EdgeInsets.all(16.0),
              height: 200,
              decoration:
                  new BoxDecoration(color: Colors.black.withOpacity(0.4)),
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Hero(
                      tag: "${movie.posterPath}",
                      child: RoundedImage(
                          imgPath: '$IMAGE_PATH${movie.posterPath}',
                          height: 200),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    flex: 6,
                    child: AutoSizeText(
                      movie.title,
                      minFontSize: 25,
                      maxFontSize: 28,
                      style: (TextStyle(color: Colors.white)),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: FavouriteBtn(movie.isFavorite, onTap2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
