import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_format/date_format.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/data/pojo/MovieResponse.dart';
import 'package:movieapp/resources/AppColors.dart';
import 'package:movieapp/ui/AppWidgets.dart';
import 'package:movieapp/ui/screens/favourite/bloc/bloc.dart';
import 'package:movieapp/ui/screens/movie_detail/MovieDetailsWidgets.dart';
import 'package:movieapp/ui/screens/movie_detail/actor_item_widget.dart';
import 'package:movieapp/ui/screens/movie_detail/review_item_widget.dart';
import 'package:movieapp/ui/screens/movie_detail/review_screen.dart';
import 'package:movieapp/ui/screens/movie_detail/video_item_widget.dart';
import 'package:movieapp/utils/Locale.dart';
import 'package:movieapp/utils/UrlUtils.dart';
import 'package:movieapp/utils/di.dart';
import 'package:movieapp/utils/typed_text.dart';

import '../../../constants.dart';

class MovieDetails extends StatefulWidget {
  final Movie movie;

  MovieDetails(this.movie);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  FavoriteBloc _favoriteBloc;

  @override
  void initState() {
    super.initState();
    _favoriteBloc = getIt<FavoriteBloc>();
  }

  @override
  Widget build(BuildContext context) {
    //  print(widget.movie.cast.length);
    return EasyLocalizationProvider(
      data: appLocale.data,
      child: Scaffold(
        backgroundColor: AppColors.COLOR_DARK_PRIMARY,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              elevation: 30,
              pinned: true,
              floating: false,
              snap: false,
              expandedHeight: 220.0,
              backgroundColor: AppColors.COLOR_PRIMARY[700],
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: AutoSizeText(widget.movie.title,
                    minFontSize: 15,
                    maxLines: 2,
                    maxFontSize: 18,
                    style: TextStyle(color: AppColors.TEXT_COLOR)),
                background: Image.network(
                  '$IMAGE_PATH${widget.movie.backdropPath}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(8.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  HeaderWidget(movie: widget.movie),
                  SpaceDividerWidget(),
                  TypedText(data: widget.movie.movieDetails.tagline),
//                  AutoSizeText(
//                    '${widget.movie.movieDetails.tagline}',
//                    minFontSize: 18,
//                    maxFontSize: 20,
//                    style: (TextStyle(color: Colors.lightBlue)),
//                    maxLines: 6,
//                    textAlign: TextAlign.center,
//                    overflow: TextOverflow.ellipsis,
//                  ),
                  SpaceDividerWidget(),
                  descriptionSection(widget.movie),
                  SpaceDividerWidget(),
                  actorsSection(widget.movie),
                  SpaceDividerWidget(),
                  videosSection(widget.movie),
                  SpaceDividerWidget(),
                  reviewSections(widget.movie)
                ]),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _favoriteBloc.add(widget.movie.isFavorite
                ? UnFavoriteMovie(widget.movie)
                : FavoriteMovie(widget.movie));

            setState(() {
              widget.movie.isFavorite = !widget.movie.isFavorite;
            });
          },
          child: Icon(
            widget.movie.isFavorite ? Icons.favorite : Icons.favorite_border,
          ),
          backgroundColor: AppColors.COLOR_ACCENT,
        ),
      ),
    );
  }

  Widget reviewSections(Movie movie) {
    if (movie.reviews == null || movie.reviews.isEmpty) {
      return SizedBox(
        width: 0,
        height: 0,
      );
    } else {
      return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SubTitleWidget(appLocale.tr('Reviews')),
            SizedBox(
              height: 5,
            ),
            Container(
                height: 160,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ReviewItemWidget(
                      movie.reviews[0],
                      hasTextLimit: true,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.blueGrey[800].withOpacity(0.8),
                                spreadRadius: 0,
                                offset: Offset(0, -5)),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ReviewScreen(widget.movie.reviews)));
                          },
                          child: AutoSizeText(
                            appLocale.tr('All_Reviews'),
                            minFontSize: 20,
                            maxFontSize: 23,
                            style: (TextStyle(color: Colors.orange)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ]);
    }
  }

  Widget videosSection(Movie movie) {
    if (movie.trailers == null || movie.trailers.isEmpty) {
      return SizedBox(
        width: 0,
        height: 0,
      );
    } else {
      return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SubTitleWidget(appLocale.tr('Videos')),
            Flexible(
              child: Container(
                height: 170,
                child: ListView.builder(
                    itemBuilder: (context, index) =>
                        VideoItemWidget(widget.movie.trailers[index]),
                    itemCount: widget.movie.trailers.length,
                    shrinkWrap: true,
//                        Container(height: 170, width: 100),
                    scrollDirection: Axis.horizontal),
              ),
            )
          ]);
    }
  }

  Widget actorsSection(Movie movie) {
    if (movie.cast.isEmpty) {
      return SizedBox(
        width: 0,
        height: 0,
      );
    } else {
      return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SubTitleWidget(appLocale.tr('Actors')),
            Container(
              height: 200,
              child: ListView.builder(
                  itemBuilder: (context, index) =>
                      ActorItemWidget(widget.movie.cast[index]),
                  itemCount: widget.movie.cast.length,
                  //  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal),
            )
          ]);
    }
  }

  Widget descriptionSection(Movie movie) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SubTitleWidget(appLocale.tr('Description')),
          AutoSizeText(
            '${widget.movie.overview}',
            minFontSize: 15,
            maxFontSize: 18,
            style: (TextStyle(color: Colors.white, wordSpacing: 1.1)),
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
          ),
        ]);
  }
}

class HeaderWidget extends StatelessWidget {
  final Movie movie;

  const HeaderWidget({
    Key key,
    this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 8,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Hero(
              tag: movie.posterPath,
              child: RoundedImage(
                imgPath: '$IMAGE_PATH${movie.posterPath}',
                height: 200,
              ),
            ),
          ),
        ),
        Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 5),
              SubTitleWidget(appLocale.tr('Release_date')),
              SizedBox(height: 5),
              AutoSizeText(
                '${formatDate(DateTime.now(), [dd, '-', mm, '-', yyyy])}',
                minFontSize: 15,
                maxFontSize: 18,
                style: (TextStyle(color: Colors.white)),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 5),
              SubTitleWidget(appLocale.tr('Vote')),
              AutoSizeText(
                  appLocale.tr('Vote_degreee',
                      args: [movie.voteAverage.floor().toString()]),
                  minFontSize: 15,
                  maxFontSize: 20,
                  style: (TextStyle(color: Colors.white)),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis),
              SizedBox(height: 10),
              SizedBox(
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          UrlUtils.launchURL(movie.movieDetails.homepage);
                        },
                        child: Image.asset(
                          'images/website.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          UrlUtils.launchImdb(movie.movieDetails.imdbId);
                        },
                        child: Image.asset(
                          'images/imdb.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
