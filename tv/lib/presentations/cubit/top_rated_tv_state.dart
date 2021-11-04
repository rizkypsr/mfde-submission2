part of 'top_rated_tv_cubit.dart';

@immutable
abstract class TopRatedTvState extends Equatable {
  const TopRatedTvState();

  @override
  List<Object?> get props => [];
}

class TopRatedTvInitial extends TopRatedTvState {}

class TopRatedTvLoading extends TopRatedTvState {}

class TopRatedTvError extends TopRatedTvState {
  final String message;

  const TopRatedTvError(this.message);
}

class TopRatedTvHasData extends TopRatedTvState {
  final List<TvSeries> tvSeries;

  const TopRatedTvHasData(this.tvSeries);
}
