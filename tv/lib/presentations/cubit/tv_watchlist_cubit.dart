import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tv/domain/entities/tv_series_detail.dart';
import 'package:tv/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:tv/domain/usecases/save_watchlist_tv_series.dart';

part 'tv_watchlist_state.dart';

class TvWatchlistCubit extends Cubit<TvWatchlistState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchListTvSeriesStatus getWatchListTvSeriesStatus;
  final SaveWatchlistTvSeries saveWatchlistTvSeries;
  final RemoveWatchlistTvSeries removeWatchlistTvSeries;

  TvWatchlistCubit(
      {required this.getWatchListTvSeriesStatus,
      required this.saveWatchlistTvSeries,
      required this.removeWatchlistTvSeries})
      : super(TvWatchlistInitial());

  void loadWatchlistStatus(int id) async {
    final result = await getWatchListTvSeriesStatus.execute(id);
    emit(TvWatchlistStatus(result));
  }

  void addToWatchlist(TvSeriesDetail tvSeriesDetail) async {
    final result = await saveWatchlistTvSeries.execute(tvSeriesDetail);

    await result.fold(
      (failure) async {
        emit(TvWatchlistMessage(failure.message));
      },
      (successMessage) async {
        emit(TvWatchlistMessage(successMessage));
      },
    );

    loadWatchlistStatus(tvSeriesDetail.id);
  }

  void removeFromWathlist(TvSeriesDetail tvSeriesDetail) async {
    final result = await removeWatchlistTvSeries.execute(tvSeriesDetail);

    await result.fold(
      (failure) async {
        emit(TvWatchlistMessage(failure.message));
      },
      (successMessage) async {
        emit(TvWatchlistMessage(successMessage));
      },
    );

    loadWatchlistStatus(tvSeriesDetail.id);
  }
}
