import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:search/domain/usecases/search_movies.dart';

part 'search_movie_state.dart';

class SearchMovieCubit extends Cubit<SearchMovieState> {
  final SearchMovies searchMovies;

  SearchMovieCubit(this.searchMovies) : super(SearchMovieInitial());

  void onQueryChanged(String query) async {
    emit(SearchMovieLoading());

    final result = await searchMovies.execute(query);

    result.fold(
      (failure) {
        emit(SearchMovieError(failure.message));
      },
      (data) {
        emit(SearchMovieHasData(data));
      },
    );
  }
}
