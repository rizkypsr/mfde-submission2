import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/movie.dart';

part 'watchlist_state.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistCubit(this.getWatchlistMovies) : super(WatchlistInitial());

  void fetchWatchlist() async {
    emit(WatchlistLoading());

    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) {
        emit(WatchlistError(failure.message));
      },
      (moviesData) {
        emit(WatchlistHasData(moviesData));
      },
    );
  }
}
