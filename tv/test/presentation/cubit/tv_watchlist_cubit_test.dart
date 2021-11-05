import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:tv/domain/usecases/save_watchlist_tv_series.dart';
import 'package:tv/presentations/cubit/tv_watchlist_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_watchlist_cubit_test.mocks.dart';

@GenerateMocks([
  GetWatchListTvSeriesStatus,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries
])
void main() {
  late TvWatchlistCubit tvWatchlistCubit;
  late MockGetWatchListTvSeriesStatus mockGetWatchListTvSeriesStatus;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;

  setUp(() {
    mockGetWatchListTvSeriesStatus = MockGetWatchListTvSeriesStatus();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    tvWatchlistCubit = TvWatchlistCubit(
        getWatchListTvSeriesStatus: mockGetWatchListTvSeriesStatus,
        removeWatchlistTvSeries: mockRemoveWatchlistTvSeries,
        saveWatchlistTvSeries: mockSaveWatchlistTvSeries);
  });

  const tId = 1;

  group('Watchlist', () {
    test('initialState should be Empty', () {
      expect(tvWatchlistCubit.state, TvWatchlistInitial());
    });

    blocTest<TvWatchlistCubit, TvWatchlistState>(
        'should emit TvWatchlistStatus when request is success',
        build: () {
          when(mockGetWatchListTvSeriesStatus.execute(tId))
              .thenAnswer((_) async => true);

          return tvWatchlistCubit;
        },
        act: (cubit) => cubit.loadWatchlistStatus(tId),
        expect: () => [const TvWatchlistStatus(true)],
        verify: (_) {
          verify(mockGetWatchListTvSeriesStatus.execute(tId));
        });

    blocTest<TvWatchlistCubit, TvWatchlistState>(
        'should emit MovieWatchlistMessage(Added To Watchlist) when successfully added',
        build: () {
          when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
              .thenAnswer((_) async => const Right('Added To Watchlist'));
          when(mockGetWatchListTvSeriesStatus.execute(tId))
              .thenAnswer((_) async => true);

          return tvWatchlistCubit;
        },
        act: (cubit) => cubit.addToWatchlist(testTvSeriesDetail),
        expect: () => [
              const TvWatchlistMessage('Added To Watchlist'),
              const TvWatchlistStatus(true)
            ],
        verify: (_) {
          verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
        });

    blocTest<TvWatchlistCubit, TvWatchlistState>(
        'should emit MovieWatchlistMessage(Removed) when successfully removed',
        build: () {
          when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
              .thenAnswer((_) async => const Right('Removed'));
          when(mockGetWatchListTvSeriesStatus.execute(tId))
              .thenAnswer((_) async => false);

          return tvWatchlistCubit;
        },
        act: (cubit) => cubit.removeFromWathlist(testTvSeriesDetail),
        expect: () => [
              const TvWatchlistMessage('Removed'),
              const TvWatchlistStatus(false)
            ],
        verify: (_) {
          verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
        });

    blocTest<TvWatchlistCubit, TvWatchlistState>(
        'should emit MovieWatchlistMessage(Added To Watchlist) when successfully added',
        build: () {
          when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
              .thenAnswer((_) async => const Left(DatabaseFailure('Failure')));
          when(mockGetWatchListTvSeriesStatus.execute(tId))
              .thenAnswer((_) async => false);

          return tvWatchlistCubit;
        },
        act: (cubit) => cubit.addToWatchlist(testTvSeriesDetail),
        expect: () => [
              const TvWatchlistMessage('Failure'),
              const TvWatchlistStatus(false)
            ],
        verify: (_) {
          verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
        });

    blocTest<TvWatchlistCubit, TvWatchlistState>(
        'should emit MovieWatchlistMessage(Added To Watchlist) when failed remove',
        build: () {
          when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
              .thenAnswer((_) async => const Left(DatabaseFailure('Failure')));
          when(mockGetWatchListTvSeriesStatus.execute(tId))
              .thenAnswer((_) async => false);

          return tvWatchlistCubit;
        },
        act: (cubit) => cubit.removeFromWathlist(testTvSeriesDetail),
        expect: () => [
              const TvWatchlistMessage('Failure'),
              const TvWatchlistStatus(false)
            ],
        verify: (_) {
          verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
        });
  });
}
