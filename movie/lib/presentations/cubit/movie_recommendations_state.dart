part of 'movie_recommendations_cubit.dart';

@immutable
abstract class MovieRecommendationsState extends Equatable {
  const MovieRecommendationsState();

  @override
  List<Object?> get props => [];
}

class MovieRecomendationsInitial extends MovieRecommendationsState {}

class MovieRecommandationsLoading extends MovieRecommendationsState {}

class MovieRecommandationsError extends MovieRecommendationsState {
  final String message;

  const MovieRecommandationsError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieRecommandationsHasData extends MovieRecommendationsState {
  final List<Movie> movieRecommandations;

  const MovieRecommandationsHasData(this.movieRecommandations);

  @override
  List<Object> get props => [movieRecommandations];
}
