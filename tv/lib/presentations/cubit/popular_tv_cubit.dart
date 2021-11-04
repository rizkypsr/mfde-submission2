import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/usecases/get_popular_tv_series.dart';

part 'popular_tv_state.dart';

class PopularTvCubit extends Cubit<PopularTvState> {
  PopularTvCubit(this.getPopularTvSeries) : super(PopularTvInitial());

  final GetPopularTvSeries getPopularTvSeries;

  void fetchPopularTvSeries() async {
    emit(PopularTvLoading());
    final result = await getPopularTvSeries.execute();

    result.fold((failure) async {
      emit(PopularTvError(failure.message));
    }, (data) async {
      emit(PopularTvHasData(data));
    });
  }
}
