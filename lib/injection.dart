import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_watchlist_movie_status.dart';
import 'package:movie/domain/usecases/remove_watchlist_movie.dart';
import 'package:movie/domain/usecases/save_watchlist_movie.dart';
import 'package:movie/movie.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tv_series.dart';
import 'package:search/search.dart';
import 'package:tv/data/datasources/tv_local_data_source.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/data/repositories/tv_series_repository_impl.dart';
import 'package:tv/domain/repositories/tv_series_repository.dart';
import 'package:tv/domain/usecases/get_now_playing_tv_series.dart';
import 'package:tv/domain/usecases/get_popular_tv_series.dart';
import 'package:tv/domain/usecases/get_top_rated_tv_series.dart';
import 'package:tv/domain/usecases/get_tv_series_detail.dart';
import 'package:tv/domain/usecases/get_tv_series_recommendations.dart';
import 'package:tv/domain/usecases/get_tv_series_season_detail.dart';
import 'package:tv/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:tv/domain/usecases/save_watchlist_tv_series.dart';
import 'package:tv/tv.dart';
import 'package:watchlist/presentations/cubit/watchlist_cubit.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(
      () => NowPlayingMoviesCubit(getNowPlayingMovies: locator()));
  locator
      .registerFactory(() => PopularMoviesCubit(getPopularMovies: locator()));
  locator
      .registerFactory(() => TopRatedMoviesCubit(getTopRatedMovies: locator()));
  locator.registerFactory(() => MovieDetailCubit(
      getMovieDetail: locator(), getMovieRecommendations: locator()));
  locator.registerFactory(() => MovieRecommendationsCubit(locator()));
  locator.registerFactory(() => MovieWatchlistCubit(
      getWatchListMovieStatus: locator(),
      saveWatchlistMovie: locator(),
      removeWatchlistMovie: locator()));
  locator.registerFactory(() => WatchlistCubit(locator()));
  locator.registerFactory(() => NowPlayingTvCubit(locator()));
  locator.registerFactory(() => PopularTvCubit(locator()));
  locator.registerFactory(() => TopRatedTvCubit(locator()));
  locator.registerFactory(() => TvDetailCubit(
      getTvSeriesDetail: locator(), getTvSeriesRecommendations: locator()));
  locator.registerFactory(() => TvRecommendationsCubit(locator()));
  locator.registerFactory(() => TvSeasonDetailCubit(locator()));
  locator.registerFactory(() => TvWatchlistCubit(
      getWatchListTvSeriesStatus: locator(),
      removeWatchlistTvSeries: locator(),
      saveWatchlistTvSeries: locator()));
  locator.registerFactory(() => SearchMovieBloc(locator()));
  locator.registerFactory(() => SearchTvBloc(locator()));

  // usecases
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => GetWatchListMovieStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetNowPlayingTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => GetWatchListTvSeriesStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesSeasonDetail(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));

  //repositories
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
      () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => SecureHttp.client);
}
