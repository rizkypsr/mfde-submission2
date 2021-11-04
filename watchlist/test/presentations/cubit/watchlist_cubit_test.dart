import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';
import 'package:watchlist/presentations/cubit/watchlist_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_cubit_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistCubit watchlistCubit;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistCubit = WatchlistCubit(mockGetWatchlistMovies);
  });

  group('Watchlist', () {
    test('initialState should be Empty', () {
      expect(watchlistCubit.state, WatchlistInitial());
    });
    blocTest<WatchlistCubit, WatchlistState>(
        'should emits [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((_) async => Right([testWatchlistMovie]));

          return watchlistCubit;
        },
        act: (cubit) => cubit.fetchWatchlist(),
        expect: () => [
              WatchlistLoading(),
              WatchlistHasData([testWatchlistMovie])
            ],
        verify: (_) {
          verify(mockGetWatchlistMovies.execute());
        });

    blocTest<WatchlistCubit, WatchlistState>(
        'should emits [Error] when data is unsuccessful',
        build: () {
          when(mockGetWatchlistMovies.execute()).thenAnswer(
              (_) async => const Left(DatabaseFailure("Can't get data")));

          return watchlistCubit;
        },
        act: (cubit) => cubit.fetchWatchlist(),
        expect: () =>
            [WatchlistLoading(), const WatchlistError("Can't get data")],
        verify: (_) {
          verify(mockGetWatchlistMovies.execute());
        });
  });
}
