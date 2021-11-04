import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tv_series.dart';
import 'package:search/search.dart';
import 'package:tv/tv.dart';

import 'search_tv_bloc_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late SearchTvCubit searchCubit;
  late MockSearchTvSeries mockSearchTvSeries;

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    searchCubit = SearchTvCubit(mockSearchTvSeries);
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
      expect(searchCubit.state, SearchTvInitial());
    });

    blocTest<SearchTvCubit, SearchTvState>(
        'should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockSearchTvSeries.execute(tQuery))
              .thenAnswer((_) async => Right(tTvSeriesList));

          return searchCubit;
        },
        act: (cubit) => cubit.onQueryChanged(tQuery),
        wait: const Duration(milliseconds: 500),
        expect: () => [
              SearchTvLoading(),
              SearchTvHasData(tTvSeriesList),
            ],
        verify: (bloc) {
          verify(mockSearchTvSeries.execute(tQuery));
        });

    blocTest<SearchTvCubit, SearchTvState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSearchTvSeries.execute(tQuery)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return searchCubit;
      },
      act: (cubit) => cubit.onQueryChanged(tQuery),
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
