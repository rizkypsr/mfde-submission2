import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/usecases/get_now_playing_tv_series.dart';

part 'now_playing_tv_state.dart';

class NowPlayingTvCubit extends Cubit<NowPlayingTvState> {
  NowPlayingTvCubit(this.getNowPlayingTvSeries) : super(NowPlayingTvInitial());

  final GetNowPlayingTvSeries getNowPlayingTvSeries;

  void fetchNowPlayingTv() async {
    emit(NowPlayingTvLoading());
    final result = await getNowPlayingTvSeries.execute();

    result.fold((failure) async {
      emit(NowPlayingTvError(failure.message));
    }, (data) async {
      emit(NowPlayingTvHasData(data));
    });
  }
}
