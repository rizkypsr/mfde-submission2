part of 'tv_watchlist_cubit.dart';

@immutable
abstract class TvWatchlistState extends Equatable {
  const TvWatchlistState();

  @override
  List<Object?> get props => [];
}

class TvWatchlistInitial extends TvWatchlistState {}

class TvWatchlistStatus extends TvWatchlistState {
  final bool isAddedToWatchlist;

  const TvWatchlistStatus(this.isAddedToWatchlist);

  @override
  List<Object?> get props => [isAddedToWatchlist];
}

class TvWatchlistMessage extends TvWatchlistState {
  final String message;

  const TvWatchlistMessage(this.message);

  @override
  List<Object?> get props => [message];
}
