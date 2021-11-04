import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tv/domain/entities/tv_series_detail.dart';
import 'package:tv/domain/usecases/get_tv_series_detail.dart';
import 'package:tv/domain/usecases/get_tv_series_recommendations.dart';

part 'tv_detail_state.dart';

class TvDetailCubit extends Cubit<TvDetailState> {
  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;

  TvDetailCubit(
      {required this.getTvSeriesDetail,
      required this.getTvSeriesRecommendations})
      : super(TvDetailInitial());

  void fetchTvDetail(int id) async {
    emit(TvDetailLoading());
    final detailResult = await getTvSeriesDetail.execute(id);

    detailResult.fold(
      (failure) {
        emit(TvDetailError(failure.message));
      },
      (movie) {
        emit(TvDetailHasData(movie));
      },
    );
  }
}
