import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';

part 'popular_movies_state.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  PopularMoviesCubit({required this.getPopularMovies})
      : super(PopularMoviesInitial());

  final GetPopularMovies getPopularMovies;

  void fetchPopularMovies() async {
    emit(PopularMoviesLoading());
    final result = await getPopularMovies.execute();

    result.fold((failure) async {
      emit(PopularMoviesError(failure.message));
    }, (data) async {
      emit(PopularMoviesHasData(data));
    });
  }
}
