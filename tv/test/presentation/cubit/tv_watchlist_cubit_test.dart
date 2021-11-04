import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:tv/domain/usecases/save_watchlist_tv_series.dart';
import 'package:tv/presentations/cubit/tv_watchlist_cubit.dart';

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
  });
}
