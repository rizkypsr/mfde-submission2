part of 'now_playing_movies_cubit.dart';

@immutable
abstract class MovieListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieListInitial extends MovieListState {}

class MovieListLoading extends MovieListState {}

class MovieListError extends MovieListState {
  final String message;

  MovieListError(this.message);

  @override
  List<Object?> get props => [message];
}

class MovieListHasData extends MovieListState {
  final List<Movie> result;

  MovieListHasData(this.result);

  @override
  List<Object?> get props => [result];
}
