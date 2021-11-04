import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/usecases/get_tv_series_recommendations.dart';

part 'tv_recommendations_state.dart';

class TvRecommendationsCubit extends Cubit<TvRecommendationsState> {
  final GetTvSeriesRecommendations getTvSeriesRecommendations;

  TvRecommendationsCubit(this.getTvSeriesRecommendations)
      : super(TvRecommendationsInitial());

  void fetchTvRecommendations(int id) async {
    emit(TvRecommendationsLoading());
    final recommendationsResult = await getTvSeriesRecommendations.execute(id);

    recommendationsResult.fold(
      (failure) {
        emit(TvRecommendationsError(failure.message));
      },
      (movies) {
        emit(TvRecommendationsHasData(movies));
      },
    );
  }
}
