import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';

part 'now_playing_movies_state.dart';

class NowPlayingMoviesCubit extends Cubit<MovieListState> {
  NowPlayingMoviesCubit({required this.getNowPlayingMovies})
      : super(MovieListInitial());

  final GetNowPlayingMovies getNowPlayingMovies;

  void fetchNowPlayingMovies() async {
    emit(MovieListLoading());
    final result = await getNowPlayingMovies.execute();

    result.fold((failure) async {
      emit(MovieListError(failure.message));
    }, (data) async {
      emit(MovieListHasData(data));
    });
  }
}
