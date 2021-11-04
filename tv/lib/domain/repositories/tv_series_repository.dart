import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv/domain/entities/tv_season_detail.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/entities/tv_series_detail.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getNowPlayingTvSeries();
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries();
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries();
  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail(int id);
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecommendations(int id);
  Future<Either<Failure, TvSeriesSeasonDetail>> getTvSeriesSeasonDetail(
      int tvId, int seasonNumber);
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query);
  Future<Either<Failure, List<TvSeries>>> getWatchlistTvSeries();
  Future<Either<Failure, String>> saveWatchlist(TvSeriesDetail tvSeries);
  Future<Either<Failure, String>> removeWatchlist(TvSeriesDetail tvSeries);
  Future<bool> isAddedToWatchlist(int id);
}
