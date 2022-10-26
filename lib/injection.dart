import 'package:core/core.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/search.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:core/presentation/provider/movie_detail_notifier.dart';
import 'package:core/presentation/provider/movie_list_notifier.dart';
import 'package:core/presentation/provider/popular_movies_notifier.dart';
import 'package:core/presentation/provider/top_rated_movies_notifier.dart';
import 'package:core/presentation/provider/watchlist_movie_notifier.dart';
import 'package:core/provider/tab_menu_notifier.dart';
import 'package:core/tv/data/datasources/db/database_helper.dart';
import 'package:core/tv/data/datasources/tv_local_data_source.dart';
import 'package:core/tv/data/datasources/tv_remote_data_source.dart';
import 'package:core/tv/data/repositories/tv_repository_impl.dart';
import 'package:core/tv/domain/repositories/tv_repository.dart';
import 'package:core/tv/domain/usecases/get_now_playing_tv.dart';
import 'package:core/tv/domain/usecases/get_popular_tv.dart';
import 'package:core/tv/domain/usecases/get_top_rated_tv.dart';
import 'package:core/tv/domain/usecases/get_tv_detail.dart';
import 'package:core/tv/domain/usecases/get_tv_recomendations.dart';
import 'package:core/tv/domain/usecases/get_tv_watchlist_status.dart';
import 'package:core/tv/domain/usecases/get_watchlist_tv.dart';
import 'package:core/tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:core/tv/domain/usecases/save_wacthlist_tv.dart';
import 'package:core/tv/domain/usecases/search_tv.dart';
import 'package:core/tv/presentation/provider/tv_detail_notifier.dart';
import 'package:core/tv/presentation/provider/tv_list_notifier.dart';
import 'package:core/tv/presentation/provider/tv_search_notifier.dart';
import 'package:core/tv/presentation/provider/watchlist_tv_notifier.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
//bloc
  locator.registerFactory(() => SearchBloc(locator()));

  // provider

  locator.registerFactory(() => TabMenuNotifier());

  locator.registerFactory(() => TvListNotifier(
      getNowPlayingTv: locator(),
      getPopularTv: locator(),
      getTopRatedTv: locator()));

  locator.registerFactory(() => TvDetailNotifier(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
      getTvWatchListStatus: locator(),
      saveWatchListTv: locator(),
      removeWatchListTv: locator()));

  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );

  locator.registerFactory(() => WatchlistTvNotifier(getWatchListTv: locator()));
  locator.registerFactory(() => TvSearchNotifier(searchTv: locator()));

  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  // use case
  //movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  //tv
  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => GetTvWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchListTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchListTv(locator()));
  locator.registerLazySingleton(() => GetWatchListTv(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));

  // repository
  //movie
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
        remoteDataSource: locator(),
        localDataSource: locator(),
        networkInfo: locator()),
  );
  //tv
  locator.registerLazySingleton<TvRepository>(() => TvRepositoryImpl(
      remoteDataSource: locator(),
      networkInfo: locator(),
      localDataSource: locator()));

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  //tv
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(tvDatabaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<TvDatabaseHelper>(() => TvDatabaseHelper());

  //network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
}
