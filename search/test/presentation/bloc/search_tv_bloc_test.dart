import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tv_series.dart';
import 'package:search/presentation/bloc/search_tv_bloc.dart';
import 'package:tv/tv.dart';

import 'search_tv_bloc_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late SearchTvBloc searchTvBloc;
  late MockSearchTvSeries mockSearchTvSeries;

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    searchTvBloc = SearchTvBloc(mockSearchTvSeries);
  });

  final tTvSeriesModel = TvSeries(
    backdropPath: 'backdropPath',
    genreIds: const [1],
    id: 1,
    originalName: 'The Witcher',
    overview: 'overview',
    popularity: 60.441,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'The Witcher',
    voteAverage: 1,
    voteCount: 1,
  );
  final tTvSeriesList = <TvSeries>[tTvSeriesModel];
  const tQuery = 'witcher';

  group('Search Tv', () {
    test('initial state should be empty', () {
      expect(searchTvBloc.state, SearchTvInitial());
    });

    blocTest<SearchTvBloc, SearchTvState>(
        'should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockSearchTvSeries.execute(tQuery))
              .thenAnswer((_) async => Right(tTvSeriesList));

          return searchTvBloc;
        },
        act: (bloc) => bloc.add(const OnTvQueryChanged(tQuery)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
              SearchTvLoading(),
              SearchTvHasData(tTvSeriesList),
            ],
        verify: (bloc) {
          verify(mockSearchTvSeries.execute(tQuery));
        });

    blocTest<SearchTvBloc, SearchTvState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSearchTvSeries.execute(tQuery)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return searchTvBloc;
      },
      act: (bloc) => bloc.add(const OnTvQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchTvLoading(),
        const SearchTvError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchTvSeries.execute(tQuery));
      },
    );
  });
}
