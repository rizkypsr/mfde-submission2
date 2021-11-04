import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_series.dart';
import 'package:tv/domain/usecases/get_now_playing_tv_series.dart';
import 'package:tv/presentations/cubit/now_playing_tv_cubit.dart';

import 'now_playing_tv_cubit_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries])
void main() {
  late NowPlayingTvCubit nowPlayingTvCubit;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;

  setUp(() {
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    nowPlayingTvCubit = NowPlayingTvCubit(mockGetNowPlayingTvSeries);
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

  group('now playing tv series', () {
    test('initialState should be Empty', () {
      expect(nowPlayingTvCubit.state, NowPlayingTvInitial());
    });

    blocTest<NowPlayingTvCubit, NowPlayingTvState>(
        'should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetNowPlayingTvSeries.execute())
              .thenAnswer((_) async => Right(tTvSeriesList));

          return nowPlayingTvCubit;
        },
        act: (cubit) => cubit.fetchNowPlayingTv(),
        expect: () => [
              NowPlayingTvLoading(),
              NowPlayingTvHasData(tTvSeriesList),
            ],
        verify: (bloc) {
          verify(mockGetNowPlayingTvSeries.execute());
        });

    blocTest<NowPlayingTvCubit, NowPlayingTvState>(
        'should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockGetNowPlayingTvSeries.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));

          return nowPlayingTvCubit;
        },
        act: (cubit) => cubit.fetchNowPlayingTv(),
        expect: () => [
              NowPlayingTvLoading(),
              const NowPlayingTvError('Server Failure'),
            ],
        verify: (_) {
          verify(mockGetNowPlayingTvSeries.execute());
        });
  });
}
