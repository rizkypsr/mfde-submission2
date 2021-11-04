import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:search/domain/usecases/search_tv_series.dart';
import 'package:search/search.dart';
import 'package:tv/tv.dart';

part 'search_tv_state.dart';

class SearchTvCubit extends Cubit<SearchTvState> {
  final SearchTvSeries searchTvSeries;

  SearchTvCubit(this.searchTvSeries) : super(SearchTvInitial());

  void onQueryChanged(String query) async {
    emit(SearchTvLoading());

    final result = await searchTvSeries.execute(query);

    result.fold(
      (failure) {
        emit(SearchTvError(failure.message));
      },
      (data) {
        emit(SearchTvHasData(data));
      },
    );
  }
}
