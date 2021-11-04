part of 'now_playing_tv_cubit.dart';

abstract class NowPlayingTvState extends Equatable {
  const NowPlayingTvState();

  @override
  List<Object> get props => [];
}

class NowPlayingTvInitial extends NowPlayingTvState {}

class NowPlayingTvLoading extends NowPlayingTvState {}

class NowPlayingTvError extends NowPlayingTvState {
  final String message;

  const NowPlayingTvError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingTvHasData extends NowPlayingTvState {
  final List<TvSeries> tvSeries;

  const NowPlayingTvHasData(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}
