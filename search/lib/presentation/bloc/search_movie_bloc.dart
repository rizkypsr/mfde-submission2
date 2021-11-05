import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:rxdart/rxdart.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies searchMovies;

  SearchMovieBloc(this.searchMovies) : super(SearchMovieInitial());

  @override
  Stream<SearchMovieState> mapEventToState(SearchMovieEvent event) async* {
    if (event is OnMovieQueryChanged) {
      final query = event.query;

      yield SearchMovieLoading();
      final result = await searchMovies.execute(query);

      yield* result.fold(
        (failure) async* {
          yield SearchMovieError(failure.message);
        },
        (data) async* {
          yield SearchMovieHasData(data);
        },
      );
    }
  }

  @override
  Stream<Transition<SearchMovieEvent, SearchMovieState>> transformEvents(
      Stream<SearchMovieEvent> events, transitionFn) {
    return events
        .debounceTime(const Duration(milliseconds: 300))
        .switchMap((transitionFn));
  }
}
