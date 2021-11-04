import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tv/domain/entities/tv_season_detail.dart';
import 'package:tv/domain/usecases/get_tv_series_season_detail.dart';

part 'tv_season_detail_state.dart';

class TvSeasonDetailCubit extends Cubit<TvSeasonDetailState> {
  final GetTvSeriesSeasonDetail getTvSeriesSeasonDetail;

  TvSeasonDetailCubit(this.getTvSeriesSeasonDetail)
      : super(TvSeasonDetailInitial());

  void fetchTvSeasonDetail(int tvId, int seasonNumber) async {
    emit(TvSeasonDetailLoading());

    final detailResult =
        await getTvSeriesSeasonDetail.execute(tvId, seasonNumber);

    detailResult.fold((failure) {
      emit(TvSeasonDetailError(failure.message));
    }, (tvSeriesSeason) {
      emit(TvSeasonDetailHasData(tvSeriesSeason));
    });
  }
}
