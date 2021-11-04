import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';

part 'movie_recommendations_state.dart';

class MovieRecommendationsCubit extends Cubit<MovieRecommendationsState> {
  final GetMovieRecommendations getMovieRecommendations;

  MovieRecommendationsCubit(this.getMovieRecommendations)
      : super(MovieRecomendationsInitial());

  void fetchMovieRecommendations(int id) async {
    emit(MovieRecommandationsLoading());
    final recommendationsResult = await getMovieRecommendations.execute(id);

    recommendationsResult.fold(
      (failure) {
        emit(MovieRecommandationsError(failure.message));
      },
      (movies) {
        emit(MovieRecommandationsHasData(movies));
      },
    );
  }
}
