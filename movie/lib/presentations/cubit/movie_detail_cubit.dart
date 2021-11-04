import 'package:bloc/bloc.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/presentations/cubit/movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit(
      {required this.getMovieDetail, required this.getMovieRecommendations})
      : super(MovieDetailInitial());

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;

  void fetchMovieDetail(int id) async {
    emit(MovieDetailLoading());
    final detailResult = await getMovieDetail.execute(id);

    detailResult.fold(
      (failure) {
        emit(MovieDetailError(failure.message));
      },
      (movie) {
        emit(MovieDetailHasData(movie));
      },
    );
  }
}
