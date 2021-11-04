part of 'tv_season_detail_cubit.dart';

@immutable
abstract class TvSeasonDetailState extends Equatable {
  const TvSeasonDetailState();

  @override
  List<Object?> get props => [];
}

class TvSeasonDetailInitial extends TvSeasonDetailState {}

class TvSeasonDetailLoading extends TvSeasonDetailState {}

class TvSeasonDetailError extends TvSeasonDetailState {
  final String message;

  const TvSeasonDetailError(this.message);
}

class TvSeasonDetailHasData extends TvSeasonDetailState {
  final TvSeriesSeasonDetail result;

  const TvSeasonDetailHasData(this.result);
}
