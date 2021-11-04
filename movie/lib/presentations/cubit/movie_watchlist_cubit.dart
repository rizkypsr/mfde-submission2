import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_watchlist_movie_status.dart';
import 'package:movie/domain/usecases/remove_watchlist_movie.dart';
import 'package:movie/domain/usecases/save_watchlist_movie.dart';

part 'movie_watchlist_state.dart';

class MovieWatchlistCubit extends Cubit<MovieWatchlistState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  MovieWatchlistCubit(
      {required this.getWatchListMovieStatus,
      required this.saveWatchlistMovie,
      required this.removeWatchlistMovie})
      : super(MovieWatchlistInitial());

  final GetWatchListMovieStatus getWatchListMovieStatus;
  final SaveWatchlistMovie saveWatchlistMovie;
  final RemoveWatchlistMovie removeWatchlistMovie;

  void loadWatchlistStatus(int id) async {
    final result = await getWatchListMovieStatus.execute(id);
    emit(MovieWatchlistStatus(result));
  }

  void addToWatchlist(MovieDetail movieDetail) async {
    final result = await saveWatchlistMovie.execute(movieDetail);

    await result.fold(
      (failure) async {
        emit(MovieWatchlistMessage(failure.message));
      },
      (successMessage) async {
        emit(MovieWatchlistMessage(successMessage));
      },
    );

    loadWatchlistStatus(movieDetail.id);
  }

  void removeFromWathlist(MovieDetail movieDetail) async {
    final result = await removeWatchlistMovie.execute(movieDetail);

    await result.fold(
      (failure) async {
        emit(MovieWatchlistMessage(failure.message));
      },
      (successMessage) async {
        emit(MovieWatchlistMessage(successMessage));
      },
    );

    loadWatchlistStatus(movieDetail.id);
  }
}
