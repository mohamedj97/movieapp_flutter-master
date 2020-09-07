import 'package:flutter/material.dart';
import 'package:movieapp/data/pojo/MovieResponse.dart';
import 'package:movieapp/ui/AppWidgets.dart';
import 'package:movieapp/ui/screens/movie_detail/movie_details.dart';

import '../../../constants.dart';

class HomeItemWidget extends StatelessWidget {
  final VoidCallback onTap2;
  final Movie movie;

  HomeItemWidget(this.movie, this.onTap2);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => MovieDetails(movie),
              transitionDuration: Duration(milliseconds: 800))),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Hero(
              tag: movie.posterPath,
              child: RoundedImage(
                imgPath: '$IMAGE_PATH${movie.posterPath}',
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.all(5.0),
                width: 40,
                height: 40,
                child: FavouriteBtn(movie.isFavorite, onTap2),

//                  Icon(
//                    movie.isFavorite ? Icons.favorite : Icons.favorite_border,
//                    color: Colors.white,
//                    size: 40,
//                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
