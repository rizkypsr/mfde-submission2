import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/usecases/get_popular_tv_series.dart';
import 'package:tv/presentations/cubit/popular_tv_cubit.dart';

import 'popular_tv_cubit_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late PopularTvCubit popularTvCubit;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    popularTvCubit = PopularTvCubit(mockGetPopularTvSeries);
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

  group('popular tv series', () {
    test('initialState should be Empty', () {
      expect(popularTvCubit.state, PopularTvInitial());
    });

    blocTest<PopularTvCubit, PopularTvState>(
        'should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetPopularTvSeries.execute())
              .thenAnswer((_) async => Right(tTvSeriesList));

          return popularTvCubit;
        },
        act: (cubit) => cubit.fetchPopularTvSeries(),
        expect: () => [
              PopularTvLoading(),
              PopularTvHasData(tTvSeriesList),
            ],
        verify: (bloc) {
          verify(mockGetPopularTvSeries.execute());
        });

    blocTest<PopularTvCubit, PopularTvState>(
        'should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockGetPopularTvSeries.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));

          return popularTvCubit;
        },
        act: (cubit) => cubit.fetchPopularTvSeries(),
        expect: () => [
              PopularTvLoading(),
              const PopularTvError('Server Failure'),
            ],
        verify: (_) {
          verify(mockGetPopularTvSeries.execute());
        });
  });
}
