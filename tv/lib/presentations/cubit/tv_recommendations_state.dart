part of 'tv_recommendations_cubit.dart';

@immutable
abstract class TvRecommendationsState extends Equatable {
  const TvRecommendationsState();

  @override
  List<Object?> get props => [];
}

class TvRecommendationsInitial extends TvRecommendationsState {}

class TvRecommendationsLoading extends TvRecommendationsState {}

class TvRecommendationsError extends TvRecommendationsState {
  final String message;

  const TvRecommendationsError(this.message);

  @override
  List<Object?> get props => [message];
}

class TvRecommendationsHasData extends TvRecommendationsState {
  final List<TvSeries> result;

  const TvRecommendationsHasData(this.result);

  @override
  List<Object> get props => [result];
}
