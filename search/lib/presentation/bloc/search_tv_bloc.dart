import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/domain/usecases/search_tv_series.dart';
import 'package:tv/tv.dart';
import 'package:rxdart/rxdart.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTvSeries searchTvSeries;

  SearchTvBloc(this.searchTvSeries) : super(SearchTvInitial());

  @override
  Stream<SearchTvState> mapEventToState(SearchTvEvent event) async* {
    if (event is OnTvQueryChanged) {
      final query = event.query;

      yield SearchTvLoading();
      final result = await searchTvSeries.execute(query);

      yield* result.fold(
        (failure) async* {
          yield SearchTvError(failure.message);
        },
        (data) async* {
          yield SearchTvHasData(data);
        },
      );
    }
  }

  @override
  Stream<Transition<SearchTvEvent, SearchTvState>> transformEvents(
      Stream<SearchTvEvent> events, transitionFn) {
    return events
        .debounceTime(const Duration(milliseconds: 300))
        .switchMap((transitionFn));
  }
}
