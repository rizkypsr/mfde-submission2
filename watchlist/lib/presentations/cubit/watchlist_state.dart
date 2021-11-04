part of 'watchlist_cubit.dart';

@immutable
abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object?> get props => [];
}

class WatchlistInitial extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistError extends WatchlistState {
  final String message;

  const WatchlistError(this.message);
}

class WatchlistHasData extends WatchlistState {
  final List<Movie> movies;

  const WatchlistHasData(this.movies);
}
