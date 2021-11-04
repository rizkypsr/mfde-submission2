import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv/domain/entities/tv_season_detail.dart';
import 'package:tv/domain/repositories/tv_series_repository.dart';

class GetTvSeriesSeasonDetail {
  final TvSeriesRepository repository;

  GetTvSeriesSeasonDetail(this.repository);

  Future<Either<Failure, TvSeriesSeasonDetail>> execute(
      int tvId, int seasonNumber) {
    return repository.getTvSeriesSeasonDetail(tvId, seasonNumber);
  }
}
