import 'package:flutter/services.dart';
import 'package:movieapp/data/network/NetworkService.dart';
import 'package:movieapp/data/pojo/CastResponse.dart';
import 'package:movieapp/data/pojo/MovieResponse.dart';
import 'package:movieapp/data/pojo/movie_details_response.dart';
import 'package:movieapp/data/pojo/review_response.dart';
import 'package:movieapp/data/pojo/trailers_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbService {
  static const _MOVIE_TABLE = "movies";
  static const _DETAILS_TABLE = 'details';
  static const _REVIEWS_TABLE = 'reviews';
  static const _TRAILERS_TABLE = 'trailers';
  static const _ACTORS_TABLE = 'actors';

  Future<String> _loadAsset() async {
    return await rootBundle.loadString('assets/sql_commands.txt');
  }

  Future<Database> _createDB() async {
    var path = await getDatabasesPath();
    var text = await _loadAsset();
    var db = await openDatabase(
      // Set the path to the database.

      join(path, 'Movie.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        var arr = text.split('#');
        // Run the CREATE TABLE statement on the database.
        for (var o in arr) {
          db.execute(o.trim());
        }
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    return db;
  }

  Future<void> insertMovie(Movie movie) async {
    // Get a reference to the database.
    final Database db = await _createDB();
    for (final trailer in movie.trailers) {
      trailer.movieId = movie.id;
      await db.insert(
        _TRAILERS_TABLE,
        trailer.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    for (final review in movie.reviews) {
      review.movieId = movie.id;

      await db.insert(
        _REVIEWS_TABLE,
        review.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    for (final actor in movie.cast) {
      actor.movieId = movie.id;

      await db.insert(
        _ACTORS_TABLE,
        actor.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    movie.movieDetails.movieId = movie.id;
    await db.insert(
      _DETAILS_TABLE,
      movie.movieDetails.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return await db.insert(
      _MOVIE_TABLE,
      movie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Set<int>> getMoviesID() async {
    var db = await _createDB();
    List<Map<String, dynamic>> maps =
        await db.query(_MOVIE_TABLE, columns: ['id']);
    var s = List.generate(maps.length, (i) => maps[i]['id'] as int);
    return Set.from(s);
  }

  Future<Movie> getMovieDetails(int movieID) async {
    var db = await _createDB();
    List<Map<String, dynamic>> movieResult =
        await db.query(_MOVIE_TABLE, where: 'id=?', whereArgs: [movieID]);
    List<Map<String, dynamic>> trailersResult = await db
        .query(_TRAILERS_TABLE, where: 'movieId=?', whereArgs: [movieID]);
    List<Map<String, dynamic>> actorsResult =
        await db.query(_ACTORS_TABLE, where: 'movieId=?', whereArgs: [movieID]);
    List<Map<String, dynamic>> reviewsResult = await db
        .query(_REVIEWS_TABLE, where: 'movieId=?', whereArgs: [movieID]);
    List<Map<String, dynamic>> detailsResult = await db
        .query(_DETAILS_TABLE, where: 'movieId=?', whereArgs: [movieID]);
    Movie movie = Movie.fromDBMap(movieResult[0]);
    List<TrailersResult> trailers = List.generate(trailersResult.length,
        (i) => TrailersResult.fromJson(trailersResult[i]));
    List<Review> reviews = List.generate(
        reviewsResult.length, (i) => Review.fromMap(reviewsResult[i]));
    List<CastElement> actors = List.generate(
        actorsResult.length, (i) => CastElement.fromDBMap(actorsResult[i]));
    MovieDetailsResponse detail = List.generate(detailsResult.length,
        (i) => MovieDetailsResponse.fromJson(detailsResult[i])).first;

    return movie.setData(MovieHolder(detail, trailers, reviews, actors));
  }

  Future<int> deleteMovie(int movieID) async {
    var db = await _createDB();
    await db.delete(_TRAILERS_TABLE, where: 'movieId=?', whereArgs: [movieID]);
    await db.delete(_ACTORS_TABLE, where: 'movieId=?', whereArgs: [movieID]);
    await db.delete(_REVIEWS_TABLE, where: 'movieId=?', whereArgs: [movieID]);
    await db.delete(_DETAILS_TABLE, where: 'movieId=?', whereArgs: [movieID]);
    return db.delete(_MOVIE_TABLE, where: 'id=?', whereArgs: [movieID]);
  }

  Future<int> clearFavorite() async {
    var db = await _createDB();
    await db.delete(_TRAILERS_TABLE);
    await db.delete(_ACTORS_TABLE);
    await db.delete(_REVIEWS_TABLE);
    await db.delete(_DETAILS_TABLE);
    return db.delete(_MOVIE_TABLE);
  }

  Future<List<Movie>> getMovies() async {
    Set<int> moviesIDs = await getMoviesID();
    List<Movie> movies = [];
    for (var o in moviesIDs) {
      Movie movie = await getMovieDetails(o);
      movie.isFavorite = true;
      movies.add(movie);
    }
    return movies;
  }
}
