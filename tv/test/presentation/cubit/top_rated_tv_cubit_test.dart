import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/usecases/get_top_rated_tv_series.dart';
import 'package:tv/presentations/cubit/top_rated_tv_cubit.dart';

import 'top_rated_tv_cubit_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late TopRatedTvCubit topRatedTvCubit;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    topRatedTvCubit = TopRatedTvCubit(mockGetTopRatedTvSeries);
  });

  final tTvSeries = TvSeries(
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('top rated tv series', () {
    test('initialState should be Empty', () {
      expect(topRatedTvCubit.state, TopRatedTvInitial());
    });

    blocTest<TopRatedTvCubit, TopRatedTvState>(
        'should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetTopRatedTvSeries.execute())
              .thenAnswer((_) async => Right(tTvSeriesList));

          return topRatedTvCubit;
        },
        act: (cubit) => cubit.fetchTopRatedTv(),
        expect: () => [
              TopRatedTvLoading(),
              TopRatedTvHasData(tTvSeriesList),
            ],
        verify: (_) {
          verify(mockGetTopRatedTvSeries.execute());
        });

    blocTest<TopRatedTvCubit, TopRatedTvState>(
        'should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockGetTopRatedTvSeries.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));

          return topRatedTvCubit;
        },
        act: (cubit) => cubit.fetchTopRatedTv(),
        expect: () => [
              TopRatedTvLoading(),
              const TopRatedTvError('Server Failure'),
            ],
        verify: (_) {
          verify(mockGetTopRatedTvSeries.execute());
        });
  });
}
