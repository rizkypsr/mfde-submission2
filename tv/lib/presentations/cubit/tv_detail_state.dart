part of 'tv_detail_cubit.dart';

@immutable
abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object?> get props => [];
}

class TvDetailInitial extends TvDetailState {}

class TvDetailLoading extends TvDetailState {}

class TvDetailError extends TvDetailState {
  final String message;

  const TvDetailError(this.message);
}

class TvDetailHasData extends TvDetailState {
  final TvSeriesDetail tvSeries;

  const TvDetailHasData(this.tvSeries);
}
