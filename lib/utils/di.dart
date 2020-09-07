import 'package:get_it/get_it.dart';
import 'package:movieapp/data/database/DbService.dart';
import 'package:movieapp/data/network/NetworkService.dart';
import 'package:movieapp/ui/screens/favourite/bloc/favorite_bloc.dart';
import 'package:movieapp/ui/screens/home/bloc/movie_block.dart';
import 'package:movieapp/utils/Secret.dart';

final GetIt getIt = GetIt.instance;

const FIRST_TIME = "first";
const LANG_NAME = "Lang";

Future initApp() async {
  GetIt.instance.registerSingleton<DbService>(DbService());
  var key = await Secret.getTMDBKey();
  GetIt.instance.registerSingleton<NetworkService>(NetworkService(key));

  FavoriteBloc _favoriteBloc;
  MovieBloc _movieBloc;
  _favoriteBloc = new FavoriteBloc();
  _movieBloc = new MovieBloc(favoriteBloc: _favoriteBloc);
  getIt.registerSingleton(_favoriteBloc);

  getIt.registerSingleton(_movieBloc);
}
