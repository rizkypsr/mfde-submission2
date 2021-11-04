import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/usecases/get_top_rated_tv_series.dart';

part 'top_rated_tv_state.dart';

class TopRatedTvCubit extends Cubit<TopRatedTvState> {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TopRatedTvCubit(this.getTopRatedTvSeries) : super(TopRatedTvInitial());

  void fetchTopRatedTv() async {
    emit(TopRatedTvLoading());
    final result = await getTopRatedTvSeries.execute();

    result.fold((failure) async {
      emit(TopRatedTvError(failure.message));
    }, (data) async {
      emit(TopRatedTvHasData(data));
    });
  }
}
