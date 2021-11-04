part of 'movie_watchlist_cubit.dart';

@immutable
abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object?> get props => [];
}

class MovieWatchlistInitial extends MovieWatchlistState {}

class MovieWatchlistStatus extends MovieWatchlistState {
  final bool isAddedToWatchlist;

  const MovieWatchlistStatus(this.isAddedToWatchlist);

  @override
  List<Object?> get props => [isAddedToWatchlist];
}

class MovieWatchlistMessage extends MovieWatchlistState {
  final String message;

  const MovieWatchlistMessage(this.message);

  @override
  List<Object?> get props => [message];
}
